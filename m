From: Louis Lee <lwhlee@hotmail.com>
Subject: ALSA SoC driver playback twice as fast as desired
Date: Thu, 2 Jul 2009 16:24:17 -0600
Message-ID: <COL102-W20FDDBC628826434E806E9D02F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s1.col0.hotmail.com (col0-omc3-s1.col0.hotmail.com
	[65.55.34.139]) by alsa0.perex.cz (Postfix) with ESMTP id CEAB024603
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 00:24:31 +0200 (CEST)
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


  I've been developing an ALSA SoC driver for the past 3 weeks.

  The codec is a wolfsom WM8973 on a Freescale i.MX27 development platform.
  I've added SPI support to the existing (using i.MX27 platform SPI API -- not exactly portable) codec in the GIT repository.  In addition I wrote up the DAI (I2S over SSI bus) and the PCM portion of the driver which handles DMA transfers.
  I written the driver to reduce the number of factors to reduce the number of factors that would be causing any problems.  The files being played are all encoded for 48kHz.  The PLLs, MCLK and BCLK settings are all set to assume a sample rate of 48KHz.  Even the file is a mono file.
  However, when attempting to play the file back using SoX or aplay a self generated sine file made to play for 5 seconds always plays twice as fast.  The windows chimes file for instance (which is a 2 x 16 bit audio file) when played as a single channel file -- essentially doubling the play time (0.6 to 1.2 seconds) -- will end up playing properly.  The timer displayed by SoX is correct for that file.  However, when the file is played back it is obviously being pumped through too fast.
  I'm out of ideas as to where to look.  The DAI interface is set as a I2S slave.  The clock is mastered by the Codec (WM8974).  I've set up min_channels and max_channels to be 1 whereever possible.  On a scope the clocking seems to be at the right speed.  Why is it sound is playing twice as fast?  Any ideas?  Any help is appreciated.
  WM8974 is a mono codec.  The SSI bus on the i.MX27 is set to I2S slave mode with a 16 bit word length.  The word length on the codec is set to 16 bits.  The audio interface on the codec is set to I2S, sample rate coded to do only 48kHz.
THANK YOU
_________________________________________________________________
We are your photos. Share us now with Windows Live Photos.
http://go.microsoft.com/?linkid=9666047
