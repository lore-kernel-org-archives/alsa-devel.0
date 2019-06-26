From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: madera: Read device tree
	configuration
Date: Wed, 26 Jun 2019 16:36:11 +0100
Message-ID: <20190626153611.10170-2-ckeepax@opensource.cirrus.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9D95F896B9
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 17:36:17 +0200 (CEST)
In-Reply-To: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
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
Cc: alsa-devel@alsa-project.org, rafael@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com, linux-acpi@vger.kernel.org, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

Read the configuration of the Madera sound driver from device tree using
the new device tree helper function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Note this patch depends on patches that are currently going through Mark's
tree so probably best if this one also goes through there.

Thanks,
Charles

 sound/soc/codecs/madera.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index 1b1be19a2f991..8fe16e4e19c7b 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -300,6 +300,68 @@ int madera_free_overheat(struct madera_priv *priv)
 }
 EXPORT_SYMBOL_GPL(madera_free_overheat);
 
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
+	n = device_property_read_u32_2darray(madera->dev, "cirrus,inmode",
+					     tmp, ARRAY_SIZE(tmp),
+					     MADERA_MAX_MUXED_CHANNELS);
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
+	n = device_property_read_u32_2darray(madera->dev, "cirrus,out-mono",
+					     out_mono, ARRAY_SIZE(out_mono), 1);
+	if (n > 0)
+		for (i = 0; i < n; ++i)
+			pdata->out_mono[i] = !!out_mono[i];
+
+	device_property_read_u32_2darray(madera->dev,
+					 "cirrus,max-channels-clocked",
+					 pdata->max_channels_clocked,
+					 ARRAY_SIZE(pdata->max_channels_clocked),
+					 1);
+
+	device_property_read_u32_2darray(madera->dev, "cirrus,pdm-fmt",
+					 pdata->pdm_fmt,
+					 ARRAY_SIZE(pdata->pdm_fmt), 1);
+
+	device_property_read_u32_2darray(madera->dev, "cirrus,pdm-mute",
+					 pdata->pdm_mute,
+					 ARRAY_SIZE(pdata->pdm_mute), 1);
+
+	device_property_read_u32_2darray(madera->dev, "cirrus,dmic-ref",
+					 pdata->dmic_ref,
+					 ARRAY_SIZE(pdata->dmic_ref), 1);
+}
+
 int madera_core_init(struct madera_priv *priv)
 {
 	int i;
@@ -308,6 +370,9 @@ int madera_core_init(struct madera_priv *priv)
 	BUILD_BUG_ON(!madera_mixer_texts[MADERA_NUM_MIXER_INPUTS - 1]);
 	BUILD_BUG_ON(!madera_mixer_values[MADERA_NUM_MIXER_INPUTS - 1]);
 
+	if (!dev_get_platdata(priv->madera->dev))
+		madera_prop_get_pdata(priv);
+
 	mutex_init(&priv->rate_lock);
 
 	for (i = 0; i < MADERA_MAX_HP_OUTPUT; i++)
-- 
2.11.0
