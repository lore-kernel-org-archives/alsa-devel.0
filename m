From: Tharmarajan G <tharma@e-consystems.com>
Subject: aplay appication failed to open the alsa device
Date: Wed, 24 Oct 2007 10:11:38 +0530
Message-ID: <1193200898.2827.18.camel@tharma.e-con>
Reply-To: tharma@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms1.worldwebleaders.com (ms1.worldwebleaders.com [69.50.223.62])
	by alsa0.perex.cz (Postfix) with ESMTP id DB1AF24AF6
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 06:42:18 +0200 (CEST)
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
Cc: maharajan <maharajan@e-consystems.com>, tharma <tharma@e-consystems.com>
List-Id: alsa-devel@alsa-project.org

Hi,
	I am working on a Development Board which has the PXA270 processor and
TSC2301 Audio Codec Chip. 

	The TSC2301 Chip is interfaced with the processor by SPI interface for
reading/writing the TSC2301's registers. 

	The TSC2301 Chip is interfaced with the processor by I2S interface for
sending/receiving Audio Data to/from the TSC2301 Audio Codec Chip.

	I have downloaded the pxa-uda1380.c alsa driver source for uda1380
audio codec chip and modified it for tsc2301 . 

	I am using the kernel version 2.6.22 and cross-compiler version
arm-linux-gcc 3.4.1. 

	I have built the kernel image with ALSA audio support and the
applications aplay and arecord for playing and recording audio data
using ALSA api.

	I have got the alsa related entries in the /proc filesystem . But when
playing the aplay, it failed to open the device.

[root@SIRIUS /flash2]#./aplay /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:545: audio open error: No such file or directory
[root@SIRIUS /flash2]#

/aplay
-D /dev/snd/pcmC0D0p /usr/local/Songs/AjRaj-Anthimanthirai-Theme4.mp3
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown
PCM /dev/snd/pcmC0D0p
aplay: main:545: audio open error: No such file or directory


What could be the issue ? Am I missing anyting in the driver for alsa ? 


Regards,
Tharmarajan G
	
