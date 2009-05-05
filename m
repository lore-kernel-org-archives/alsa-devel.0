From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/18] ASoC: Fix boot warnings from S3C IISv2
Date: Tue,  5 May 2009 11:02:18 +0100
Message-ID: <1241517751-2634-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E848224514
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:34 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On startup we try to make sure that the port is quiesced but if the
port is already stopped then this will generate a warning about the
RX/TX mode configuration. Configure the mode before doing the teardown
to suppress these warnings.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 54f4119..34142c8 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -573,6 +573,7 @@ int s3c_i2sv2_probe(struct platform_device *pdev,
 		    unsigned long base)
 {
 	struct device *dev = &pdev->dev;
+	unsigned int iismod;
 
 	i2s->dev = dev;
 
@@ -594,12 +595,16 @@ int s3c_i2sv2_probe(struct platform_device *pdev,
 
 	clk_enable(i2s->iis_pclk);
 
+	/* Mark ourselves as in TXRX mode so we can run through our cleanup
+	 * process without warnings. */
+	iismod = readl(i2s->regs + S3C2412_IISMOD);
+	iismod |= S3C2412_IISMOD_MODE_TXRX;
+	writel(iismod, i2s->regs + S3C2412_IISMOD);
 	s3c2412_snd_txctrl(i2s, 0);
 	s3c2412_snd_rxctrl(i2s, 0);
 
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
 
 #ifdef CONFIG_PM
-- 
1.6.2.4
