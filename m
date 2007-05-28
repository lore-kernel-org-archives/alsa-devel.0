From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: sound on smdk2410
Date: Mon, 28 May 2007 15:39:26 +0100
Message-ID: <1180363166.5816.56.camel@a10072.wolfsonmicro.main>
References: <AC2729D6E3A3314A922E4E0FBE513F65D6BB03@MAIL.eldorado.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 9029924735
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 16:39:27 +0200 (CEST)
In-Reply-To: <AC2729D6E3A3314A922E4E0FBE513F65D6BB03@MAIL.eldorado.org.br>
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

On Mon, 2007-05-28 at 11:26 -0300, Jose Henrique Spahn Torres wrote:
> Hi,
> I am trying recent Zoltan Devai's patchs for kernel 2.6.22-rc2 on a
> smdk2410
> board. I reached the point where the kernel recognized the uda1341 sound
> chip,
> however, when I try to play something, I get the output below.
> Can anyone, please, show me the path to follow to get sound working?
> 
> Thanks,
> Henrique
> 
> 
> /home $ l
> drwxr-xr-x    3 root     root            0 Jan  1 00:00 .
> drwxr-xr-x   18 root     root         1024 May 18  2007 ..
> -r--r--r--    1 root     root      3419671 Jan  1  1970 jj.mp3
> /home $ mpg123 jj.mp3
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 anasoc:
> UDA1341 <-> s3c24xx-i2s info:
> asoc: rate mask 0xfe
> asoc: min ch 2 max ch 2
> asoc: min rate 8000 max rate 48000
> version 0.65; written and copyright by Michael Hipp and others
> free software (LGPL/GPL) without any warranty but with best wishes
> asoc: machine hw_params failed
> ...
> (lots of asoc: messages)
> ...
> asoc: machine hw_params failed

Could you attach all the messages. It's difficult to debug without them.

> 
> pop wq checking: Playback status: inactive waiting: yes
> pop wq D3 UDA1341 Playback
> 
> Playing MPEG stream 1 of 1: jj.mp3 ...
> Title:   Times Like These                Artist: Jack Johnson
> Comment:                                 Album:  On And On
> Year:    2003                            Genre:  Acoustic
> MPEG 1.0 layer III, 192 kbits/s, 44100 Hz stereo
> [audio.c:264] error: No supported rate found!
> /home $

Can you try playing a wav with aplay and send the results.

Imho, it could be 1 of three things atm.

1. OSS app (and hence OSS emulation) is initially setting hw_params to
8kHz 16 bit mono (this may not be supported by the driver and thus
hw_params returns EINVAL).
2. audio rate, channels, format is not supported by driver.
3. ARM gcc < 4.1.1 CSE bug.

Liam 
