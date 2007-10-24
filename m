From: Tharmarajan G <tharma@e-consystems.com>
Subject: Re: aplay appication failed to open the alsa device
Date: Wed, 24 Oct 2007 11:08:15 +0530
Message-ID: <1193204295.2827.28.camel@tharma.e-con>
References: <1193200898.2827.18.camel@tharma.e-con>
Reply-To: tharma@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms1.worldwebleaders.com (ms1.worldwebleaders.com [69.50.223.62])
	by alsa0.perex.cz (Postfix) with ESMTP id A1ABE24491
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 07:38:56 +0200 (CEST)
In-Reply-To: <1193200898.2827.18.camel@tharma.e-con>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: maharajan <maharajan@e-consystems.com>
List-Id: alsa-devel@alsa-project.org


	I tried to send the mp3 file directly to the device by using the cat
command. But it failed to play the mp3 file


[root@SIRIUS /tmp]#cat /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
>/dev/snd/pcmC0D0p
playback_open
cat: Write Error: File descriptor in bad state
hw_free
snd_card_pxa_tsc2301_playback_close
[root@SIRIUS /tmp]#



On Wed, 2007-10-24 at 10:11 +0530, Tharmarajan G wrote:

> Hi,
> 	I am working on a Development Board which has the PXA270 processor and
> TSC2301 Audio Codec Chip. 
> 
> 	The TSC2301 Chip is interfaced with the processor by SPI interface for
> reading/writing the TSC2301's registers. 
> 
> 	The TSC2301 Chip is interfaced with the processor by I2S interface for
> sending/receiving Audio Data to/from the TSC2301 Audio Codec Chip.
> 
> 	I have downloaded the pxa-uda1380.c alsa driver source for uda1380
> audio codec chip and modified it for tsc2301 . 
> 
> 	I am using the kernel version 2.6.22 and cross-compiler version
> arm-linux-gcc 3.4.1. 
> 
> 	I have built the kernel image with ALSA audio support and the
> applications aplay and arecord for playing and recording audio data
> using ALSA api.
> 
> 	I have got the alsa related entries in the /proc filesystem . But when
> playing the aplay, it failed to open the device.
> 
> [root@SIRIUS /flash2]#./aplay /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:545: audio open error: No such file or directory
> [root@SIRIUS /flash2]#
> 
> /aplay
> -D /dev/snd/pcmC0D0p /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown
> PCM /dev/snd/pcmC0D0p
> aplay: main:545: audio open error: No such file or directory
> 
> 
> What could be the issue ? Am I missing anyting in the driver for alsa ? 
> 
> 
> Regards,
> Tharmarajan G
> 	
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
