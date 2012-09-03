From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC 0/3] Initial stab at converting OMAP ASoC support to DMA
	engine
Date: Mon, 3 Sep 2012 17:58:32 +0100
Message-ID: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: alsa-devel@alsa-project.org

The following series of three patches is an attempt to convert the OMAP
ASoC backend to use the DMA engine support.

I'll bring your attention to the comments in patch 3 which highlight
some of the features lost in this process.  Some questions need
answering there (in particular the one concerning pause/resume)
especially as it seems the present driver could well be buggy wrt
comments recently on the mailing list about ALSA pause/resume
requirements.

This works for me, given the wind is in the right direction and if
it's sunny outside.  I find the audio support on OMAP to be rather
flakey at best, requiring reboots if it doesn't work first time.
