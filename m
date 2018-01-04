From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v1 1/6] ASoC: mediatek: add some core clocks for MT2701 AFE
Date: Thu, 4 Jan 2018 15:44:07 +0800
Message-ID: <d93643da906e25360a7dbbdcbfaa2228dfd688bf.1515038387.git.ryder.lee@mediatek.com>
References: <cover.1515038387.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1515038387.git.ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add three core clocks for MT2701 AFE.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c | 30 ++++++++++++++++++++++-
 sound/soc/mediatek/mt2701/mt2701-afe-common.h     |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index 56a057c..949fc3a 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -18,8 +18,11 @@
 #include "mt2701-afe-clock-ctrl.h"
 
 static const char *const base_clks[] = {
+	[MT2701_INFRA_SYS_AUDIO] = "infra_sys_audio_clk",
 	[MT2701_TOP_AUD_MCLK_SRC0] = "top_audio_mux1_sel",
 	[MT2701_TOP_AUD_MCLK_SRC1] = "top_audio_mux2_sel",
+	[MT2701_TOP_AUD_A1SYS] = "top_audio_a1sys_hp",
+	[MT2701_TOP_AUD_A2SYS] = "top_audio_a2sys_hp",
 	[MT2701_AUDSYS_AFE] = "audio_afe_pd",
 	[MT2701_AUDSYS_AFE_CONN] = "audio_afe_conn_pd",
 	[MT2701_AUDSYS_A1SYS] = "audio_a1sys_pd",
@@ -169,10 +172,26 @@ static int mt2701_afe_enable_audsys(struct mtk_base_afe *afe)
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
-	ret = clk_prepare_enable(afe_priv->base_ck[MT2701_AUDSYS_AFE]);
+	/* Enable infra clock gate */
+	ret = clk_prepare_enable(afe_priv->base_ck[MT2701_INFRA_SYS_AUDIO]);
 	if (ret)
 		return ret;
 
+	/* Enable top a1sys clock gate */
+	ret = clk_prepare_enable(afe_priv->base_ck[MT2701_TOP_AUD_A1SYS]);
+	if (ret)
+		goto err_a1sys;
+
+	/* Enable top a2sys clock gate */
+	ret = clk_prepare_enable(afe_priv->base_ck[MT2701_TOP_AUD_A2SYS]);
+	if (ret)
+		goto err_a2sys;
+
+	/* Internal clock gates */
+	ret = clk_prepare_enable(afe_priv->base_ck[MT2701_AUDSYS_AFE]);
+	if (ret)
+		goto err_afe;
+
 	ret = clk_prepare_enable(afe_priv->base_ck[MT2701_AUDSYS_A1SYS]);
 	if (ret)
 		goto err_audio_a1sys;
@@ -193,6 +212,12 @@ static int mt2701_afe_enable_audsys(struct mtk_base_afe *afe)
 	clk_disable_unprepare(afe_priv->base_ck[MT2701_AUDSYS_A1SYS]);
 err_audio_a1sys:
 	clk_disable_unprepare(afe_priv->base_ck[MT2701_AUDSYS_AFE]);
+err_afe:
+	clk_disable_unprepare(afe_priv->base_ck[MT2701_TOP_AUD_A2SYS]);
+err_a2sys:
+	clk_disable_unprepare(afe_priv->base_ck[MT2701_TOP_AUD_A1SYS]);
+err_a1sys:
+	clk_disable_unprepare(afe_priv->base_ck[MT2701_INFRA_SYS_AUDIO]);
 
 	return ret;
 }
@@ -205,6 +230,9 @@ static void mt2701_afe_disable_audsys(struct mtk_base_afe *afe)
 	clk_disable_unprepare(afe_priv->base_ck[MT2701_AUDSYS_A2SYS]);
 	clk_disable_unprepare(afe_priv->base_ck[MT2701_AUDSYS_A1SYS]);
 	clk_disable_unprepare(afe_priv->base_ck[MT2701_AUDSYS_AFE]);
+	clk_disable_unprepare(afe_priv->base_ck[MT2701_TOP_AUD_A1SYS]);
+	clk_disable_unprepare(afe_priv->base_ck[MT2701_TOP_AUD_A2SYS]);
+	clk_disable_unprepare(afe_priv->base_ck[MT2701_INFRA_SYS_AUDIO]);
 }
 
 int mt2701_afe_enable_clock(struct mtk_base_afe *afe)
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index 9a2b301..ae8ddea 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-common.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -61,8 +61,11 @@ enum {
 };
 
 enum audio_base_clock {
+	MT2701_INFRA_SYS_AUDIO,
 	MT2701_TOP_AUD_MCLK_SRC0,
 	MT2701_TOP_AUD_MCLK_SRC1,
+	MT2701_TOP_AUD_A1SYS,
+	MT2701_TOP_AUD_A2SYS,
 	MT2701_AUDSYS_AFE,
 	MT2701_AUDSYS_AFE_CONN,
 	MT2701_AUDSYS_A1SYS,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
