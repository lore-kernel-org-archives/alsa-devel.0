From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: soc-io: Only force use regmap if the
	codec have it implemented
Date: Wed,  1 Aug 2012 15:01:45 +0300
Message-ID: <1343822505-6331-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
 [74.125.149.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 3088A265217
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 14:01:01 +0200 (CEST)
Received: by ghbz10 with SMTP id z10so8507458ghb.21
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 05:01:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some codecs (like twl4030, twl6040) can not have regmap implementation
since they are accessing to the chip via MFD core drivers.

Force the use of regmap only in cases when the regmap is actually
available for the codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Mark,

the following commit:
38cbf95 ASoC: core: Try to use regmap if the driver doesn't set up any I/O

broke audio for boards using twl4030 or twl6040 as codec. These devices can not
have regmap implementation in the codec driver since they rely on their MFD core
to access to the chip.

As it is now big number of OMAP based devices have broken audio. Would it be
possible to include this fix for 3.6-rc1 already?

Regards,
Peter

 sound/soc/soc-io.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 29183ef..26948be 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -117,9 +117,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	int ret;
 
 	memset(&config, 0, sizeof(config));
-	codec->write = hw_write;
-	codec->read = hw_read;
-	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
 
 	config.reg_bits = addr_bits;
 	config.val_bits = data_bits;
@@ -141,11 +138,11 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
-		codec->using_regmap = true;
 		if (!codec->control_data)
 			codec->control_data = dev_get_regmap(codec->dev, NULL);
 
 		if (codec->control_data) {
+			codec->using_regmap = true;
 			ret = regmap_get_val_bytes(codec->control_data);
 			/* Errors are legitimate for non-integer byte
 			 * multiples */
@@ -161,6 +158,13 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	if (IS_ERR(codec->control_data))
 		return PTR_ERR(codec->control_data);
 
+	/* Only override the read/write callbacks if regmap is available */
+	if (codec->control_data) {
+		codec->write = hw_write;
+		codec->read = hw_read;
+		codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-- 
1.7.8.6
