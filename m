From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs35l35: Add for configuring drive mode in unused slots" to the asoc tree
Date: Mon, 13 Mar 2017 16:58:46 +0000
Message-ID: <E1cnTJ0-0005Bv-79@debutante>
References: <1488991371-22513-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1488991371-22513-3-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Add for configuring drive mode in unused slots

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8d45f2d23864ae1582d095c54605540cd3640169 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Date: Wed, 8 Mar 2017 16:42:49 +0000
Subject: [PATCH] ASoC: cs35l35: Add for configuring drive mode in unused slots

Add support for setting how the I2S pins are driven in unused slots,
currently the chip will just use the default of drive 0, however this
causes issues when multiple devices are attached to the same bus.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/cs35l35.h    | 2 ++
 sound/soc/codecs/cs35l35.c | 7 +++++++
 sound/soc/codecs/cs35l35.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index de92e452bf93..983c610eba2e 100644
--- a/include/sound/cs35l35.h
+++ b/include/sound/cs35l35.h
@@ -80,6 +80,8 @@ struct cs35l35_platform_data {
 	bool stereo;
 	/* serial port drive strength */
 	int sp_drv_str;
+	/* serial port drive in unused slots */
+	int sp_drv_unused;
 	/* Boost Power Down with FET */
 	bool bst_pdn_fet_on;
 	/* Boost Voltage : used if ClassH Algo Enabled */
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 48b45dc904ea..5a9fe5addb86 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -789,6 +789,11 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 				CS35L35_SP_DRV_MASK,
 				cs35l35->pdata.sp_drv_str <<
 				CS35L35_SP_DRV_SHIFT);
+	if (cs35l35->pdata.sp_drv_unused)
+		regmap_update_bits(cs35l35->regmap, CS35L35_SP_FMT_CTL3,
+				   CS35L35_SP_I2S_DRV_MASK,
+				   cs35l35->pdata.sp_drv_unused <<
+				   CS35L35_SP_I2S_DRV_SHIFT);
 
 	if (classh->classh_algo_enable) {
 		if (classh->classh_bst_override)
@@ -1169,6 +1174,8 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 
 	if (of_property_read_u32(np, "cirrus,sp-drv-strength", &val32) >= 0)
 		pdata->sp_drv_str = val32;
+	if (of_property_read_u32(np, "cirrus,sp-drv-unused", &val32) >= 0)
+		pdata->sp_drv_unused = val32 | CS35L35_VALID_PDATA;
 
 	pdata->stereo = of_property_read_bool(np, "cirrus,stereo-config");
 
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index e27a7fef5fb1..c203081fc94c 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -190,6 +190,10 @@
 #define CS35L35_AMP_GAIN_ZC_MASK	0x10
 #define CS35L35_AMP_GAIN_ZC_SHIFT	4
 
+/* CS35L35_SP_FMT_CTL3 */
+#define CS35L35_SP_I2S_DRV_MASK		0x03
+#define CS35L35_SP_I2S_DRV_SHIFT	0
+
 /* Class H Algorithm Control */
 #define CS35L35_CH_STEREO_MASK		0x40
 #define CS35L35_CH_STEREO_SHIFT		6
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
