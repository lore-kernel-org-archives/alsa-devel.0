From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: Bug? Sound support for at91sam9x5-wm8731 based
	boards
Date: Wed, 20 Nov 2013 11:22:10 +0100
Message-ID: <CACQ1gAhvS7PSbK0SuhrB8TPS8Rkd-AdqZ-=T+Ntjyx7PsR7XaQ@mail.gmail.com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
 <1384878685-1515-3-git-send-email-tony@atomide.com>
 <031f01cee547$950b5670$bf220350$@com>
 <CACQ1gAgykmgPKY4SHujnNtm4Sr=wt5knLkQL-MRS_pC73bOi4Q@mail.gmail.com>
 <033601cee552$7c2c2570$74847050$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 51D802615F3
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 11:22:31 +0100 (CET)
Received: by mail-la0-f47.google.com with SMTP id ep20so7040584lab.20
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 02:22:30 -0800 (PST)
In-Reply-To: <033601cee552$7c2c2570$74847050$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhong Li <zql@glomationinc.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

[added Nicolas Ferre and Bo Shen ]

2013/11/19 Zhong Li <zql@glomationinc.com>:
>> Can you give a little more background ? :
>> - What kernel ?
>> - Command line to reproduce ?
>>
>> Richard.
>
> One of the testing hardware is the Atmel at91sam9g25-ek (the CPU module and the carrier board).  We tried both the 2.6.39 patched with the Atmel patches and the mainline 3.12-rc.  The command to test the sound is just the simple aplay <sound-test-file>.  The wav file is available here, https://drive.google.com/file/d/0B3TSFX4Mq9PoeTdJOGVaZk5rTWM/edit?usp=sharing.
>
> Thanks

Ok, I reproduce the bug on g35-ek with a v3.11.7+(sam9x5 sound patches) kernel

So, *sometimes*,  the left and right channel are swapped. ( I found
also the ratio 1 out of 6 (but once it has happened, it seems to be
more often))
I tested that with the file given by Zhong Li, and with a file I
created with audacity (440Hz only on right channel).
I could see at the scope that the channels are swapped before the
w8731 codec (the data on the TD line are sometime on the low edge of
TF, instead of always being on the high edge (I2S mode)).
There's, in both cases, a clock period (TK) between the rising/falling
edge of TF and the 1st data bit on TD, so the mode is always I2S, and
the channel data are swapped.

I'll try to have a look (but I don't have much time right now)

If someone could test that on a sam9g20 or a WM8904 based board, since
they share the same DAI format, they may have the same problem.

Thanks !
Richard

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
