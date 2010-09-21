From: Almohanad Fayez <alfayez@aol.com>
Subject: ASoC how to modify audio IC register values
Date: Tue, 21 Sep 2010 16:21:32 -0400
Message-ID: <8CD27E1B735BE77-18DC-119C@webmail-d060.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-da01.mx.aol.com (imr-da01.mx.aol.com [205.188.105.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D1EB2445B
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 22:21:57 +0200 (CEST)
Received: from imo-ma03.mx.aol.com (imo-ma03.mx.aol.com [64.12.78.138])
	by imr-da01.mx.aol.com (8.14.1/8.14.1) with ESMTP id o8LKLeIN007806
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 16:21:40 -0400
Received: from AlFayez@aol.com
	by imo-ma03.mx.aol.com  (mail_out_v42.9.) id 5.c28.6fa69517 (34954)
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 16:21:37 -0400 (EDT)
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
List-Id: alsa-devel@alsa-project.org



Hi,  I'm running Alsa on an embedded platform, Beagleboard, which uses an OMAP3530 chip.  The platform uses the TWL4030 ASoC driver. I'm trying to find a way to modify the audio rate register values to force sampling rates other than 44.1 kHz and 48 kHz.  I'm running the Angstrom Linux Distro on the board.  Alsa is running fine on the board, I'm trying to avoid using "hw:0,0" to make sure that I'm running the audio chip at the specified rate instead of having ALSA resample my audio.  Currently I can see that the audio card supports only 48 kHz and 44.1 kHZ, but I know that it supports 32kHz and 16kHz.  I managed to find the Codec_Register listing under the /sys/ directory and I'm trying to set the "codec_reg" register to the proper value to run the chip at 32kHz.  Basically when I run "cat
  /sys/devices/platform/soc-audio/codec_reg" register 0x1 reads 0x91 which from the datasheet means the sampling rate = 44.1kHz.  I'm trying to set register 0x1 to 0x81 to force it to run at 
 32 kHz.  but the "echo 1 81 > codec_reg" command is apparently not supported and from the angstrom the register is read-only I even tried chmod +w the register but that didn't work.

I tried using debugfs to modify the register value unfortunately  the functionality isn't available through that.  I found a few listings online of ALSA patches that expose the register during debugfs, after copying and pasting them I still couldn't access the register.  When I tried modifying the twl4030.c driver in the openembedded directory linux-omap-2.6.28/git/audio/soc/twl4030.c  by basically hardcoding the reigster value to 0x81 it still didn't work.

I'm running the 2.6.28 Linux kernel.  can anyone share some advice ???


al fayez
