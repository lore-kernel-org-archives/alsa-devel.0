From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/3] ASoC: Intel: bytcr_rt5651: Move getting
	of codec_dev into probe()
Date: Sun,  1 Jul 2018 20:36:30 +0200
Message-ID: <20180701183631.5532-2-hdegoede@redhat.com>
References: <20180701183631.5532-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D3E226771A
 for <alsa-devel@alsa-project.org>; Sun,  1 Jul 2018 20:36:35 +0200 (CEST)
In-Reply-To: <20180701183631.5532-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Move the getting of the codec_dev, to add device-props to it, out of
byt_rt5651_add_codec_device_props() and into its caller,
snd_byt_rt5651_mc_probe().

This is a preparation patch for adding support for an external amplifier
enable GPIO, which requires further accesses to the codec_dev.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 80f47a45cb10..d920725ce603 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -403,15 +403,10 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
  */
-static int byt_rt5651_add_codec_device_props(const char *i2c_dev_name)
+static int byt_rt5651_add_codec_device_props(struct device *i2c_dev)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
-	struct device *i2c_dev;
-	int ret, cnt = 0;
-
-	i2c_dev = bus_find_device_by_name(&i2c_bus_type, NULL, i2c_dev_name);
-	if (!i2c_dev)
-		return -EPROBE_DEFER;
+	int cnt = 0;
 
 	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
 				BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -425,10 +420,7 @@ static int byt_rt5651_add_codec_device_props(const char *i2c_dev_name)
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
 
-	ret = device_add_properties(i2c_dev, props);
-	put_device(i2c_dev);
-
-	return ret;
+	return device_add_properties(i2c_dev, props);
 }
 
 static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
@@ -696,6 +688,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	const char * const mic_name[] = { "dmic", "in1", "in12" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
+	struct device *codec_dev;
 	const char *i2c_name = NULL;
 	const char *hp_swapped;
 	bool is_bytcr = false;
@@ -731,6 +724,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		"%s%s", "i2c-", i2c_name);
 	byt_rt5651_dais[dai_index].codec_name = byt_rt5651_codec_name;
 
+	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL,
+					    byt_rt5651_codec_name);
+	if (!codec_dev)
+		return -EPROBE_DEFER;
+
 	/*
 	 * swap SSP0 if bytcr is detected
 	 * (will be overridden if DMI quirk is detected)
@@ -794,7 +792,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	dmi_check_system(byt_rt5651_quirk_table);
 
 	/* Must be called before register_card, also see declaration comment. */
-	ret_val = byt_rt5651_add_codec_device_props(byt_rt5651_codec_name);
+	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
+	put_device(codec_dev);
 	if (ret_val)
 		return ret_val;
 
-- 
2.17.1
