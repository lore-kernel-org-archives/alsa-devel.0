From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: Have multiple opens removed on one device?
Date: Thu, 1 Sep 2011 11:43:09 +0800
Message-ID: <CAHG8p1BupAyLzNe4jB2W0DKBq1z3njgU4d+KPWma4AbqCyuQOw@mail.gmail.com>
References: <CAHG8p1BRN365PTyDxh-6UFWKtf_M-WcVZDGmuXB0W+CjTgPNGQ@mail.gmail.com>
	<s5hipppsqe9.wl%tiwai@suse.de>
	<20110822112143.GB9232@opensource.wolfsonmicro.com>
	<CAHG8p1B4b+F_Uoo8+QTn_g3XDF6AcW-WdfsyovsEupJLUZQxVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id BEBB824630
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 05:43:10 +0200 (CEST)
Received: by qyk34 with SMTP id 34so3917153qyk.17
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2011 20:43:09 -0700 (PDT)
In-Reply-To: <CAHG8p1B4b+F_Uoo8+QTn_g3XDF6AcW-WdfsyovsEupJLUZQxVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/8/29 Scott Jiang <scott.jiang.linux@gmail.com>:
>
> Indeed we use dmix. But now we can't open the same device twice.
> Our alsa lib and utils version is 1.0.18.
> The test command: aplay 1.wav &; aplay 1.wav
> In 2.6.34, strace
> open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 4
> open("/dev/snd/pcmC0D0p", O_RDWR|O_APPEND|O_NONBLOCK) = 4
>
> In 3.0, strace
> open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 4
> open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = -1 EBUSY (Device or
> resource busy)
>
> The O_APPEND flag missed in new kernel. But we use the same lib and
> utils. It's strange.
> And I found the prefer subdevice changes from 0 to -1. These two
> changes cause kernel return device busy.
>
> Mark, can you do this simple test on your board? I appreciate your
> help. Thank you very much.
>

I know the reason. The card config file didn't read properly.
Asoc doesn't copy codec name to card->driver now. I guess it is
because multiple codecs are supported.
I add driver_name in my snd_soc_card to solve this bug. But I scan
other drivers in asoc, nobody did this.
Maybe nobody are aware of this. Are there any better way to solve this bug?

Regards,
Scott
