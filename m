From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: Use scnprintf() instead of snprintf()
Date: Tue, 27 Feb 2018 20:09:38 +0900
Message-ID: <368fc7e7-9517-8766-acee-4512bebb34b4@sakamocchi.jp>
References: <1519697759-31062-1-git-send-email-climbbb.kim@gmail.com>
 <6fa09080-a0f4-c3c1-20c0-69baa00dbc38@sakamocchi.jp>
 <CAL6iAaLHC3u3vuCsE8OY8sLH+M0AwpxxAGWARN34c4M5L0oW1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0C5E0267684
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 12:09:44 +0100 (CET)
In-Reply-To: <CAL6iAaLHC3u3vuCsE8OY8sLH+M0AwpxxAGWARN34c4M5L0oW1Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 27 2018 15:12, Jaejoong Kim wrote:
>> We can see below explanation in 'Documentation/filesystems
>> /sysfs.txt'[1]:
>>
>> ```
>> - show() methods should return the number of bytes printed into the
>>    buffer. This is the return value of scnprintf().
>>
>> - show() must not use snprintf() when formatting the value to be
>>    returned to user space. If you can guarantee that an overflow
>>    will never happen you can use sprintf() otherwise you must use
>>    scnprintf().
>> ```
>>
>> Actually, 'snprintf()' returns written bytes excluding trailing _null_
>> byte for end output to strings and we need to use 'scnprintf()'.
> 
> Strictly speaking, that is half the truth.
> 
> snprintf() does not return the length actually written to the buffer,
> but rather to
> return the length that it was intended to be written to. So, in case
> of the formated
> buffer size is much bigger, 'snprintf()' will return formated buffer
> size not written bytes.
> 
> Please refer to the LWN about snprintf
> https://lwn.net/Articles/69419/
> 
> I do NOT think the original codes will happen if snprintf() return a
> number larger than PAGE_SIZE.
> Nevertheless, it is better to use scnprintf () for the show method
> because of the snprintf () behavior.

Ah... Exactly. I failed to get your intention, sorry... (I should have 
read your commit comment carefully...)


Thanks

Takashi Sakamoto
