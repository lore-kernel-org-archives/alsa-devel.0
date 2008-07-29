From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/14] ASoC: Export DAI and codec for
	TLV320AIC26
Date: Tue, 29 Jul 2008 11:42:32 +0100
Message-ID: <1217328155-30158-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-10-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 837DA1037F9
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:41 +0200 (CEST)
In-Reply-To: <1217328155-30158-10-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This fixes sparse warnings and allows non-OpenFirmware systems to attempt
to bind to the device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 sound/soc/codecs/tlv320aic26.c |    1 +
 sound/soc/codecs/tlv320aic26.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 4621fda..73b7027 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -383,6 +383,7 @@ struct snd_soc_codec_device aic26_soc_codec_dev = {
 	.probe = aic26_probe,
 	.remove = aic26_remove,
 };
+EXPORT_SYMBOL_GPL(aic26_soc_codec_dev);
 
 /* ---------------------------------------------------------------------
  * SPI device portion of driver: sysfs files for debugging
diff --git a/sound/soc/codecs/tlv320aic26.h b/sound/soc/codecs/tlv320aic26.h
index 62b1f22..786ba16 100644
--- a/sound/soc/codecs/tlv320aic26.h
+++ b/sound/soc/codecs/tlv320aic26.h
@@ -90,4 +90,7 @@ enum aic26_wlen {
 	AIC26_WLEN_32	= 3 << 10,
 };
 
+extern struct snd_soc_dai aic26_dai;
+extern struct snd_soc_codec_device aic26_soc_codec_dev;
+
 #endif /* _TLV320AIC16_H_ */
-- 
1.5.6.3
