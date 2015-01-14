From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Correct rx format
 unit configuration
Date: Wed, 14 Jan 2015 14:24:08 +0100
Message-ID: <54B66DF8.6000806@gmail.com>
References: <1409817173-29234-1-git-send-email-peter.ujfalusi@ti.com>
 <54B64EC4.6040600@gmail.com> <54B6621C.7060505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
 [74.125.82.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 4539326156A
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 14:24:12 +0100 (CET)
Received: by mail-we0-f175.google.com with SMTP id k11so8732972wes.6
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 05:24:11 -0800 (PST)
In-Reply-To: <54B6621C.7060505@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 14.01.2015 13:33, Peter Ujfalusi wrote:
> On 01/14/2015 01:11 PM, Pascal Huerst wrote:
>> Hey Peter, all,
>>
>> the patch (8e3006d02b46a722729a3bbd6a774eae99c6c8b8), causes lots of
>> terrible noise on a custom built am33xx based board, if I map the input
>> to the output like so:
>>
>> arecord -f S16_LE -r 48000 -c2 -D hw:0,1 -F 0 --period-size=102
>> 4 -B 0 --buffer-size=4096 | aplay -D hw:0,0 -
> 
> FWIW the -F0 and -B0 is redundant and you can use -fdat instead of -f S16_LE
> -r 48000 -c2

Ok, good to know.

>> If I undo your changes, everything works fine. Tested with 3.14.23 and
>> 3.18.1.
> 
> You mean only this single commit?

Yes, even this single line.

- u32 rx_rotate = 0;
+ u32 rx_rotate = (32 - word_length) / 4;

>> Do you have any Idea, what might cause that behavior?
> 
> No, I don't. I quickly checked on am335x, am437x and on J6 boards and the
> command you are using works w/o any issue or distortion in recorded audio.

> what codec or codecs are you using? I see that you record from hw:0,1 and play
> it back to hw:0,0
> Can you check if the recorded sample alone is correct? Just record it to a
> file and look at it on the PC. I did the same and the recorded sample looks
> fine on my PC as well.

if I record into a file, it behaves just the same. Noise if
rx_rotate == 0, correct otherwise. I guess it is a problem in the input
codec, then.

input codec:   AK5386
output codec:  TAS5086

> Looking at the patch again, I still think it is a valid fix.

Yes, I agree, the patch looks right.

I'll have a look into the ak5386 and see, what impact your change could
have there.


thanks so far!
