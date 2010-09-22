From: Philip Balister <philip@balister.org>
Subject: Re: ASoC how to modify audio IC register values
Date: Wed, 22 Sep 2010 16:55:33 -0400
Message-ID: <i7dqg6$v7j$1@dough.gmane.org>
References: <8CD27E1B735BE77-18DC-119C@webmail-d060.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EAFA1037FB
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 23:00:08 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OyWQ9-0000WD-Pd
	for alsa-devel@alsa-project.org; Wed, 22 Sep 2010 23:00:05 +0200
Received: from pool-96-240-180-126.ronkva.east.verizon.net ([96.240.180.126])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 23:00:05 +0200
Received: from philip by pool-96-240-180-126.ronkva.east.verizon.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 23:00:05 +0200
In-Reply-To: <8CD27E1B735BE77-18DC-119C@webmail-d060.sysops.aol.com>
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

On 09/21/2010 04:21 PM, Almohanad Fayez wrote:
>
>
> Hi,  I'm running Alsa on an embedded platform, Beagleboard, which uses an OMAP3530 chip.  The platform uses the TWL4030 ASoC driver. I'm trying to find a way to modify the audio rate register values to force sampling rates other than 44.1 kHz and 48 kHz.  I'm running the Angstrom Linux Distro on the board.  Alsa is running fine on the board, I'm trying to avoid using "hw:0,0" to make sure that I'm running the audio chip at the specified rate instead of having ALSA resample my audio.  Currently I can see that the audio card supports only 48 kHz and 44.1 kHZ, but I know that it supports 32kHz and 16kHz.  I managed to find the Codec_Register listing under the /sys/ directory and I'm trying to set the "codec_reg" register to the proper value to run the chip at 32kHz.  Basically when I run "c
 at
>    /sys/devices/platform/soc-audio/codec_reg" register 0x1 reads 0x91 which from the datasheet means the sampling rate = 44.1kHz.  I'm trying to set register 0x1 to 0x81 to force it to run at
>   32 kHz.  but the "echo 1 81>  codec_reg" command is apparently not supported and from the angstrom the register is read-only I even tried chmod +w the register but that didn't work.
>
> I tried using debugfs to modify the register value unfortunately  the functionality isn't available through that.  I found a few listings online of ALSA patches that expose the register during debugfs, after copying and pasting them I still couldn't access the register.  When I tried modifying the twl4030.c driver in the openembedded directory linux-omap-2.6.28/git/audio/soc/twl4030.c  by basically hardcoding the reigster value to 0x81 it still didn't work.
>
> I'm running the 2.6.28 Linux kernel.  can anyone share some advice ???

I'm interested in the solution also. I'm familiar with the work Al is 
doing and have never found a satisfactory solution. The basic problem is 
we are receiving samples of digitized RF containing an FM radio signal. 
Due to contraints on the sample rates of the RF hardware we end up with 
audio at odd rates (such as 32K). If you let libsamplerate fix the rate, 
we us more processor than we have available.

If anyone knows if the Beagle hardware can support different sample 
rates and how to add support to the ALSA driver, I'd love to hear 
suggestions.

Philip
