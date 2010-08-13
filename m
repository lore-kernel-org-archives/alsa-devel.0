From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] WM8580 updates
Date: Fri, 13 Aug 2010 20:33:05 +0100
Message-ID: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 851D51038C8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:33:09 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

This batch of patches should get the sample ratio selection for the
WM8580 based on the configured sysclk correct, and also fixes a few
random other things.

The configuration of the ADC clocking (which is slaved to the DAC
clocking) is still not ideal - userspace has to configure playback at
the sample rate to be used prior to starting a record - but this needs
some more thought at the framework level since this is essentially the
same problem we have when multiple DAIs run over one physical interface
using TDM.  Ideally we'd solve the more general problem.

Mark Brown (7):
      ASoC: Add a bit of resource unwinding in the S3C IISv4 driver
      ASoC: Convert WM8580 hw_params to use snd_soc_update_bits()
      ASoC: Remove unused rate selection bitmasks from WM8580
      ASoC: Automatically calculate clock ratio for WM8580
      ASoC: Implement BCLK rate selection for WM8580
      ASoC: Fix inverted WM8580 capture mute control
      ASoC: Automatically manage WM8580 DAC OSR

 sound/soc/codecs/wm8580.c           |  144 +++++++++++++++++++++++++---------
 sound/soc/codecs/wm8580.h           |   14 ++--
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c  |   11 +++
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    9 +-
 4 files changed, 128 insertions(+), 50 deletions(-)
