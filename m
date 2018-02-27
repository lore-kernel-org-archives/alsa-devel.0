From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: [PATCH] ALSA: Use scnprintf() instead of snprintf()
Date: Tue, 27 Feb 2018 15:12:59 +0900
Message-ID: <CAL6iAaLHC3u3vuCsE8OY8sLH+M0AwpxxAGWARN34c4M5L0oW1Q@mail.gmail.com>
References: <1519697759-31062-1-git-send-email-climbbb.kim@gmail.com>
 <6fa09080-a0f4-c3c1-20c0-69baa00dbc38@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 89E3E267B04
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 07:13:01 +0100 (CET)
Received: by mail-it0-f66.google.com with SMTP id j7so12599890ita.3
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 22:13:01 -0800 (PST)
In-Reply-To: <6fa09080-a0f4-c3c1-20c0-69baa00dbc38@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi

Thanks for your reviewing.

2018-02-27 12:40 GMT+09:00 Takashi Sakamoto <o-takashi@sakamocchi.jp>:
> Hi,
>
> On Feb 27 2018 11:15, Jaejoong Kim wrote:
>>
>> The show() method should use scnprintf() not snprintf() because snprintf()
>> may returns a value that exceeds its second argument.
>>
>> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
>> ---
>>   sound/core/init.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/core/init.c b/sound/core/init.c
>> index 168ae03..4a51a06 100644
>> --- a/sound/core/init.c
>> +++ b/sound/core/init.c
>> @@ -670,7 +670,7 @@ card_id_show_attr(struct device *dev,
>>                   struct device_attribute *attr, char *buf)
>>   {
>>         struct snd_card *card = container_of(dev, struct snd_card,
>> card_dev);
>> -       return snprintf(buf, PAGE_SIZE, "%s\n", card->id);
>> +       return scnprintf(buf, PAGE_SIZE, "%s\n", card->id);
>>   }
>>     static ssize_t
>> @@ -710,7 +710,7 @@ card_number_show_attr(struct device *dev,
>>                      struct device_attribute *attr, char *buf)
>>   {
>>         struct snd_card *card = container_of(dev, struct snd_card,
>> card_dev);
>> -       return snprintf(buf, PAGE_SIZE, "%i\n", card->number);
>> +       return scnprintf(buf, PAGE_SIZE, "%i\n", card->number);
>>   }
>>     static DEVICE_ATTR(number, S_IRUGO, card_number_show_attr, NULL);
>
>
> In my opinion, original codes are good because it has a trailing '\n'
> instead of '\0'.

I agree with you.

>
> We can see below explanation in 'Documentation/filesystems
> /sysfs.txt'[1]:
>
> ```
> - show() methods should return the number of bytes printed into the
>   buffer. This is the return value of scnprintf().
>
> - show() must not use snprintf() when formatting the value to be
>   returned to user space. If you can guarantee that an overflow
>   will never happen you can use sprintf() otherwise you must use
>   scnprintf().
> ```
>
> Actually, 'snprintf()' returns written bytes excluding trailing _null_
> byte for end output to strings and we need to use 'scnprintf()'.

Strictly speaking, that is half the truth.

snprintf() does not return the length actually written to the buffer,
but rather to
return the length that it was intended to be written to. So, in case
of the formated
buffer size is much bigger, 'snprintf()' will return formated buffer
size not written bytes.

Please refer to the LWN about snprintf
https://lwn.net/Articles/69419/

I do NOT think the original codes will happen if snprintf() return a
number larger than PAGE_SIZE.
Nevertheless, it is better to use scnprintf () for the show method
because of the snprintf () behavior.

Thanks,
Jaejoong
>
> However, for our cases, the trailing letter is '\n' and 'snprintf()'
> counts correctly including it.
>
> Let's test:
>
> ```
> #include <stdio.h>
> #include <stdlib.h>
>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
>
> #include <unistd.h>
>
> #include <string.h>
> #include <errno.h>
>
> int main(int argc, char **argv)
> {
>     int fd;
>     char buf[8];
>     ssize_t len;
>
>     if (argc < 2) {
>         printf("At least, one argument is required for path to sysfs
> node.\n");
>         return EXIT_FAILURE;
>     }
>
>     fd = open(*(argv + 1), O_RDONLY);
>     if (fd < 0) {
>         printf("open(2): %s\n", strerror(errno));
>         return EXIT_FAILURE;
>     }
>
>     // 'C' is a canary.
>     memset(buf, 'C', sizeof(buf));
>
>     len = read(fd, buf, sizeof(buf));
>     if (len < 0) {
>         printf("read(2): %s\n", strerror(errno));
>         close(fd);
>         return EXIT_FAILURE;
>     }
>
>     printf("len = %zd\n", len);
>     for (int i = 0; i < sizeof(buf); ++i) {
>             printf("%02x\n", buf[i]);
>     }
>
>     close(fd);
>
>     return EXIT_SUCCESS;
> }
> ```
>
> ```
> $ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version k4.13.0-36-generic.
> $ /tmp/test
> '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/fw1/fw1.0/sound/card2/number'
> len = 2
> 32
> 0a
> 43
> 43
> 43
> 43
> 43
> 43
> $ /tmp/test
> '/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/fw1/fw1.0/sound/card2/id'
> len = 5
> 53
> 6f
> 6c
> 6f
> 0a
> 43
> 43
> 43
> ```
>
> Looks good.
>
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/sysfs.txt
>
>
> Thanks
>
> Takashi Sakamoto
