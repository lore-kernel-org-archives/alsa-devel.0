From: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Subject: Re: sound on smdk2410
Date: Tue, 29 May 2007 13:56:30 +0100
Message-ID: <1180443390.26317.6.camel@gg-desktop.wolfsonmicro.main>
References: <AC2729D6E3A3314A922E4E0FBE513F65D6BB03@MAIL.eldorado.org.br>
	<1180363166.5816.56.camel@a10072.wolfsonmicro.main>
	<AC2729D6E3A3314A922E4E0FBE513F65D6BCA3@MAIL.eldorado.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ED0624367
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 14:58:56 +0200 (CEST)
In-Reply-To: <AC2729D6E3A3314A922E4E0FBE513F65D6BCA3@MAIL.eldorado.org.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-05-29 at 08:50 -0300, Jose Henrique Spahn Torres wrote:
> 1. OSS app (and hence OSS emulation) is initially setting hw_params to
> 8kHz 16 bit mono (this may not be supported by the driver and thus
> hw_params returns EINVAL).
> 2. audio rate, channels, format is not supported by driver.
> 3. ARM gcc < 4.1.1 CSE bug.
> 
> Liam 
> 
> Hi Liam,
> the messages printed on the output are all the same (asoc:machine
> hw_params failed). It is printed tens of times...
> I couldn't play a .wav either.
> 
> I am using gcc 4.1.2, so it is not 3.
> 
> I will check 1 and 2 but I need some hints on where in the code this is
> set.
> 
Hi, -EINVAL for rate/channels can be returned in the hw_params path in
the drivers. So smdk2440.c uda1341.c or s3c24xx-i2s.c if any of them
decide the parameters are not valid.

Did you use aplay to play the .wav, can you tray aplay -f cd blah.wav

This selects 16bit, 2 channels, 441000 and from the looks of the drivers
should work fine.

Graeme
