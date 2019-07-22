From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2] ASoC: madera: Read device tree configuration
Date: Mon, 22 Jul 2019 14:52:09 +0100
Message-ID: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A596F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 15:52:14 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Read the configuration of the Madera ASoC driver from device tree.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Returned to using a helping in the madera driver itself,
   discussions around adding a generic helper indicated that all the
   error reporting would still need to be contained in the driver which
   constitutes the vast majority of the code in the helper anyway.
 - Updated the code to use the new device_property_count_u32 helper.

Thanks,
Charles

 sound/soc/codecs/madera.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index 1b1be19a2f991..5f1e32a5a8556 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -300,6 +300,100 @@ int madera_free_overheat(struct madera_priv *priv)
 }
 EXPORT_SYMBOL_GPL(madera_free_overheat);
 
+static int madera_get_variable_u32_array(struct device *dev,
+					 const char *propname,
+					 u32 *dest, int n_max,
+					 int multiple)
+{
+	int n, ret;
+
+	n = device_property_count_u32(dev, propname);
+	if (n < 0) {
+		if (n == -EINVAL)
+			return 0;	/* missing, ignore */
+
+		dev_warn(dev, "%s malformed (%d)\n", propname, n);
+
+		return n;
+	} else if ((n % multiple) != 0) {
+		dev_warn(dev, "%s not a multiple of %d entries\n",
+			 propname, multiple);
+
+		return -EINVAL;
+	}
+
+	if (n > n_max)
+		n = n_max;
+
+	ret = device_property_read_u32_array(dev, propname, dest, n);
+	if (ret < 0)
+		return ret;
+
+	return n;
+}
+
+static void madera_prop_get_inmode(struct madera_priv *priv)
+{
+	struct madera *madera = priv->madera;
+	struct madera_codec_pdata *pdata = &madera->pdata.codec;
+	u32 tmp[MADERA_MAX_INPUT * MADERA_MAX_MUXED_CHANNELS];
+	int n, i, in_idx, ch_idx;
+
+	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode) != MADERA_MAX_INPUT);
+	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode[0]) != MADERA_MAX_MUXED_CHANNELS);
+
+	n = madera_get_variable_u32_array(madera->dev, "cirrus,inmode",
+					  tmp, ARRAY_SIZE(tmp),
+					  MADERA_MAX_MUXED_CHANNELS);
+	if (n < 0)
+		return;
+
+	in_idx = 0;
+	ch_idx = 0;
+	for (i = 0; i < n; ++i) {
+		pdata->inmode[in_idx][ch_idx] = tmp[i];
+
+		if (++ch_idx == MADERA_MAX_MUXED_CHANNELS) {
+			ch_idx = 0;
+			++in_idx;
+		}
+	}
+}
+
+static void madera_prop_get_pdata(struct madera_priv *priv)
+{
+	struct madera *madera = priv->madera;
+	struct madera_codec_pdata *pdata = &madera->pdata.codec;
+	u32 out_mono[ARRAY_SIZE(pdata->out_mono)];
+	int i, n;
+
+	madera_prop_get_inmode(priv);
+
+	n = madera_get_variable_u32_array(madera->dev, "cirrus,out-mono",
+					  out_mono, ARRAY_SIZE(out_mono), 1);
+	if (n > 0)
+		for (i = 0; i < n; ++i)
+			pdata->out_mono[i] = !!out_mono[i];
+
+	madera_get_variable_u32_array(madera->dev,
+				      "cirrus,max-channels-clocked",
+				      pdata->max_channels_clocked,
+				      ARRAY_SIZE(pdata->max_channels_clocked),
+				      1);
+
+	madera_get_variable_u32_array(madera->dev, "cirrus,pdm-fmt",
+				      pdata->pdm_fmt,
+				      ARRAY_SIZE(pdata->pdm_fmt), 1);
+
+	madera_get_variable_u32_array(madera->dev, "cirrus,pdm-mute",
+				      pdata->pdm_mute,
+				      ARRAY_SIZE(pdata->pdm_mute), 1);
+
+	madera_get_variable_u32_array(madera->dev, "cirrus,dmic-ref",
+				      pdata->dmic_ref,
+				      ARRAY_SIZE(pdata->dmic_ref), 1);
+}
+
 int madera_core_init(struct madera_priv *priv)
 {
 	int i;
@@ -308,6 +402,9 @@ int madera_core_init(struct madera_priv *priv)
 	BUILD_BUG_ON(!madera_mixer_texts[MADERA_NUM_MIXER_INPUTS - 1]);
 	BUILD_BUG_ON(!madera_mixer_values[MADERA_NUM_MIXER_INPUTS - 1]);
 
+	if (!dev_get_platdata(priv->madera->dev))
+		madera_prop_get_pdata(priv);
+
 	mutex_init(&priv->rate_lock);
 
 	for (i = 0; i < MADERA_MAX_HP_OUTPUT; i++)
-- 
2.11.0
