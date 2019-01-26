From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [RESEND PATCH 1/6] ASoC: mediatek: mt8183: add platform driver
Date: Sat, 26 Jan 2019 15:44:55 +0800
Message-ID: <1548488700-47792-2-git-send-email-shunli.wang@mediatek.com>
References: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1548488700-47792-1-git-send-email-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

add mt8183 audio platform and affiliated drivers.

Signed-off-by: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/Kconfig                         |   10 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt8183/Makefile                 |   13 +
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |  611 +++++++
 sound/soc/mediatek/mt8183/mt8183-afe-clk.h         |   38 +
 sound/soc/mediatek/mt8183/mt8183-afe-common.h      |  108 ++
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         | 1237 +++++++++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |  501 ++++++
 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c    |  118 ++
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         | 1040 ++++++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c         |  318 ++++
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         |  639 ++++++++
 sound/soc/mediatek/mt8183/mt8183-interconnection.h |   33 +
 sound/soc/mediatek/mt8183/mt8183-reg.h             | 1666 ++++++++++++++++++++
 14 files changed, 6333 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8183/Makefile
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-reg.h

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index e731d40..8bb360e 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -105,3 +105,13 @@ config SND_SOC_MT8173_RT5650_RT5676
 	  with the RT5650 and RT5676 codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
+config SND_SOC_MT8183
+	tristate "ASoC support for Mediatek MT8183 chip"
+	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC platform driver support for Mediatek MT8183 chip
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 3bb2c47..76032ca 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
 obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
 obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
+obj-$(CONFIG_SND_SOC_MT8183) += mt8183/
diff --git a/sound/soc/mediatek/mt8183/Makefile b/sound/soc/mediatek/mt8183/Makefile
new file mode 100644
index 0000000..f3ee6ac
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# platform driver
+snd-soc-mt8183-afe-objs := \
+	mt8183-afe-pcm.o \
+	mt8183-afe-clk.o \
+	mt8183-dai-i2s.o \
+	mt8183-dai-tdm.o \
+	mt8183-dai-pcm.o \
+	mt8183-dai-hostless.o \
+	mt8183-dai-adda.o
+
+obj-$(CONFIG_SND_SOC_MT8183) += snd-soc-mt8183-afe.o
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-clk.c b/sound/soc/mediatek/mt8183/mt8183-afe-clk.c
new file mode 100644
index 0000000..f523ad1
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-clk.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt8183-afe-clk.c  --  Mediatek 8183 afe clock ctrl
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/clk.h>
+
+#include "mt8183-afe-common.h"
+#include "mt8183-afe-clk.h"
+#include "mt8183-reg.h"
+
+enum {
+	CLK_AFE = 0,
+	CLK_TML,
+	CLK_APLL22M,
+	CLK_APLL24M,
+	CLK_APLL1_TUNER,
+	CLK_APLL2_TUNER,
+	CLK_I2S1_BCLK_SW,
+	CLK_I2S2_BCLK_SW,
+	CLK_I2S3_BCLK_SW,
+	CLK_I2S4_BCLK_SW,
+	CLK_INFRA_SYS_AUDIO,
+	CLK_MUX_AUDIO,
+	CLK_MUX_AUDIOINTBUS,
+	CLK_TOP_SYSPLL_D2_D4,
+	/* apll related mux */
+	CLK_TOP_MUX_AUD_1,
+	CLK_TOP_APLL1_CK,
+	CLK_TOP_MUX_AUD_2,
+	CLK_TOP_APLL2_CK,
+	CLK_TOP_MUX_AUD_ENG1,
+	CLK_TOP_APLL1_D8,
+	CLK_TOP_MUX_AUD_ENG2,
+	CLK_TOP_APLL2_D8,
+	CLK_TOP_I2S0_M_SEL,
+	CLK_TOP_I2S1_M_SEL,
+	CLK_TOP_I2S2_M_SEL,
+	CLK_TOP_I2S3_M_SEL,
+	CLK_TOP_I2S4_M_SEL,
+	CLK_TOP_I2S5_M_SEL,
+	CLK_TOP_APLL12_DIV0,
+	CLK_TOP_APLL12_DIV1,
+	CLK_TOP_APLL12_DIV2,
+	CLK_TOP_APLL12_DIV3,
+	CLK_TOP_APLL12_DIV4,
+	CLK_TOP_APLL12_DIVB,
+	CLK_CLK26M,
+	CLK_NUM
+};
+
+static const char *aud_clks[CLK_NUM] = {
+	[CLK_AFE] = "aud_afe_clk",
+	[CLK_TML] = "aud_tml_clk",
+	[CLK_APLL22M] = "aud_apll22m_clk",
+	[CLK_APLL24M] = "aud_apll24m_clk",
+	[CLK_APLL1_TUNER] = "aud_apll1_tuner_clk",
+	[CLK_APLL2_TUNER] = "aud_apll2_tuner_clk",
+	[CLK_I2S1_BCLK_SW] = "aud_i2s1_bclk_sw",
+	[CLK_I2S2_BCLK_SW] = "aud_i2s2_bclk_sw",
+	[CLK_I2S3_BCLK_SW] = "aud_i2s3_bclk_sw",
+	[CLK_I2S4_BCLK_SW] = "aud_i2s4_bclk_sw",
+	[CLK_INFRA_SYS_AUDIO] = "aud_infra_clk",
+	[CLK_MUX_AUDIO] = "top_mux_audio",
+	[CLK_MUX_AUDIOINTBUS] = "top_mux_aud_intbus",
+	[CLK_TOP_SYSPLL_D2_D4] = "top_syspll_d2_d4",
+	[CLK_TOP_MUX_AUD_1] = "top_mux_aud_1",
+	[CLK_TOP_APLL1_CK] = "top_apll1_ck",
+	[CLK_TOP_MUX_AUD_2] = "top_mux_aud_2",
+	[CLK_TOP_APLL2_CK] = "top_apll2_ck",
+	[CLK_TOP_MUX_AUD_ENG1] = "top_mux_aud_eng1",
+	[CLK_TOP_APLL1_D8] = "top_apll1_d8",
+	[CLK_TOP_MUX_AUD_ENG2] = "top_mux_aud_eng2",
+	[CLK_TOP_APLL2_D8] = "top_apll2_d8",
+	[CLK_TOP_I2S0_M_SEL] = "top_i2s0_m_sel",
+	[CLK_TOP_I2S1_M_SEL] = "top_i2s1_m_sel",
+	[CLK_TOP_I2S2_M_SEL] = "top_i2s2_m_sel",
+	[CLK_TOP_I2S3_M_SEL] = "top_i2s3_m_sel",
+	[CLK_TOP_I2S4_M_SEL] = "top_i2s4_m_sel",
+	[CLK_TOP_I2S5_M_SEL] = "top_i2s5_m_sel",
+	[CLK_TOP_APLL12_DIV0] = "top_apll12_div0",
+	[CLK_TOP_APLL12_DIV1] = "top_apll12_div1",
+	[CLK_TOP_APLL12_DIV2] = "top_apll12_div2",
+	[CLK_TOP_APLL12_DIV3] = "top_apll12_div3",
+	[CLK_TOP_APLL12_DIV4] = "top_apll12_div4",
+	[CLK_TOP_APLL12_DIVB] = "top_apll12_divb",
+	[CLK_CLK26M] = "top_clk26m_clk",
+};
+
+int mt8183_init_clock(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int i;
+
+	afe_priv->clk = devm_kcalloc(afe->dev, CLK_NUM, sizeof(*afe_priv->clk),
+				     GFP_KERNEL);
+	if (!afe_priv->clk)
+		return -ENOMEM;
+
+	for (i = 0; i < CLK_NUM; i++) {
+		afe_priv->clk[i] = devm_clk_get(afe->dev, aud_clks[i]);
+		if (IS_ERR(afe_priv->clk[i])) {
+			dev_err(afe->dev, "%s(), devm_clk_get %s fail, ret %ld\n",
+				__func__, aud_clks[i],
+				PTR_ERR(afe_priv->clk[i]));
+			return PTR_ERR(afe_priv->clk[i]);
+		}
+	}
+
+	return 0;
+}
+
+int mt8183_afe_enable_clock(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_INFRA_SYS_AUDIO], ret);
+		goto CLK_INFRA_SYS_AUDIO_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_MUX_AUDIO]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_MUX_AUDIO], ret);
+		goto CLK_MUX_AUDIO_ERR;
+	}
+
+	ret = clk_set_parent(afe_priv->clk[CLK_MUX_AUDIO],
+			     afe_priv->clk[CLK_CLK26M]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_set_parent %s-%s fail %d\n",
+			__func__, aud_clks[CLK_MUX_AUDIO],
+			aud_clks[CLK_CLK26M], ret);
+		goto CLK_MUX_AUDIO_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_MUX_AUDIOINTBUS], ret);
+		goto CLK_MUX_AUDIO_INTBUS_ERR;
+	}
+
+	ret = clk_set_parent(afe_priv->clk[CLK_MUX_AUDIOINTBUS],
+			     afe_priv->clk[CLK_TOP_SYSPLL_D2_D4]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_set_parent %s-%s fail %d\n",
+			__func__, aud_clks[CLK_MUX_AUDIOINTBUS],
+			aud_clks[CLK_TOP_SYSPLL_D2_D4], ret);
+		goto CLK_MUX_AUDIO_INTBUS_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_AFE]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_AFE], ret);
+		goto CLK_AFE_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_I2S1_BCLK_SW]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_I2S1_BCLK_SW], ret);
+		goto CLK_I2S1_BCLK_SW_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_I2S2_BCLK_SW]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_I2S2_BCLK_SW], ret);
+		goto CLK_I2S2_BCLK_SW_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_I2S3_BCLK_SW]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_I2S3_BCLK_SW], ret);
+		goto CLK_I2S3_BCLK_SW_ERR;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_I2S4_BCLK_SW]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_I2S4_BCLK_SW], ret);
+		goto CLK_I2S4_BCLK_SW_ERR;
+	}
+
+	return 0;
+
+CLK_I2S4_BCLK_SW_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S3_BCLK_SW]);
+CLK_I2S3_BCLK_SW_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S2_BCLK_SW]);
+CLK_I2S2_BCLK_SW_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S1_BCLK_SW]);
+CLK_I2S1_BCLK_SW_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_AFE]);
+CLK_AFE_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
+CLK_MUX_AUDIO_INTBUS_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIO]);
+CLK_MUX_AUDIO_ERR:
+	clk_disable_unprepare(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
+CLK_INFRA_SYS_AUDIO_ERR:
+	return ret;
+}
+
+int mt8183_afe_disable_clock(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S4_BCLK_SW]);
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S3_BCLK_SW]);
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S2_BCLK_SW]);
+	clk_disable_unprepare(afe_priv->clk[CLK_I2S1_BCLK_SW]);
+	clk_disable_unprepare(afe_priv->clk[CLK_AFE]);
+	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIOINTBUS]);
+	clk_disable_unprepare(afe_priv->clk[CLK_MUX_AUDIO]);
+	clk_disable_unprepare(afe_priv->clk[CLK_INFRA_SYS_AUDIO]);
+
+	return 0;
+}
+
+/* apll */
+static int apll1_mux_setting(struct mtk_base_afe *afe, bool enable)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	if (enable) {
+		ret = clk_prepare_enable(afe_priv->clk[CLK_TOP_MUX_AUD_1]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_1], ret);
+			goto ERR_ENABLE_CLK_TOP_MUX_AUD_1;
+		}
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_1],
+				     afe_priv->clk[CLK_TOP_APLL1_CK]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_1],
+				aud_clks[CLK_TOP_APLL1_CK], ret);
+			goto ERR_SELECT_CLK_TOP_MUX_AUD_1;
+		}
+
+		/* 180.6336 / 8 = 22.5792MHz */
+		ret = clk_prepare_enable(afe_priv->clk[CLK_TOP_MUX_AUD_ENG1]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_ENG1], ret);
+			goto ERR_ENABLE_CLK_TOP_MUX_AUD_ENG1;
+		}
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_ENG1],
+				     afe_priv->clk[CLK_TOP_APLL1_D8]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_ENG1],
+				aud_clks[CLK_TOP_APLL1_D8], ret);
+			goto ERR_SELECT_CLK_TOP_MUX_AUD_ENG1;
+		}
+	} else {
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_ENG1],
+				     afe_priv->clk[CLK_CLK26M]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_ENG1],
+				aud_clks[CLK_CLK26M], ret);
+			goto EXIT;
+		}
+		clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_ENG1]);
+
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_1],
+				     afe_priv->clk[CLK_CLK26M]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_1],
+				aud_clks[CLK_CLK26M], ret);
+			goto EXIT;
+		}
+		clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_1]);
+	}
+
+	return 0;
+
+ERR_SELECT_CLK_TOP_MUX_AUD_ENG1:
+	clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_ENG1],
+		       afe_priv->clk[CLK_CLK26M]);
+	clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_ENG1]);
+ERR_ENABLE_CLK_TOP_MUX_AUD_ENG1:
+ERR_SELECT_CLK_TOP_MUX_AUD_1:
+	clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_1],
+		       afe_priv->clk[CLK_CLK26M]);
+	clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_1]);
+ERR_ENABLE_CLK_TOP_MUX_AUD_1:
+EXIT:
+	return ret;
+}
+
+static int apll2_mux_setting(struct mtk_base_afe *afe, bool enable)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	if (enable) {
+		ret = clk_prepare_enable(afe_priv->clk[CLK_TOP_MUX_AUD_2]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_2], ret);
+			goto ERR_ENABLE_CLK_TOP_MUX_AUD_2;
+		}
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_2],
+				     afe_priv->clk[CLK_TOP_APLL2_CK]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_2],
+				aud_clks[CLK_TOP_APLL2_CK], ret);
+			goto ERR_SELECT_CLK_TOP_MUX_AUD_2;
+		}
+
+		/* 196.608 / 8 = 24.576MHz */
+		ret = clk_prepare_enable(afe_priv->clk[CLK_TOP_MUX_AUD_ENG2]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_ENG2], ret);
+			goto ERR_ENABLE_CLK_TOP_MUX_AUD_ENG2;
+		}
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_ENG2],
+				     afe_priv->clk[CLK_TOP_APLL2_D8]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_ENG2],
+				aud_clks[CLK_TOP_APLL2_D8], ret);
+			goto ERR_SELECT_CLK_TOP_MUX_AUD_ENG2;
+		}
+	} else {
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_ENG2],
+				     afe_priv->clk[CLK_CLK26M]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_ENG2],
+				aud_clks[CLK_CLK26M], ret);
+			goto EXIT;
+		}
+		clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_ENG2]);
+
+		ret = clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_2],
+				     afe_priv->clk[CLK_CLK26M]);
+		if (ret) {
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[CLK_TOP_MUX_AUD_2],
+				aud_clks[CLK_CLK26M], ret);
+			goto EXIT;
+		}
+		clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_2]);
+	}
+
+	return 0;
+
+ERR_SELECT_CLK_TOP_MUX_AUD_ENG2:
+	clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_ENG2],
+		       afe_priv->clk[CLK_CLK26M]);
+	clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_ENG2]);
+ERR_ENABLE_CLK_TOP_MUX_AUD_ENG2:
+ERR_SELECT_CLK_TOP_MUX_AUD_2:
+	clk_set_parent(afe_priv->clk[CLK_TOP_MUX_AUD_2],
+		       afe_priv->clk[CLK_CLK26M]);
+	clk_disable_unprepare(afe_priv->clk[CLK_TOP_MUX_AUD_2]);
+ERR_ENABLE_CLK_TOP_MUX_AUD_2:
+EXIT:
+	return ret;
+}
+
+int mt8183_apll1_enable(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	/* setting for APLL */
+	apll1_mux_setting(afe, true);
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL22M]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_APLL22M], ret);
+		goto ERR_CLK_APLL22M;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL1_TUNER]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_APLL1_TUNER], ret);
+		goto ERR_CLK_APLL1_TUNER;
+	}
+
+	regmap_update_bits(afe->regmap, AFE_APLL1_TUNER_CFG,
+			   0x0000FFF7, 0x00000832);
+	regmap_update_bits(afe->regmap, AFE_APLL1_TUNER_CFG, 0x1, 0x1);
+
+	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+			   AFE_22M_ON_MASK_SFT,
+			   0x1 << AFE_22M_ON_SFT);
+
+	return 0;
+
+ERR_CLK_APLL1_TUNER:
+	clk_disable_unprepare(afe_priv->clk[CLK_APLL22M]);
+ERR_CLK_APLL22M:
+	return ret;
+}
+
+void mt8183_apll1_disable(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+
+	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+			   AFE_22M_ON_MASK_SFT,
+			   0x0 << AFE_22M_ON_SFT);
+
+	regmap_update_bits(afe->regmap, AFE_APLL1_TUNER_CFG, 0x1, 0x0);
+
+	clk_disable_unprepare(afe_priv->clk[CLK_APLL1_TUNER]);
+	clk_disable_unprepare(afe_priv->clk[CLK_APLL22M]);
+
+	apll1_mux_setting(afe, false);
+}
+
+int mt8183_apll2_enable(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	/* setting for APLL */
+	apll2_mux_setting(afe, true);
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL24M]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_APLL24M], ret);
+		goto ERR_CLK_APLL24M;
+	}
+
+	ret = clk_prepare_enable(afe_priv->clk[CLK_APLL2_TUNER]);
+	if (ret) {
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[CLK_APLL2_TUNER], ret);
+		goto ERR_CLK_APLL2_TUNER;
+	}
+
+	regmap_update_bits(afe->regmap, AFE_APLL2_TUNER_CFG,
+			   0x0000FFF7, 0x00000634);
+	regmap_update_bits(afe->regmap, AFE_APLL2_TUNER_CFG, 0x1, 0x1);
+
+	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+			   AFE_24M_ON_MASK_SFT,
+			   0x1 << AFE_24M_ON_SFT);
+
+	return 0;
+
+ERR_CLK_APLL2_TUNER:
+	clk_disable_unprepare(afe_priv->clk[CLK_APLL24M]);
+ERR_CLK_APLL24M:
+	return ret;
+}
+
+void mt8183_apll2_disable(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+
+	regmap_update_bits(afe->regmap, AFE_HD_ENGEN_ENABLE,
+			   AFE_24M_ON_MASK_SFT,
+			   0x0 << AFE_24M_ON_SFT);
+
+	regmap_update_bits(afe->regmap, AFE_APLL2_TUNER_CFG, 0x1, 0x0);
+
+	clk_disable_unprepare(afe_priv->clk[CLK_APLL2_TUNER]);
+	clk_disable_unprepare(afe_priv->clk[CLK_APLL24M]);
+
+	apll2_mux_setting(afe, false);
+}
+
+int mt8183_get_apll_rate(struct mtk_base_afe *afe, int apll)
+{
+	return (apll == MT8183_APLL1) ? 180633600 : 196608000;
+}
+
+int mt8183_get_apll_by_rate(struct mtk_base_afe *afe, int rate)
+{
+	return ((rate % 8000) == 0) ? MT8183_APLL2 : MT8183_APLL1;
+}
+
+int mt8183_get_apll_by_name(struct mtk_base_afe *afe, const char *name)
+{
+	if (strcmp(name, APLL1_W_NAME) == 0)
+		return MT8183_APLL1;
+	else
+		return MT8183_APLL2;
+}
+
+/* mck */
+struct mt8183_mck_div {
+	int m_sel_id;
+	int div_clk_id;
+};
+
+static const struct mt8183_mck_div mck_div[MT8183_MCK_NUM] = {
+	[MT8183_I2S0_MCK] = {
+		.m_sel_id = CLK_TOP_I2S0_M_SEL,
+		.div_clk_id = CLK_TOP_APLL12_DIV0,
+	},
+	[MT8183_I2S1_MCK] = {
+		.m_sel_id = CLK_TOP_I2S1_M_SEL,
+		.div_clk_id = CLK_TOP_APLL12_DIV1,
+	},
+	[MT8183_I2S2_MCK] = {
+		.m_sel_id = CLK_TOP_I2S2_M_SEL,
+		.div_clk_id = CLK_TOP_APLL12_DIV2,
+	},
+	[MT8183_I2S3_MCK] = {
+		.m_sel_id = CLK_TOP_I2S3_M_SEL,
+		.div_clk_id = CLK_TOP_APLL12_DIV3,
+	},
+	[MT8183_I2S4_MCK] = {
+		.m_sel_id = CLK_TOP_I2S4_M_SEL,
+		.div_clk_id = CLK_TOP_APLL12_DIV4,
+	},
+	[MT8183_I2S4_BCK] = {
+		.m_sel_id = -1,
+		.div_clk_id = CLK_TOP_APLL12_DIVB,
+	},
+	[MT8183_I2S5_MCK] = {
+		.m_sel_id = -1,
+		.div_clk_id = -1,
+	},
+};
+
+int mt8183_mck_enable(struct mtk_base_afe *afe, int mck_id, int rate)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int apll = mt8183_get_apll_by_rate(afe, rate);
+	int apll_clk_id = apll == MT8183_APLL1 ?
+			  CLK_TOP_MUX_AUD_1 : CLK_TOP_MUX_AUD_2;
+	int m_sel_id = mck_div[mck_id].m_sel_id;
+	int div_clk_id = mck_div[mck_id].div_clk_id;
+	int ret;
+
+	/* i2s5 mck not support */
+	if (mck_id == MT8183_I2S5_MCK)
+		return 0;
+
+	/* select apll */
+	if (m_sel_id >= 0) {
+		ret = clk_prepare_enable(afe_priv->clk[m_sel_id]);
+		if (ret) {
+			dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+				__func__, aud_clks[m_sel_id], ret);
+			goto ERR_ENABLE_MCLK;
+		}
+		ret = clk_set_parent(afe_priv->clk[m_sel_id],
+				     afe_priv->clk[apll_clk_id]);
+		if (ret) {
+			dev_err(afe->dev, "%s(), clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[m_sel_id],
+				aud_clks[apll_clk_id], ret);
+			goto ERR_SELECT_MCLK;
+		}
+	}
+
+	/* enable div, set rate */
+	ret = clk_prepare_enable(afe_priv->clk[div_clk_id]);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[div_clk_id], ret);
+		goto ERR_ENABLE_MCLK_DIV;
+	}
+	ret = clk_set_rate(afe_priv->clk[div_clk_id], rate);
+	if (ret) {
+		dev_err(afe->dev, "%s(), clk_set_rate %s, rate %d, fail %d\n",
+			__func__, aud_clks[div_clk_id],
+			rate, ret);
+		goto ERR_SET_MCLK_RATE;
+		return ret;
+	}
+
+	return 0;
+
+ERR_SET_MCLK_RATE:
+	clk_disable_unprepare(afe_priv->clk[div_clk_id]);
+ERR_ENABLE_MCLK_DIV:
+ERR_SELECT_MCLK:
+	if (m_sel_id >= 0)
+		clk_disable_unprepare(afe_priv->clk[m_sel_id]);
+ERR_ENABLE_MCLK:
+	return ret;
+}
+
+void mt8183_mck_disable(struct mtk_base_afe *afe, int mck_id)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int m_sel_id = mck_div[mck_id].m_sel_id;
+	int div_clk_id = mck_div[mck_id].div_clk_id;
+
+	clk_disable_unprepare(afe_priv->clk[div_clk_id]);
+	if (m_sel_id >= 0)
+		clk_disable_unprepare(afe_priv->clk[m_sel_id]);
+}
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-clk.h b/sound/soc/mediatek/mt8183/mt8183-afe-clk.h
new file mode 100644
index 0000000..2c510aa
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-clk.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8183-afe-clk.h  --  Mediatek 8183 afe clock ctrl definition
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ */
+
+#ifndef _MT8183_AFE_CLK_H_
+#define _MT8183_AFE_CLK_H_
+
+/* APLL */
+#define APLL1_W_NAME "APLL1"
+#define APLL2_W_NAME "APLL2"
+enum {
+	MT8183_APLL1 = 0,
+	MT8183_APLL2,
+};
+
+struct mtk_base_afe;
+
+int mt8183_init_clock(struct mtk_base_afe *afe);
+int mt8183_afe_enable_clock(struct mtk_base_afe *afe);
+int mt8183_afe_disable_clock(struct mtk_base_afe *afe);
+
+int mt8183_apll1_enable(struct mtk_base_afe *afe);
+void mt8183_apll1_disable(struct mtk_base_afe *afe);
+
+int mt8183_apll2_enable(struct mtk_base_afe *afe);
+void mt8183_apll2_disable(struct mtk_base_afe *afe);
+
+int mt8183_get_apll_rate(struct mtk_base_afe *afe, int apll);
+int mt8183_get_apll_by_rate(struct mtk_base_afe *afe, int rate);
+int mt8183_get_apll_by_name(struct mtk_base_afe *afe, const char *name);
+
+int mt8183_mck_enable(struct mtk_base_afe *afe, int mck_id, int rate);
+void mt8183_mck_disable(struct mtk_base_afe *afe, int mck_id);
+#endif
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-common.h b/sound/soc/mediatek/mt8183/mt8183-afe-common.h
new file mode 100644
index 0000000..b220e7a
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-common.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8183-afe-common.h  --  Mediatek 8183 audio driver definitions
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ */
+
+#ifndef _MT_8183_AFE_COMMON_H_
+#define _MT_8183_AFE_COMMON_H_
+
+#include <sound/soc.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include "../common/mtk-base-afe.h"
+
+enum {
+	MT8183_MEMIF_DL1,
+	MT8183_MEMIF_DL2,
+	MT8183_MEMIF_DL3,
+	MT8183_MEMIF_VUL12,
+	MT8183_MEMIF_VUL2,
+	MT8183_MEMIF_AWB,
+	MT8183_MEMIF_AWB2,
+	MT8183_MEMIF_MOD_DAI,
+	MT8183_MEMIF_HDMI,
+	MT8183_MEMIF_NUM,
+	MT8183_DAI_ADDA = MT8183_MEMIF_NUM,
+	MT8183_DAI_PCM_1,
+	MT8183_DAI_PCM_2,
+	MT8183_DAI_I2S_0,
+	MT8183_DAI_I2S_1,
+	MT8183_DAI_I2S_2,
+	MT8183_DAI_I2S_3,
+	MT8183_DAI_I2S_5,
+	MT8183_DAI_TDM,
+	MT8183_DAI_HOSTLESS_LPBK,
+	MT8183_DAI_HOSTLESS_SPEECH,
+	MT8183_DAI_NUM,
+};
+
+enum {
+	MT8183_IRQ_0,
+	MT8183_IRQ_1,
+	MT8183_IRQ_2,
+	MT8183_IRQ_3,
+	MT8183_IRQ_4,
+	MT8183_IRQ_5,
+	MT8183_IRQ_6,
+	MT8183_IRQ_7,
+	MT8183_IRQ_8,	/* hw bundle to TDM */
+	MT8183_IRQ_11,
+	MT8183_IRQ_12,
+	MT8183_IRQ_NUM,
+};
+
+enum {
+	MT8183_MTKAIF_PROTOCOL_1 = 0,
+	MT8183_MTKAIF_PROTOCOL_2,
+	MT8183_MTKAIF_PROTOCOL_2_CLK_P2,
+};
+
+/* MCLK */
+enum {
+	MT8183_I2S0_MCK = 0,
+	MT8183_I2S1_MCK,
+	MT8183_I2S2_MCK,
+	MT8183_I2S3_MCK,
+	MT8183_I2S4_MCK,
+	MT8183_I2S4_BCK,
+	MT8183_I2S5_MCK,
+	MT8183_MCK_NUM,
+};
+
+struct clk;
+
+struct mt8183_afe_private {
+	struct clk **clk;
+
+	int pm_runtime_bypass_reg_ctl;
+
+	/* dai */
+	void *dai_priv[MT8183_DAI_NUM];
+
+	/* adda */
+	int mtkaif_protocol;
+	int mtkaif_calibration_ok;
+	int mtkaif_chosen_phase[4];
+	int mtkaif_phase_cycle[4];
+	int mtkaif_calibration_num_phase;
+	int mtkaif_dmic;
+
+	/* mck */
+	int mck_rate[MT8183_MCK_NUM];
+};
+
+unsigned int mt8183_general_rate_transform(struct device *dev,
+					   unsigned int rate);
+unsigned int mt8183_rate_transform(struct device *dev,
+				   unsigned int rate, int aud_blk);
+
+/* dai register */
+int mt8183_dai_adda_register(struct mtk_base_afe *afe);
+int mt8183_dai_pcm_register(struct mtk_base_afe *afe);
+int mt8183_dai_i2s_register(struct mtk_base_afe *afe);
+int mt8183_dai_tdm_register(struct mtk_base_afe *afe);
+int mt8183_dai_hostless_register(struct mtk_base_afe *afe);
+#endif
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
new file mode 100644
index 0000000..ff3111e
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -0,0 +1,1237 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Mediatek ALSA SoC AFE platform driver for 8183
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+
+#include "mt8183-afe-common.h"
+#include "mt8183-afe-clk.h"
+#include "mt8183-interconnection.h"
+#include "mt8183-reg.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-afe-fe-dai.h"
+
+enum {
+	MTK_AFE_RATE_8K = 0,
+	MTK_AFE_RATE_11K = 1,
+	MTK_AFE_RATE_12K = 2,
+	MTK_AFE_RATE_384K = 3,
+	MTK_AFE_RATE_16K = 4,
+	MTK_AFE_RATE_22K = 5,
+	MTK_AFE_RATE_24K = 6,
+	MTK_AFE_RATE_130K = 7,
+	MTK_AFE_RATE_32K = 8,
+	MTK_AFE_RATE_44K = 9,
+	MTK_AFE_RATE_48K = 10,
+	MTK_AFE_RATE_88K = 11,
+	MTK_AFE_RATE_96K = 12,
+	MTK_AFE_RATE_176K = 13,
+	MTK_AFE_RATE_192K = 14,
+	MTK_AFE_RATE_260K = 15,
+};
+
+enum {
+	MTK_AFE_DAI_MEMIF_RATE_8K = 0,
+	MTK_AFE_DAI_MEMIF_RATE_16K = 1,
+	MTK_AFE_DAI_MEMIF_RATE_32K = 2,
+	MTK_AFE_DAI_MEMIF_RATE_48K = 3,
+};
+
+enum {
+	MTK_AFE_PCM_RATE_8K = 0,
+	MTK_AFE_PCM_RATE_16K = 1,
+	MTK_AFE_PCM_RATE_32K = 2,
+	MTK_AFE_PCM_RATE_48K = 3,
+};
+
+unsigned int mt8183_general_rate_transform(struct device *dev,
+					   unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_RATE_8K;
+	case 11025:
+		return MTK_AFE_RATE_11K;
+	case 12000:
+		return MTK_AFE_RATE_12K;
+	case 16000:
+		return MTK_AFE_RATE_16K;
+	case 22050:
+		return MTK_AFE_RATE_22K;
+	case 24000:
+		return MTK_AFE_RATE_24K;
+	case 32000:
+		return MTK_AFE_RATE_32K;
+	case 44100:
+		return MTK_AFE_RATE_44K;
+	case 48000:
+		return MTK_AFE_RATE_48K;
+	case 88200:
+		return MTK_AFE_RATE_88K;
+	case 96000:
+		return MTK_AFE_RATE_96K;
+	case 130000:
+		return MTK_AFE_RATE_130K;
+	case 176400:
+		return MTK_AFE_RATE_176K;
+	case 192000:
+		return MTK_AFE_RATE_192K;
+	case 260000:
+		return MTK_AFE_RATE_260K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, use %d!!!\n",
+			 __func__, rate, MTK_AFE_RATE_48K);
+		return MTK_AFE_RATE_48K;
+	}
+}
+
+static unsigned int dai_memif_rate_transform(struct device *dev,
+					     unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_DAI_MEMIF_RATE_8K;
+	case 16000:
+		return MTK_AFE_DAI_MEMIF_RATE_16K;
+	case 32000:
+		return MTK_AFE_DAI_MEMIF_RATE_32K;
+	case 48000:
+		return MTK_AFE_DAI_MEMIF_RATE_48K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, use %d!!!\n",
+			 __func__, rate, MTK_AFE_DAI_MEMIF_RATE_16K);
+		return MTK_AFE_DAI_MEMIF_RATE_16K;
+	}
+}
+
+unsigned int mt8183_rate_transform(struct device *dev,
+				   unsigned int rate, int aud_blk)
+{
+	switch (aud_blk) {
+	case MT8183_MEMIF_MOD_DAI:
+		return dai_memif_rate_transform(dev, rate);
+	default:
+		return mt8183_general_rate_transform(dev, rate);
+	}
+}
+
+static const struct snd_pcm_hardware mt8183_afe_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		   SNDRV_PCM_FMTBIT_S24_LE |
+		   SNDRV_PCM_FMTBIT_S32_LE,
+	.period_bytes_min = 256,
+	.period_bytes_max = 4 * 48 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
+	.buffer_bytes_max = 8 * 48 * 1024,
+	.fifo_size = 0,
+};
+
+static int mt8183_memif_fs(struct snd_pcm_substream *substream,
+			   unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	int id = rtd->cpu_dai->id;
+
+	return mt8183_rate_transform(afe->dev, rate, id);
+}
+
+static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return mt8183_general_rate_transform(afe->dev, rate);
+}
+
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		       SNDRV_PCM_RATE_88200 |\
+		       SNDRV_PCM_RATE_96000 |\
+		       SNDRV_PCM_RATE_176400 |\
+		       SNDRV_PCM_RATE_192000)
+
+#define MTK_PCM_DAI_RATES (SNDRV_PCM_RATE_8000 |\
+			   SNDRV_PCM_RATE_16000 |\
+			   SNDRV_PCM_RATE_32000 |\
+			   SNDRV_PCM_RATE_48000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mt8183_memif_dai_driver[] = {
+	/* FE DAIs: memory intefaces to CPU */
+	{
+		.name = "DL1",
+		.id = MT8183_MEMIF_DL1,
+		.playback = {
+			.stream_name = "DL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "DL2",
+		.id = MT8183_MEMIF_DL2,
+		.playback = {
+			.stream_name = "DL2",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "DL3",
+		.id = MT8183_MEMIF_DL3,
+		.playback = {
+			.stream_name = "DL3",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL1",
+		.id = MT8183_MEMIF_VUL12,
+		.capture = {
+			.stream_name = "UL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL2",
+		.id = MT8183_MEMIF_AWB,
+		.capture = {
+			.stream_name = "UL2",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL3",
+		.id = MT8183_MEMIF_VUL2,
+		.capture = {
+			.stream_name = "UL3",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL4",
+		.id = MT8183_MEMIF_AWB2,
+		.capture = {
+			.stream_name = "UL4",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL_MONO_1",
+		.id = MT8183_MEMIF_MOD_DAI,
+		.capture = {
+			.stream_name = "UL_MONO_1",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = MTK_PCM_DAI_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "HDMI",
+		.id = MT8183_MEMIF_HDMI,
+		.playback = {
+			.stream_name = "HDMI",
+			.channels_min = 2,
+			.channels_max = 8,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+};
+
+/* dma widget & routes*/
+static const struct snd_kcontrol_new memif_ul1_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN21,
+				    I_ADDA_UL_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul1_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN22,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul2_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN5,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN5,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN5,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN5,
+				    I_DL3_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul2_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN6,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN6,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN6,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN6,
+				    I_DL3_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul3_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN32,
+				    I_ADDA_UL_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul3_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN33,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul4_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN38,
+				    I_ADDA_UL_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul4_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN39,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul_mono_1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN12,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN12,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mt8183_memif_widgets[] = {
+	/* memif */
+	SND_SOC_DAPM_MIXER("UL1_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul1_ch1_mix, ARRAY_SIZE(memif_ul1_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL1_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul1_ch2_mix, ARRAY_SIZE(memif_ul1_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL2_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul2_ch1_mix, ARRAY_SIZE(memif_ul2_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL2_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul2_ch2_mix, ARRAY_SIZE(memif_ul2_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL3_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul3_ch1_mix, ARRAY_SIZE(memif_ul3_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL3_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul3_ch2_mix, ARRAY_SIZE(memif_ul3_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL4_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul4_ch1_mix, ARRAY_SIZE(memif_ul4_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL4_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul4_ch2_mix, ARRAY_SIZE(memif_ul4_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL_MONO_1_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul_mono_1_mix,
+			   ARRAY_SIZE(memif_ul_mono_1_mix)),
+};
+
+static const struct snd_soc_dapm_route mt8183_memif_routes[] = {
+	/* capture */
+	{"UL1", NULL, "UL1_CH1"},
+	{"UL1", NULL, "UL1_CH2"},
+	{"UL1_CH1", "ADDA_UL_CH1", "ADDA Capture"},
+	{"UL1_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+
+	{"UL2", NULL, "UL2_CH1"},
+	{"UL2", NULL, "UL2_CH2"},
+	{"UL2_CH1", "ADDA_UL_CH1", "ADDA Capture"},
+	{"UL2_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+
+	{"UL3", NULL, "UL3_CH1"},
+	{"UL3", NULL, "UL3_CH2"},
+	{"UL3_CH1", "ADDA_UL_CH1", "ADDA Capture"},
+	{"UL3_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+
+	{"UL4", NULL, "UL4_CH1"},
+	{"UL4", NULL, "UL4_CH2"},
+	{"UL4_CH1", "ADDA_UL_CH1", "ADDA Capture"},
+	{"UL4_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+
+	{"UL_MONO_1", NULL, "UL_MONO_1_CH1"},
+	{"UL_MONO_1_CH1", "ADDA_UL_CH1", "ADDA Capture"},
+	{"UL_MONO_1_CH1", "ADDA_UL_CH2", "ADDA Capture"},
+};
+
+static const struct snd_soc_component_driver mt8183_afe_pcm_dai_component = {
+	.name = "mt8183-afe-pcm-dai",
+};
+
+static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
+	[MT8183_MEMIF_DL1] = {
+		.name = "DL1",
+		.id = MT8183_MEMIF_DL1,
+		.reg_ofs_base = AFE_DL1_BASE,
+		.reg_ofs_cur = AFE_DL1_CUR,
+		.fs_reg = AFE_DAC_CON1,
+		.fs_shift = DL1_MODE_SFT,
+		.fs_maskbit = DL1_MODE_MASK,
+		.mono_reg = AFE_DAC_CON1,
+		.mono_shift = DL1_DATA_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL1_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = DL1_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_DL2] = {
+		.name = "DL2",
+		.id = MT8183_MEMIF_DL2,
+		.reg_ofs_base = AFE_DL2_BASE,
+		.reg_ofs_cur = AFE_DL2_CUR,
+		.fs_reg = AFE_DAC_CON1,
+		.fs_shift = DL2_MODE_SFT,
+		.fs_maskbit = DL2_MODE_MASK,
+		.mono_reg = AFE_DAC_CON1,
+		.mono_shift = DL2_DATA_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL2_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = DL2_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_DL3] = {
+		.name = "DL3",
+		.id = MT8183_MEMIF_DL3,
+		.reg_ofs_base = AFE_DL3_BASE,
+		.reg_ofs_cur = AFE_DL3_CUR,
+		.fs_reg = AFE_DAC_CON2,
+		.fs_shift = DL3_MODE_SFT,
+		.fs_maskbit = DL3_MODE_MASK,
+		.mono_reg = AFE_DAC_CON1,
+		.mono_shift = DL3_DATA_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL3_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = DL3_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_VUL2] = {
+		.name = "VUL2",
+		.id = MT8183_MEMIF_VUL2,
+		.reg_ofs_base = AFE_VUL2_BASE,
+		.reg_ofs_cur = AFE_VUL2_CUR,
+		.fs_reg = AFE_DAC_CON2,
+		.fs_shift = VUL2_MODE_SFT,
+		.fs_maskbit = VUL2_MODE_MASK,
+		.mono_reg = AFE_DAC_CON2,
+		.mono_shift = VUL2_DATA_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL2_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = VUL2_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_AWB] = {
+		.name = "AWB",
+		.id = MT8183_MEMIF_AWB,
+		.reg_ofs_base = AFE_AWB_BASE,
+		.reg_ofs_cur = AFE_AWB_CUR,
+		.fs_reg = AFE_DAC_CON1,
+		.fs_shift = AWB_MODE_SFT,
+		.fs_maskbit = AWB_MODE_MASK,
+		.mono_reg = AFE_DAC_CON1,
+		.mono_shift = AWB_DATA_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = AWB_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = AWB_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_AWB2] = {
+		.name = "AWB2",
+		.id = MT8183_MEMIF_AWB2,
+		.reg_ofs_base = AFE_AWB2_BASE,
+		.reg_ofs_cur = AFE_AWB2_CUR,
+		.fs_reg = AFE_DAC_CON2,
+		.fs_shift = AWB2_MODE_SFT,
+		.fs_maskbit = AWB2_MODE_MASK,
+		.mono_reg = AFE_DAC_CON2,
+		.mono_shift = AWB2_DATA_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = AWB2_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = AWB2_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_VUL12] = {
+		.name = "VUL12",
+		.id = MT8183_MEMIF_VUL12,
+		.reg_ofs_base = AFE_VUL_D2_BASE,
+		.reg_ofs_cur = AFE_VUL_D2_CUR,
+		.fs_reg = AFE_DAC_CON0,
+		.fs_shift = VUL12_MODE_SFT,
+		.fs_maskbit = VUL12_MODE_MASK,
+		.mono_reg = AFE_DAC_CON0,
+		.mono_shift = VUL12_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL12_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = VUL12_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_MOD_DAI] = {
+		.name = "MOD_DAI",
+		.id = MT8183_MEMIF_MOD_DAI,
+		.reg_ofs_base = AFE_MOD_DAI_BASE,
+		.reg_ofs_cur = AFE_MOD_DAI_CUR,
+		.fs_reg = AFE_DAC_CON1,
+		.fs_shift = MOD_DAI_MODE_SFT,
+		.fs_maskbit = MOD_DAI_MODE_MASK,
+		.mono_reg = -1,
+		.mono_shift = 0,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = MOD_DAI_ON_SFT,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = MOD_DAI_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8183_MEMIF_HDMI] = {
+		.name = "HDMI",
+		.id = MT8183_MEMIF_HDMI,
+		.reg_ofs_base = AFE_HDMI_OUT_BASE,
+		.reg_ofs_cur = AFE_HDMI_OUT_CUR,
+		.fs_reg = -1,
+		.fs_shift = -1,
+		.fs_maskbit = -1,
+		.mono_reg = -1,
+		.mono_shift = -1,
+		.enable_reg = -1,	/* control in tdm for sync start */
+		.enable_shift = -1,
+		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_shift = HDMI_HD_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+};
+
+static const struct mtk_base_irq_data irq_data[MT8183_IRQ_NUM] = {
+	[MT8183_IRQ_0] = {
+		.id = MT8183_IRQ_0,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT0,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ0_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ0_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ0_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ0_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_1] = {
+		.id = MT8183_IRQ_1,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT1,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ1_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ1_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ1_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ1_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_2] = {
+		.id = MT8183_IRQ_2,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT2,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ2_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ2_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ2_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ2_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_3] = {
+		.id = MT8183_IRQ_3,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT3,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ3_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ3_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ3_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ3_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_4] = {
+		.id = MT8183_IRQ_4,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT4,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ4_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ4_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ4_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ4_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_5] = {
+		.id = MT8183_IRQ_5,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT5,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ5_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ5_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ5_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ5_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_6] = {
+		.id = MT8183_IRQ_6,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT6,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ6_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ6_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ6_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ6_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_7] = {
+		.id = MT8183_IRQ_7,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT7,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ7_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ7_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ7_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ7_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_8] = {
+		.id = MT8183_IRQ_8,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT8,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = -1,
+		.irq_fs_shift = -1,
+		.irq_fs_maskbit = -1,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ8_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ8_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_11] = {
+		.id = MT8183_IRQ_11,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT11,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ11_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ11_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ11_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ11_MCU_CLR_SFT,
+	},
+	[MT8183_IRQ_12] = {
+		.id = MT8183_IRQ_12,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT12,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ12_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ12_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ12_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ12_MCU_CLR_SFT,
+	},
+};
+
+static bool mt8183_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* these auto-gen reg has read-only bit, so put it as volatile */
+	/* volatile reg cannot be cached, so cannot be set when power off */
+	switch (reg) {
+	case AUDIO_TOP_CON0:	/* reg bit controlled by CCF */
+	case AUDIO_TOP_CON1:	/* reg bit controlled by CCF */
+	case AUDIO_TOP_CON3:
+	case AFE_DL1_CUR:
+	case AFE_DL1_END:
+	case AFE_DL2_CUR:
+	case AFE_DL2_END:
+	case AFE_AWB_END:
+	case AFE_AWB_CUR:
+	case AFE_VUL_END:
+	case AFE_VUL_CUR:
+	case AFE_MEMIF_MON0:
+	case AFE_MEMIF_MON1:
+	case AFE_MEMIF_MON2:
+	case AFE_MEMIF_MON3:
+	case AFE_MEMIF_MON4:
+	case AFE_MEMIF_MON5:
+	case AFE_MEMIF_MON6:
+	case AFE_MEMIF_MON7:
+	case AFE_MEMIF_MON8:
+	case AFE_MEMIF_MON9:
+	case AFE_ADDA_SRC_DEBUG_MON0:
+	case AFE_ADDA_SRC_DEBUG_MON1:
+	case AFE_ADDA_UL_SRC_MON0:
+	case AFE_ADDA_UL_SRC_MON1:
+	case AFE_SIDETONE_MON:
+	case AFE_SIDETONE_CON0:
+	case AFE_SIDETONE_COEFF:
+	case AFE_BUS_MON0:
+	case AFE_MRGIF_MON0:
+	case AFE_MRGIF_MON1:
+	case AFE_MRGIF_MON2:
+	case AFE_I2S_MON:
+	case AFE_DAC_MON:
+	case AFE_VUL2_END:
+	case AFE_VUL2_CUR:
+	case AFE_IRQ0_MCU_CNT_MON:
+	case AFE_IRQ6_MCU_CNT_MON:
+	case AFE_MOD_DAI_END:
+	case AFE_MOD_DAI_CUR:
+	case AFE_VUL_D2_END:
+	case AFE_VUL_D2_CUR:
+	case AFE_DL3_CUR:
+	case AFE_DL3_END:
+	case AFE_HDMI_OUT_CON0:
+	case AFE_HDMI_OUT_CUR:
+	case AFE_HDMI_OUT_END:
+	case AFE_IRQ3_MCU_CNT_MON:
+	case AFE_IRQ4_MCU_CNT_MON:
+	case AFE_IRQ_MCU_STATUS:
+	case AFE_IRQ_MCU_CLR:
+	case AFE_IRQ_MCU_MON2:
+	case AFE_IRQ1_MCU_CNT_MON:
+	case AFE_IRQ2_MCU_CNT_MON:
+	case AFE_IRQ1_MCU_EN_CNT_MON:
+	case AFE_IRQ5_MCU_CNT_MON:
+	case AFE_IRQ7_MCU_CNT_MON:
+	case AFE_GAIN1_CUR:
+	case AFE_GAIN2_CUR:
+	case AFE_SRAM_DELSEL_CON0:
+	case AFE_SRAM_DELSEL_CON2:
+	case AFE_SRAM_DELSEL_CON3:
+	case AFE_ASRC_2CH_CON12:
+	case AFE_ASRC_2CH_CON13:
+	case PCM_INTF_CON2:
+	case FPGA_CFG0:
+	case FPGA_CFG1:
+	case FPGA_CFG2:
+	case FPGA_CFG3:
+	case AUDIO_TOP_DBG_MON0:
+	case AUDIO_TOP_DBG_MON1:
+	case AFE_IRQ8_MCU_CNT_MON:
+	case AFE_IRQ11_MCU_CNT_MON:
+	case AFE_IRQ12_MCU_CNT_MON:
+	case AFE_CBIP_MON0:
+	case AFE_CBIP_SLV_MUX_MON0:
+	case AFE_CBIP_SLV_DECODER_MON0:
+	case AFE_ADDA6_SRC_DEBUG_MON0:
+	case AFE_ADD6A_UL_SRC_MON0:
+	case AFE_ADDA6_UL_SRC_MON1:
+	case AFE_DL1_CUR_MSB:
+	case AFE_DL2_CUR_MSB:
+	case AFE_AWB_CUR_MSB:
+	case AFE_VUL_CUR_MSB:
+	case AFE_VUL2_CUR_MSB:
+	case AFE_MOD_DAI_CUR_MSB:
+	case AFE_VUL_D2_CUR_MSB:
+	case AFE_DL3_CUR_MSB:
+	case AFE_HDMI_OUT_CUR_MSB:
+	case AFE_AWB2_END:
+	case AFE_AWB2_CUR:
+	case AFE_AWB2_CUR_MSB:
+	case AFE_ADDA_DL_SDM_FIFO_MON:
+	case AFE_ADDA_DL_SRC_LCH_MON:
+	case AFE_ADDA_DL_SRC_RCH_MON:
+	case AFE_ADDA_DL_SDM_OUT_MON:
+	case AFE_CONNSYS_I2S_MON:
+	case AFE_ASRC_2CH_CON0:
+	case AFE_ASRC_2CH_CON2:
+	case AFE_ASRC_2CH_CON3:
+	case AFE_ASRC_2CH_CON4:
+	case AFE_ASRC_2CH_CON5:
+	case AFE_ASRC_2CH_CON7:
+	case AFE_ASRC_2CH_CON8:
+	case AFE_MEMIF_MON12:
+	case AFE_MEMIF_MON13:
+	case AFE_MEMIF_MON14:
+	case AFE_MEMIF_MON15:
+	case AFE_MEMIF_MON16:
+	case AFE_MEMIF_MON17:
+	case AFE_MEMIF_MON18:
+	case AFE_MEMIF_MON19:
+	case AFE_MEMIF_MON20:
+	case AFE_MEMIF_MON21:
+	case AFE_MEMIF_MON22:
+	case AFE_MEMIF_MON23:
+	case AFE_MEMIF_MON24:
+	case AFE_ADDA_MTKAIF_MON0:
+	case AFE_ADDA_MTKAIF_MON1:
+	case AFE_AUD_PAD_TOP:
+	case AFE_GENERAL1_ASRC_2CH_CON0:
+	case AFE_GENERAL1_ASRC_2CH_CON2:
+	case AFE_GENERAL1_ASRC_2CH_CON3:
+	case AFE_GENERAL1_ASRC_2CH_CON4:
+	case AFE_GENERAL1_ASRC_2CH_CON5:
+	case AFE_GENERAL1_ASRC_2CH_CON7:
+	case AFE_GENERAL1_ASRC_2CH_CON8:
+	case AFE_GENERAL1_ASRC_2CH_CON12:
+	case AFE_GENERAL1_ASRC_2CH_CON13:
+	case AFE_GENERAL2_ASRC_2CH_CON0:
+	case AFE_GENERAL2_ASRC_2CH_CON2:
+	case AFE_GENERAL2_ASRC_2CH_CON3:
+	case AFE_GENERAL2_ASRC_2CH_CON4:
+	case AFE_GENERAL2_ASRC_2CH_CON5:
+	case AFE_GENERAL2_ASRC_2CH_CON7:
+	case AFE_GENERAL2_ASRC_2CH_CON8:
+	case AFE_GENERAL2_ASRC_2CH_CON12:
+	case AFE_GENERAL2_ASRC_2CH_CON13:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config mt8183_afe_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+
+	.volatile_reg = mt8183_is_volatile_reg,
+
+	.max_register = AFE_MAX_REGISTER,
+	.num_reg_defaults_raw = AFE_MAX_REGISTER,
+
+	.cache_type = REGCACHE_FLAT,
+};
+
+static irqreturn_t mt8183_afe_irq_handler(int irq_id, void *dev)
+{
+	struct mtk_base_afe *afe = dev;
+	struct mtk_base_afe_irq *irq;
+	unsigned int status;
+	unsigned int status_mcu;
+	unsigned int mcu_en;
+	int ret;
+	int i;
+	irqreturn_t irq_ret = IRQ_HANDLED;
+
+	/* get irq that is sent to MCU */
+	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);
+
+	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &status);
+	/* only care IRQ which is sent to MCU */
+	status_mcu = status & mcu_en & AFE_IRQ_STATUS_BITS;
+
+	if (ret || status_mcu == 0) {
+		dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x, mcu_en 0x%x\n",
+			__func__, ret, status, mcu_en);
+
+		irq_ret = IRQ_NONE;
+		goto err_irq;
+	}
+
+	for (i = 0; i < MT8183_MEMIF_NUM; i++) {
+		struct mtk_base_afe_memif *memif = &afe->memif[i];
+
+		if (!memif->substream)
+			continue;
+
+		if (memif->irq_usage < 0)
+			continue;
+
+		irq = &afe->irqs[memif->irq_usage];
+
+		if (status_mcu & (1 << irq->irq_data->irq_en_shift))
+			snd_pcm_period_elapsed(memif->substream);
+	}
+
+err_irq:
+	/* clear irq */
+	regmap_write(afe->regmap,
+		     AFE_IRQ_MCU_CLR,
+		     status_mcu);
+
+	return irq_ret;
+}
+
+static int mt8183_afe_runtime_suspend(struct device *dev)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	unsigned int value;
+	int ret;
+
+	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
+		goto skip_regmap;
+
+	/* disable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, AFE_ON_MASK_SFT, 0x0);
+
+	ret = regmap_read_poll_timeout(afe->regmap,
+				       AFE_DAC_MON,
+				       value,
+				       (value & AFE_ON_RETM_MASK_SFT) == 0,
+				       20,
+				       1 * 1000 * 1000);
+	if (ret)
+		dev_warn(afe->dev, "%s(), ret %d\n", __func__, ret);
+
+	/* make sure all irq status are cleared, twice intended */
+	regmap_update_bits(afe->regmap, AFE_IRQ_MCU_CLR, 0xffff, 0xffff);
+	regmap_update_bits(afe->regmap, AFE_IRQ_MCU_CLR, 0xffff, 0xffff);
+
+	/* cache only */
+	regcache_cache_only(afe->regmap, true);
+	regcache_mark_dirty(afe->regmap);
+
+skip_regmap:
+	return mt8183_afe_disable_clock(afe);
+}
+
+static int mt8183_afe_runtime_resume(struct device *dev)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	ret = mt8183_afe_enable_clock(afe);
+	if (ret)
+		return ret;
+
+	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
+		goto skip_regmap;
+
+	regcache_cache_only(afe->regmap, false);
+	regcache_sync(afe->regmap);
+
+	/* enable audio sys DCM for power saving */
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0, 0x1 << 29, 0x1 << 29);
+
+	/* force cpu use 8_24 format when writing 32bit data */
+	regmap_update_bits(afe->regmap, AFE_MEMIF_MSB,
+			   CPU_HD_ALIGN_MASK_SFT, 0 << CPU_HD_ALIGN_SFT);
+
+	/* set all output port to 24bit */
+	regmap_write(afe->regmap, AFE_CONN_24BIT, 0xffffffff);
+	regmap_write(afe->regmap, AFE_CONN_24BIT_1, 0xffffffff);
+
+	/* enable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
+
+skip_regmap:
+	return 0;
+}
+
+static int mt8183_afe_component_probe(struct snd_soc_component *component)
+{
+	return mtk_afe_add_sub_dai_control(component);
+}
+
+static const struct snd_soc_component_driver mt8183_afe_component = {
+	.name = AFE_PCM_NAME,
+	.ops = &mtk_afe_pcm_ops,
+	.pcm_new = mtk_afe_pcm_new,
+	.pcm_free = mtk_afe_pcm_free,
+	.probe = mt8183_afe_component_probe,
+};
+
+static int mt8183_dai_memif_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mt8183_memif_dai_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mt8183_memif_dai_driver);
+
+	dai->dapm_widgets = mt8183_memif_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mt8183_memif_widgets);
+	dai->dapm_routes = mt8183_memif_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mt8183_memif_routes);
+	return 0;
+}
+
+typedef int (*dai_register_cb)(struct mtk_base_afe *);
+static const dai_register_cb dai_register_cbs[] = {
+	mt8183_dai_adda_register,
+	mt8183_dai_i2s_register,
+	mt8183_dai_pcm_register,
+	mt8183_dai_tdm_register,
+	mt8183_dai_hostless_register,
+	mt8183_dai_memif_register,
+};
+
+static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
+{
+	struct mtk_base_afe *afe;
+	struct mt8183_afe_private *afe_priv;
+	struct device *dev;
+	int i, irq_id, ret;
+
+	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, afe);
+
+	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+					  GFP_KERNEL);
+	if (!afe->platform_priv)
+		return -ENOMEM;
+
+	afe_priv = afe->platform_priv;
+	afe->dev = &pdev->dev;
+	dev = afe->dev;
+
+	/* initial audio related clock */
+	ret = mt8183_init_clock(afe);
+	if (ret) {
+		dev_err(dev, "init clock error\n");
+		return ret;
+	}
+
+	pm_runtime_enable(dev);
+
+	/* regmap init */
+	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(afe->regmap)) {
+		dev_err(dev, "could not get regmap from parent\n");
+		return PTR_ERR(afe->regmap);
+	}
+	ret = regmap_attach_dev(dev, afe->regmap, &mt8183_afe_regmap_config);
+	if (ret) {
+		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
+		return ret;
+	}
+
+	/* enable clock for regcache get default value from hw */
+	afe_priv->pm_runtime_bypass_reg_ctl = true;
+	pm_runtime_get_sync(&pdev->dev);
+
+	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
+	if (ret) {
+		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_put_sync(&pdev->dev);
+	afe_priv->pm_runtime_bypass_reg_ctl = false;
+
+	regcache_cache_only(afe->regmap, true);
+	regcache_mark_dirty(afe->regmap);
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	/* init memif */
+	afe->memif_size = MT8183_MEMIF_NUM;
+	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
+				  GFP_KERNEL);
+	if (!afe->memif)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->memif_size; i++) {
+		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].irq_usage = -1;
+	}
+
+	afe->memif[MT8183_MEMIF_HDMI].irq_usage = MT8183_IRQ_8;
+	afe->memif[MT8183_MEMIF_HDMI].const_irq = 1;
+
+	mutex_init(&afe->irq_alloc_lock);
+
+	/* init memif */
+	/* irq initialize */
+	afe->irqs_size = MT8183_IRQ_NUM;
+	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
+				 GFP_KERNEL);
+	if (!afe->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->irqs_size; i++)
+		afe->irqs[i].irq_data = &irq_data[i];
+
+	/* request irq */
+	irq_id = platform_get_irq(pdev, 0);
+	if (!irq_id) {
+		dev_err(dev, "%s no irq found\n", dev->of_node->name);
+		return -ENXIO;
+	}
+	ret = devm_request_irq(dev, irq_id, mt8183_afe_irq_handler,
+			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
+	if (ret) {
+		dev_err(dev, "could not request_irq for asys-isr\n");
+		return ret;
+	}
+
+	/* init sub_dais */
+	INIT_LIST_HEAD(&afe->sub_dais);
+
+	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
+		ret = dai_register_cbs[i](afe);
+		if (ret) {
+			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
+				 i, ret);
+			return ret;
+		}
+	}
+
+	/* init dai_driver and component_driver */
+	ret = mtk_afe_combine_sub_dai(afe);
+	if (ret) {
+		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
+			 ret);
+		return ret;
+	}
+
+	afe->mtk_afe_hardware = &mt8183_afe_hardware;
+	afe->memif_fs = mt8183_memif_fs;
+	afe->irq_fs = mt8183_irq_fs;
+
+	afe->runtime_resume = mt8183_afe_runtime_resume;
+	afe->runtime_suspend = mt8183_afe_runtime_suspend;
+
+	/* register component */
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &mt8183_afe_component,
+					      NULL, 0);
+	if (ret) {
+		dev_warn(dev, "err_platform\n");
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_component(afe->dev,
+					      &mt8183_afe_pcm_dai_component,
+					      afe->dai_drivers,
+					      afe->num_dai_drivers);
+	if (ret) {
+		dev_warn(dev, "err_dai_component\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int mt8183_afe_pcm_dev_remove(struct platform_device *pdev)
+{
+	pm_runtime_put_sync(&pdev->dev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mt8183_afe_runtime_suspend(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id mt8183_afe_pcm_dt_match[] = {
+	{ .compatible = "mediatek,mt8183-audio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt8183_afe_pcm_dt_match);
+
+static const struct dev_pm_ops mt8183_afe_pm_ops = {
+	SET_RUNTIME_PM_OPS(mt8183_afe_runtime_suspend,
+			   mt8183_afe_runtime_resume, NULL)
+};
+
+static struct platform_driver mt8183_afe_pcm_driver = {
+	.driver = {
+		   .name = "mt8183-audio",
+		   .of_match_table = mt8183_afe_pcm_dt_match,
+#ifdef CONFIG_PM
+		   .pm = &mt8183_afe_pm_ops,
+#endif
+	},
+	.probe = mt8183_afe_pcm_dev_probe,
+	.remove = mt8183_afe_pcm_dev_remove,
+};
+
+module_platform_driver(mt8183_afe_pcm_driver);
+
+MODULE_DESCRIPTION("Mediatek ALSA SoC AFE platform driver for 8183");
+MODULE_AUTHOR("KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-adda.c b/sound/soc/mediatek/mt8183/mt8183-dai-adda.c
new file mode 100644
index 0000000..017d7d1
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-adda.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI ADDA Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include "mt8183-afe-common.h"
+#include "mt8183-interconnection.h"
+#include "mt8183-reg.h"
+
+enum {
+	AUDIO_SDM_LEVEL_MUTE = 0,
+	AUDIO_SDM_LEVEL_NORMAL = 0x1d,
+	/* if you change level normal */
+	/* you need to change formula of hp impedance and dc trim too */
+};
+
+enum {
+	DELAY_DATA_MISO1 = 0,
+	DELAY_DATA_MISO2,
+};
+
+enum {
+	MTK_AFE_ADDA_DL_RATE_8K = 0,
+	MTK_AFE_ADDA_DL_RATE_11K = 1,
+	MTK_AFE_ADDA_DL_RATE_12K = 2,
+	MTK_AFE_ADDA_DL_RATE_16K = 3,
+	MTK_AFE_ADDA_DL_RATE_22K = 4,
+	MTK_AFE_ADDA_DL_RATE_24K = 5,
+	MTK_AFE_ADDA_DL_RATE_32K = 6,
+	MTK_AFE_ADDA_DL_RATE_44K = 7,
+	MTK_AFE_ADDA_DL_RATE_48K = 8,
+	MTK_AFE_ADDA_DL_RATE_96K = 9,
+	MTK_AFE_ADDA_DL_RATE_192K = 10,
+};
+
+enum {
+	MTK_AFE_ADDA_UL_RATE_8K = 0,
+	MTK_AFE_ADDA_UL_RATE_16K = 1,
+	MTK_AFE_ADDA_UL_RATE_32K = 2,
+	MTK_AFE_ADDA_UL_RATE_48K = 3,
+	MTK_AFE_ADDA_UL_RATE_96K = 4,
+	MTK_AFE_ADDA_UL_RATE_192K = 5,
+	MTK_AFE_ADDA_UL_RATE_48K_HD = 6,
+};
+
+static unsigned int adda_dl_rate_transform(struct mtk_base_afe *afe,
+					   unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_ADDA_DL_RATE_8K;
+	case 11025:
+		return MTK_AFE_ADDA_DL_RATE_11K;
+	case 12000:
+		return MTK_AFE_ADDA_DL_RATE_12K;
+	case 16000:
+		return MTK_AFE_ADDA_DL_RATE_16K;
+	case 22050:
+		return MTK_AFE_ADDA_DL_RATE_22K;
+	case 24000:
+		return MTK_AFE_ADDA_DL_RATE_24K;
+	case 32000:
+		return MTK_AFE_ADDA_DL_RATE_32K;
+	case 44100:
+		return MTK_AFE_ADDA_DL_RATE_44K;
+	case 48000:
+		return MTK_AFE_ADDA_DL_RATE_48K;
+	case 96000:
+		return MTK_AFE_ADDA_DL_RATE_96K;
+	case 192000:
+		return MTK_AFE_ADDA_DL_RATE_192K;
+	default:
+		dev_warn(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
+			 __func__, rate);
+		return MTK_AFE_ADDA_DL_RATE_48K;
+	}
+}
+
+static unsigned int adda_ul_rate_transform(struct mtk_base_afe *afe,
+					   unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_ADDA_UL_RATE_8K;
+	case 16000:
+		return MTK_AFE_ADDA_UL_RATE_16K;
+	case 32000:
+		return MTK_AFE_ADDA_UL_RATE_32K;
+	case 48000:
+		return MTK_AFE_ADDA_UL_RATE_48K;
+	case 96000:
+		return MTK_AFE_ADDA_UL_RATE_96K;
+	case 192000:
+		return MTK_AFE_ADDA_UL_RATE_192K;
+	default:
+		dev_warn(afe->dev, "%s(), rate %d invalid, use 48kHz!!!\n",
+			 __func__, rate);
+		return MTK_AFE_ADDA_UL_RATE_48K;
+	}
+}
+
+/* dai component */
+static const struct snd_kcontrol_new mtk_adda_dl_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN3, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN3, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN3, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN3,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN3,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN3,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN3,
+				    I_PCM_2_CAP_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_adda_dl_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN4, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN4, I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN4, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN4, I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN4, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN4, I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN4,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN4,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN4,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN4,
+				    I_PCM_2_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2", AFE_CONN4,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH2", AFE_CONN4,
+				    I_PCM_2_CAP_CH2, 1, 0),
+};
+
+static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* update setting to dmic */
+		if (afe_priv->mtkaif_dmic) {
+			/* mtkaif_rxif_data_mode = 1, dmic */
+			regmap_update_bits(afe->regmap, AFE_ADDA_MTKAIF_RX_CFG0,
+					   0x1, 0x1);
+
+			/* dmic mode, 3.25M*/
+			regmap_update_bits(afe->regmap, AFE_ADDA_MTKAIF_RX_CFG0,
+					   0x0, 0xf << 20);
+			regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0,
+					   0x0, 0x1 << 5);
+			regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0,
+					   0x0, 0x3 << 14);
+
+			/* turn on dmic, ch1, ch2 */
+			regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0,
+					   0x1 << 1, 0x1 << 1);
+			regmap_update_bits(afe->regmap, AFE_ADDA_UL_SRC_CON0,
+					   0x3 << 21, 0x3 << 21);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* should delayed 1/fs(smallest is 8k) = 125us before afe off */
+		usleep_range(125, 135);
+
+		/* reset dmic */
+		afe_priv->mtkaif_dmic = 0;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* mtkaif dmic */
+static const char * const mt8183_adda_off_on_str[] = {
+	"Off", "On"
+};
+
+static const struct soc_enum mt8183_adda_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8183_adda_off_on_str),
+			    mt8183_adda_off_on_str),
+};
+
+static int mt8183_adda_dmic_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->mtkaif_dmic;
+
+	return 0;
+}
+
+static int mt8183_adda_dmic_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	afe_priv->mtkaif_dmic = ucontrol->value.integer.value[0];
+
+	dev_info(afe->dev, "%s(), kcontrol name %s, mtkaif_dmic %d\n",
+		 __func__, kcontrol->id.name, afe_priv->mtkaif_dmic);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new mtk_adda_controls[] = {
+	SOC_ENUM_EXT("MTKAIF_DMIC", mt8183_adda_enum[0],
+		     mt8183_adda_dmic_get, mt8183_adda_dmic_set),
+};
+
+enum {
+	SUPPLY_SEQ_ADDA_AFE_ON,
+	SUPPLY_SEQ_ADDA_DL_ON,
+	SUPPLY_SEQ_ADDA_UL_ON,
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
+	/* adda */
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch1_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch1_mix)),
+	SND_SOC_DAPM_MIXER("ADDA_DL_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_adda_dl_ch2_mix,
+			   ARRAY_SIZE(mtk_adda_dl_ch2_mix)),
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Enable", SUPPLY_SEQ_ADDA_AFE_ON,
+			      AFE_ADDA_UL_DL_CON0, ADDA_AFE_ON_SFT, 0,
+			      NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Playback Enable", SUPPLY_SEQ_ADDA_DL_ON,
+			      AFE_ADDA_DL_SRC2_CON0,
+			      DL_2_SRC_ON_TMP_CTL_PRE_SFT, 0,
+			      NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("ADDA Capture Enable", SUPPLY_SEQ_ADDA_UL_ON,
+			      AFE_ADDA_UL_SRC_CON0,
+			      UL_SRC_ON_TMP_CTL_SFT, 0,
+			      mtk_adda_ul_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_dac_clk"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_dac_predis_clk"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_adc_clk"),
+	SND_SOC_DAPM_CLOCK_SUPPLY("mtkaif_26m_clk"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_adda_routes[] = {
+	/* playback */
+	{"ADDA_DL_CH1", "DL1_CH1", "DL1"},
+	{"ADDA_DL_CH2", "DL1_CH1", "DL1"},
+	{"ADDA_DL_CH2", "DL1_CH2", "DL1"},
+
+	{"ADDA_DL_CH1", "DL2_CH1", "DL2"},
+	{"ADDA_DL_CH2", "DL2_CH1", "DL2"},
+	{"ADDA_DL_CH2", "DL2_CH2", "DL2"},
+
+	{"ADDA_DL_CH1", "DL3_CH1", "DL3"},
+	{"ADDA_DL_CH2", "DL3_CH1", "DL3"},
+	{"ADDA_DL_CH2", "DL3_CH2", "DL3"},
+
+	{"ADDA Playback", NULL, "ADDA_DL_CH1"},
+	{"ADDA Playback", NULL, "ADDA_DL_CH2"},
+
+	/* adda enable */
+	{"ADDA Playback", NULL, "ADDA Enable"},
+	{"ADDA Playback", NULL, "ADDA Playback Enable"},
+	{"ADDA Capture", NULL, "ADDA Enable"},
+	{"ADDA Capture", NULL, "ADDA Capture Enable"},
+
+	/* clk */
+	{"ADDA Playback", NULL, "mtkaif_26m_clk"},
+	{"ADDA Playback", NULL, "aud_dac_clk"},
+	{"ADDA Playback", NULL, "aud_dac_predis_clk"},
+
+	{"ADDA Capture", NULL, "mtkaif_26m_clk"},
+	{"ADDA Capture", NULL, "aud_adc_clk"},
+};
+
+static int set_mtkaif_rx(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int delay_data;
+	int delay_cycle;
+
+	switch (afe_priv->mtkaif_protocol) {
+	case MT8183_MTKAIF_PROTOCOL_2_CLK_P2:
+		regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x38);
+		regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x39);
+		/* mtkaif_rxif_clkinv_adc inverse for calibration */
+		regmap_write(afe->regmap, AFE_ADDA_MTKAIF_CFG0,
+			     0x80010000);
+
+		if (afe_priv->mtkaif_phase_cycle[0] >=
+		    afe_priv->mtkaif_phase_cycle[1]) {
+			delay_data = DELAY_DATA_MISO1;
+			delay_cycle = afe_priv->mtkaif_phase_cycle[0] -
+				      afe_priv->mtkaif_phase_cycle[1];
+		} else {
+			delay_data = DELAY_DATA_MISO2;
+			delay_cycle = afe_priv->mtkaif_phase_cycle[1] -
+				      afe_priv->mtkaif_phase_cycle[0];
+		}
+
+		regmap_update_bits(afe->regmap,
+				   AFE_ADDA_MTKAIF_RX_CFG2,
+				   MTKAIF_RXIF_DELAY_DATA_MASK_SFT,
+				   delay_data << MTKAIF_RXIF_DELAY_DATA_SFT);
+
+		regmap_update_bits(afe->regmap,
+				   AFE_ADDA_MTKAIF_RX_CFG2,
+				   MTKAIF_RXIF_DELAY_CYCLE_MASK_SFT,
+				   delay_cycle << MTKAIF_RXIF_DELAY_CYCLE_SFT);
+		break;
+	case MT8183_MTKAIF_PROTOCOL_2:
+		regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
+		regmap_write(afe->regmap, AFE_ADDA_MTKAIF_CFG0,
+			     0x00010000);
+		break;
+	case MT8183_MTKAIF_PROTOCOL_1:
+		regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
+		regmap_write(afe->regmap, AFE_ADDA_MTKAIF_CFG0, 0x0);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/* dai ops */
+static int mtk_dai_adda_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+
+	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d\n",
+		__func__, dai->id, substream->stream, rate);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		unsigned int dl_src2_con0 = 0;
+		unsigned int dl_src2_con1 = 0;
+
+		/* clean predistortion */
+		regmap_write(afe->regmap, AFE_ADDA_PREDIS_CON0, 0);
+		regmap_write(afe->regmap, AFE_ADDA_PREDIS_CON1, 0);
+
+		/* set sampling rate */
+		dl_src2_con0 = adda_dl_rate_transform(afe, rate) << 28;
+
+		/* set output mode */
+		switch (rate) {
+		case 192000:
+			dl_src2_con0 |= (0x1 << 24); /* UP_SAMPLING_RATE_X2 */
+			dl_src2_con0 |= 1 << 14;
+			break;
+		case 96000:
+			dl_src2_con0 |= (0x2 << 24); /* UP_SAMPLING_RATE_X4 */
+			dl_src2_con0 |= 1 << 14;
+			break;
+		default:
+			dl_src2_con0 |= (0x3 << 24); /* UP_SAMPLING_RATE_X8 */
+			break;
+		}
+
+		/* turn off mute function */
+		dl_src2_con0 |= (0x03 << 11);
+
+		/* set voice input data if input sample rate is 8k or 16k */
+		if (rate == 8000 || rate == 16000)
+			dl_src2_con0 |= 0x01 << 5;
+
+		/* SA suggest apply -0.3db to audio/speech path */
+		dl_src2_con1 = 0xf74f0000;
+
+		/* turn on down-link gain */
+		dl_src2_con0 = dl_src2_con0 | (0x01 << 1);
+
+		regmap_write(afe->regmap, AFE_ADDA_DL_SRC2_CON0, dl_src2_con0);
+		regmap_write(afe->regmap, AFE_ADDA_DL_SRC2_CON1, dl_src2_con1);
+
+		/* set sdm gain */
+		regmap_update_bits(afe->regmap,
+				   AFE_ADDA_DL_SDM_DCCOMP_CON,
+				   ATTGAIN_CTL_MASK_SFT,
+				   AUDIO_SDM_LEVEL_NORMAL << ATTGAIN_CTL_SFT);
+	} else {
+		unsigned int voice_mode = 0;
+		unsigned int ul_src_con0 = 0;	/* default value */
+
+		/* set mtkaif protocol */
+		set_mtkaif_rx(afe);
+
+		/* Using Internal ADC */
+		regmap_update_bits(afe->regmap,
+				   AFE_ADDA_TOP_CON0,
+				   0x1 << 0,
+				   0x0 << 0);
+
+		voice_mode = adda_ul_rate_transform(afe, rate);
+
+		ul_src_con0 |= (voice_mode << 17) & (0x7 << 17);
+
+		regmap_write(afe->regmap, AFE_ADDA_UL_SRC_CON0, ul_src_con0);
+
+		/* mtkaif_rxif_data_mode = 0, amic */
+		regmap_update_bits(afe->regmap,
+				   AFE_ADDA_MTKAIF_RX_CFG0,
+				   0x1 << 0,
+				   0x0 << 0);
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_adda_ops = {
+	.hw_params = mtk_dai_adda_hw_params,
+};
+
+/* dai driver */
+#define MTK_ADDA_PLAYBACK_RATES (SNDRV_PCM_RATE_8000_48000 |\
+				 SNDRV_PCM_RATE_96000 |\
+				 SNDRV_PCM_RATE_192000)
+
+#define MTK_ADDA_CAPTURE_RATES (SNDRV_PCM_RATE_8000 |\
+				SNDRV_PCM_RATE_16000 |\
+				SNDRV_PCM_RATE_32000 |\
+				SNDRV_PCM_RATE_48000)
+
+#define MTK_ADDA_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			  SNDRV_PCM_FMTBIT_S24_LE |\
+			  SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_adda_driver[] = {
+	{
+		.name = "ADDA",
+		.id = MT8183_DAI_ADDA,
+		.playback = {
+			.stream_name = "ADDA Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_PLAYBACK_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ADDA Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_ADDA_CAPTURE_RATES,
+			.formats = MTK_ADDA_FORMATS,
+		},
+		.ops = &mtk_dai_adda_ops,
+	},
+};
+
+int mt8183_dai_adda_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_adda_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_adda_driver);
+
+	dai->controls = mtk_adda_controls;
+	dai->num_controls = ARRAY_SIZE(mtk_adda_controls);
+	dai->dapm_widgets = mtk_dai_adda_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_adda_widgets);
+	dai->dapm_routes = mtk_dai_adda_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_adda_routes);
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-hostless.c b/sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
new file mode 100644
index 0000000..1667ad3
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI Hostless Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include "mt8183-afe-common.h"
+
+/* dai component */
+static const struct snd_soc_dapm_route mtk_dai_hostless_routes[] = {
+	/* Hostless ADDA Loopback */
+	{"ADDA_DL_CH1", "ADDA_UL_CH1", "Hostless LPBK DL"},
+	{"ADDA_DL_CH1", "ADDA_UL_CH2", "Hostless LPBK DL"},
+	{"ADDA_DL_CH2", "ADDA_UL_CH1", "Hostless LPBK DL"},
+	{"ADDA_DL_CH2", "ADDA_UL_CH2", "Hostless LPBK DL"},
+	{"Hostless LPBK UL", NULL, "ADDA Capture"},
+
+	/* Hostless Speech */
+	{"ADDA_DL_CH1", "PCM_1_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_1_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_1_CAP_CH2", "Hostless Speech DL"},
+	{"ADDA_DL_CH1", "PCM_2_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_2_CAP_CH1", "Hostless Speech DL"},
+	{"ADDA_DL_CH2", "PCM_2_CAP_CH2", "Hostless Speech DL"},
+	{"PCM_1_PB_CH1", "ADDA_UL_CH1", "Hostless Speech DL"},
+	{"PCM_1_PB_CH2", "ADDA_UL_CH2", "Hostless Speech DL"},
+	{"PCM_2_PB_CH1", "ADDA_UL_CH1", "Hostless Speech DL"},
+	{"PCM_2_PB_CH2", "ADDA_UL_CH2", "Hostless Speech DL"},
+
+	{"Hostless Speech UL", NULL, "PCM 1 Capture"},
+	{"Hostless Speech UL", NULL, "PCM 2 Capture"},
+	{"Hostless Speech UL", NULL, "ADDA Capture"},
+};
+
+/* dai ops */
+static int mtk_dai_hostless_startup(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	return snd_soc_set_runtime_hwparams(substream, afe->mtk_afe_hardware);
+}
+
+static const struct snd_soc_dai_ops mtk_dai_hostless_ops = {
+	.startup = mtk_dai_hostless_startup,
+};
+
+/* dai driver */
+#define MTK_HOSTLESS_RATES (SNDRV_PCM_RATE_8000_48000 |\
+			   SNDRV_PCM_RATE_88200 |\
+			   SNDRV_PCM_RATE_96000 |\
+			   SNDRV_PCM_RATE_176400 |\
+			   SNDRV_PCM_RATE_192000)
+
+#define MTK_HOSTLESS_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			     SNDRV_PCM_FMTBIT_S24_LE |\
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_hostless_driver[] = {
+	{
+		.name = "Hostless LPBK DAI",
+		.id = MT8183_DAI_HOSTLESS_LPBK,
+		.playback = {
+			.stream_name = "Hostless LPBK DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless LPBK UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+	{
+		.name = "Hostless Speech DAI",
+		.id = MT8183_DAI_HOSTLESS_SPEECH,
+		.playback = {
+			.stream_name = "Hostless Speech DL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Hostless Speech UL",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_HOSTLESS_RATES,
+			.formats = MTK_HOSTLESS_FORMATS,
+		},
+		.ops = &mtk_dai_hostless_ops,
+	},
+};
+
+int mt8183_dai_hostless_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_hostless_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_hostless_driver);
+
+	dai->dapm_routes = mtk_dai_hostless_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_hostless_routes);
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
new file mode 100644
index 0000000..c25024f
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -0,0 +1,1040 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI I2S Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8183-afe-clk.h"
+#include "mt8183-afe-common.h"
+#include "mt8183-interconnection.h"
+#include "mt8183-reg.h"
+
+enum {
+	I2S_FMT_EIAJ = 0,
+	I2S_FMT_I2S = 1,
+};
+
+enum {
+	I2S_WLEN_16_BIT = 0,
+	I2S_WLEN_32_BIT = 1,
+};
+
+enum {
+	I2S_HD_NORMAL = 0,
+	I2S_HD_LOW_JITTER = 1,
+};
+
+enum {
+	I2S1_SEL_O28_O29 = 0,
+	I2S1_SEL_O03_O04 = 1,
+};
+
+enum {
+	I2S_IN_PAD_CONNSYS = 0,
+	I2S_IN_PAD_IO_MUX = 1,
+};
+
+struct mtk_afe_i2s_priv {
+	int id;
+	int rate; /* for determine which apll to use */
+	int low_jitter_en;
+
+	const char *share_property_name;
+	int share_i2s_id;
+
+	int mclk_id;
+	int mclk_rate;
+	int mclk_apll;
+};
+
+static unsigned int get_i2s_wlen(snd_pcm_format_t format)
+{
+	return snd_pcm_format_physical_width(format) <= 16 ?
+	       I2S_WLEN_16_BIT : I2S_WLEN_32_BIT;
+}
+
+#define MTK_AFE_I2S0_KCONTROL_NAME "I2S0_HD_Mux"
+#define MTK_AFE_I2S1_KCONTROL_NAME "I2S1_HD_Mux"
+#define MTK_AFE_I2S2_KCONTROL_NAME "I2S2_HD_Mux"
+#define MTK_AFE_I2S3_KCONTROL_NAME "I2S3_HD_Mux"
+#define MTK_AFE_I2S5_KCONTROL_NAME "I2S5_HD_Mux"
+
+#define I2S0_HD_EN_W_NAME "I2S0_HD_EN"
+#define I2S1_HD_EN_W_NAME "I2S1_HD_EN"
+#define I2S2_HD_EN_W_NAME "I2S2_HD_EN"
+#define I2S3_HD_EN_W_NAME "I2S3_HD_EN"
+#define I2S5_HD_EN_W_NAME "I2S5_HD_EN"
+
+#define I2S0_MCLK_EN_W_NAME "I2S0_MCLK_EN"
+#define I2S1_MCLK_EN_W_NAME "I2S1_MCLK_EN"
+#define I2S2_MCLK_EN_W_NAME "I2S2_MCLK_EN"
+#define I2S3_MCLK_EN_W_NAME "I2S3_MCLK_EN"
+#define I2S5_MCLK_EN_W_NAME "I2S5_MCLK_EN"
+
+static int get_i2s_id_by_name(struct mtk_base_afe *afe,
+			      const char *name)
+{
+	if (strncmp(name, "I2S0", 4) == 0)
+		return MT8183_DAI_I2S_0;
+	else if (strncmp(name, "I2S1", 4) == 0)
+		return MT8183_DAI_I2S_1;
+	else if (strncmp(name, "I2S2", 4) == 0)
+		return MT8183_DAI_I2S_2;
+	else if (strncmp(name, "I2S3", 4) == 0)
+		return MT8183_DAI_I2S_3;
+	else if (strncmp(name, "I2S5", 4) == 0)
+		return MT8183_DAI_I2S_5;
+	else
+		return -EINVAL;
+}
+
+static struct mtk_afe_i2s_priv *get_i2s_priv_by_name(struct mtk_base_afe *afe,
+						     const char *name)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int dai_id = get_i2s_id_by_name(afe, name);
+
+	if (dai_id < 0)
+		return NULL;
+
+	return afe_priv->dai_priv[dai_id];
+}
+
+/* low jitter control */
+static const char * const mt8183_i2s_hd_str[] = {
+	"Normal", "Low_Jitter"
+};
+
+static const struct soc_enum mt8183_i2s_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8183_i2s_hd_str),
+			    mt8183_i2s_hd_str),
+};
+
+static int mt8183_i2s_hd_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+
+	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return -EINVAL;
+	}
+
+	ucontrol->value.integer.value[0] = i2s_priv->low_jitter_en;
+
+	return 0;
+}
+
+static int mt8183_i2s_hd_set(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int hd_en;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	hd_en = ucontrol->value.integer.value[0];
+
+	dev_info(afe->dev, "%s(), kcontrol name %s, hd_en %d\n",
+		 __func__, kcontrol->id.name, hd_en);
+
+	i2s_priv = get_i2s_priv_by_name(afe, kcontrol->id.name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return -EINVAL;
+	}
+
+	i2s_priv->low_jitter_en = hd_en;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new mtk_dai_i2s_controls[] = {
+	SOC_ENUM_EXT(MTK_AFE_I2S0_KCONTROL_NAME, mt8183_i2s_enum[0],
+		     mt8183_i2s_hd_get, mt8183_i2s_hd_set),
+	SOC_ENUM_EXT(MTK_AFE_I2S1_KCONTROL_NAME, mt8183_i2s_enum[0],
+		     mt8183_i2s_hd_get, mt8183_i2s_hd_set),
+	SOC_ENUM_EXT(MTK_AFE_I2S2_KCONTROL_NAME, mt8183_i2s_enum[0],
+		     mt8183_i2s_hd_get, mt8183_i2s_hd_set),
+	SOC_ENUM_EXT(MTK_AFE_I2S3_KCONTROL_NAME, mt8183_i2s_enum[0],
+		     mt8183_i2s_hd_get, mt8183_i2s_hd_set),
+	SOC_ENUM_EXT(MTK_AFE_I2S5_KCONTROL_NAME, mt8183_i2s_enum[0],
+		     mt8183_i2s_hd_get, mt8183_i2s_hd_set),
+};
+
+/* dai component */
+/* interconnection */
+static const struct snd_kcontrol_new mtk_i2s3_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN0, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN0, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN0, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN0,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN0,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN0,
+				    I_PCM_2_CAP_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_i2s3_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN1, I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN1, I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN1, I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN1,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN1,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN1,
+				    I_PCM_2_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2", AFE_CONN1,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH2", AFE_CONN1,
+				    I_PCM_2_CAP_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_i2s1_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN28, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN28, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN28, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN28,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN28,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN28,
+				    I_PCM_2_CAP_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_i2s1_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN29, I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN29, I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN29, I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN29,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN29,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN29,
+				    I_PCM_2_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2", AFE_CONN29,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH2", AFE_CONN29,
+				    I_PCM_2_CAP_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_i2s5_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN30, I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN30, I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN30, I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN30,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN30,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN30,
+				    I_PCM_2_CAP_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_i2s5_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2", AFE_CONN31, I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN31, I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN31, I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN31,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1", AFE_CONN31,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH1", AFE_CONN31,
+				    I_PCM_2_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2", AFE_CONN31,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_2_CAP_CH2", AFE_CONN31,
+				    I_PCM_2_CAP_CH2, 1, 0),
+};
+
+enum {
+	SUPPLY_SEQ_APLL,
+	SUPPLY_SEQ_I2S_MCLK_EN,
+	SUPPLY_SEQ_I2S_HD_EN,
+	SUPPLY_SEQ_I2S_EN,
+};
+
+static int mtk_apll_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+
+	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		 __func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (strcmp(w->name, APLL1_W_NAME) == 0)
+			mt8183_apll1_enable(afe);
+		else
+			mt8183_apll2_enable(afe);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		if (strcmp(w->name, APLL1_W_NAME) == 0)
+			mt8183_apll1_disable(afe);
+		else
+			mt8183_apll2_disable(afe);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_mclk_en_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol,
+			     int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+
+	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		 __func__, w->name, event);
+
+	i2s_priv = get_i2s_priv_by_name(afe, w->name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		mt8183_mck_enable(afe, i2s_priv->mclk_id, i2s_priv->mclk_rate);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		i2s_priv->mclk_rate = 0;
+		mt8183_mck_disable(afe, i2s_priv->mclk_id);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget mtk_dai_i2s_widgets[] = {
+	SND_SOC_DAPM_MIXER("I2S1_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_i2s1_ch1_mix,
+			   ARRAY_SIZE(mtk_i2s1_ch1_mix)),
+	SND_SOC_DAPM_MIXER("I2S1_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_i2s1_ch2_mix,
+			   ARRAY_SIZE(mtk_i2s1_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("I2S3_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_i2s3_ch1_mix,
+			   ARRAY_SIZE(mtk_i2s3_ch1_mix)),
+	SND_SOC_DAPM_MIXER("I2S3_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_i2s3_ch2_mix,
+			   ARRAY_SIZE(mtk_i2s3_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("I2S5_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_i2s5_ch1_mix,
+			   ARRAY_SIZE(mtk_i2s5_ch1_mix)),
+	SND_SOC_DAPM_MIXER("I2S5_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_i2s5_ch2_mix,
+			   ARRAY_SIZE(mtk_i2s5_ch2_mix)),
+
+	/* i2s en*/
+	SND_SOC_DAPM_SUPPLY_S("I2S0_EN", SUPPLY_SEQ_I2S_EN,
+			      AFE_I2S_CON, I2S_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S1_EN", SUPPLY_SEQ_I2S_EN,
+			      AFE_I2S_CON1, I2S_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S2_EN", SUPPLY_SEQ_I2S_EN,
+			      AFE_I2S_CON2, I2S_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S3_EN", SUPPLY_SEQ_I2S_EN,
+			      AFE_I2S_CON3, I2S_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("I2S5_EN", SUPPLY_SEQ_I2S_EN,
+			      AFE_I2S_CON4, I2S5_EN_SFT, 0,
+			      NULL, 0),
+	/* i2s hd en */
+	SND_SOC_DAPM_SUPPLY_S(I2S0_HD_EN_W_NAME, SUPPLY_SEQ_I2S_HD_EN,
+			      AFE_I2S_CON, I2S1_HD_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S(I2S1_HD_EN_W_NAME, SUPPLY_SEQ_I2S_HD_EN,
+			      AFE_I2S_CON1, I2S2_HD_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S(I2S2_HD_EN_W_NAME, SUPPLY_SEQ_I2S_HD_EN,
+			      AFE_I2S_CON2, I2S3_HD_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S(I2S3_HD_EN_W_NAME, SUPPLY_SEQ_I2S_HD_EN,
+			      AFE_I2S_CON3, I2S4_HD_EN_SFT, 0,
+			      NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S(I2S5_HD_EN_W_NAME, SUPPLY_SEQ_I2S_HD_EN,
+			      AFE_I2S_CON4, I2S5_HD_EN_SFT, 0,
+			      NULL, 0),
+
+	/* i2s mclk en */
+	SND_SOC_DAPM_SUPPLY_S(I2S0_MCLK_EN_W_NAME, SUPPLY_SEQ_I2S_MCLK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_mclk_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S(I2S1_MCLK_EN_W_NAME, SUPPLY_SEQ_I2S_MCLK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_mclk_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S(I2S2_MCLK_EN_W_NAME, SUPPLY_SEQ_I2S_MCLK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_mclk_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S(I2S3_MCLK_EN_W_NAME, SUPPLY_SEQ_I2S_MCLK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_mclk_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S(I2S5_MCLK_EN_W_NAME, SUPPLY_SEQ_I2S_MCLK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_mclk_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	/* apll */
+	SND_SOC_DAPM_SUPPLY_S(APLL1_W_NAME, SUPPLY_SEQ_APLL,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_apll_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S(APLL2_W_NAME, SUPPLY_SEQ_APLL,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_apll_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static int mtk_afe_i2s_share_connect(struct snd_soc_dapm_widget *source,
+				     struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+
+	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return 0;
+	}
+
+	if (i2s_priv->share_i2s_id < 0)
+		return 0;
+
+	return i2s_priv->share_i2s_id == get_i2s_id_by_name(afe, source->name);
+}
+
+static int mtk_afe_i2s_hd_connect(struct snd_soc_dapm_widget *source,
+				  struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+
+	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return 0;
+	}
+
+	if (get_i2s_id_by_name(afe, sink->name) ==
+	    get_i2s_id_by_name(afe, source->name))
+		return i2s_priv->low_jitter_en;
+
+	/* check if share i2s need hd en */
+	if (i2s_priv->share_i2s_id < 0)
+		return 0;
+
+	if (i2s_priv->share_i2s_id == get_i2s_id_by_name(afe, source->name))
+		return i2s_priv->low_jitter_en;
+
+	return 0;
+}
+
+static int mtk_afe_i2s_apll_connect(struct snd_soc_dapm_widget *source,
+				    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+	int cur_apll;
+	int i2s_need_apll;
+
+	i2s_priv = get_i2s_priv_by_name(afe, w->name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return 0;
+	}
+
+	/* which apll */
+	cur_apll = mt8183_get_apll_by_name(afe, source->name);
+
+	/* choose APLL from i2s rate */
+	i2s_need_apll = mt8183_get_apll_by_rate(afe, i2s_priv->rate);
+
+	return (i2s_need_apll == cur_apll) ? 1 : 0;
+}
+
+static int mtk_afe_i2s_mclk_connect(struct snd_soc_dapm_widget *source,
+				    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+
+	i2s_priv = get_i2s_priv_by_name(afe, sink->name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return 0;
+	}
+
+	if (get_i2s_id_by_name(afe, sink->name) ==
+	    get_i2s_id_by_name(afe, source->name))
+		return (i2s_priv->mclk_rate > 0) ? 1 : 0;
+
+	/* check if share i2s need mclk */
+	if (i2s_priv->share_i2s_id < 0)
+		return 0;
+
+	if (i2s_priv->share_i2s_id == get_i2s_id_by_name(afe, source->name))
+		return (i2s_priv->mclk_rate > 0) ? 1 : 0;
+
+	return 0;
+}
+
+static int mtk_afe_mclk_apll_connect(struct snd_soc_dapm_widget *source,
+				     struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mtk_afe_i2s_priv *i2s_priv;
+	int cur_apll;
+
+	i2s_priv = get_i2s_priv_by_name(afe, w->name);
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return 0;
+	}
+
+	/* which apll */
+	cur_apll = mt8183_get_apll_by_name(afe, source->name);
+
+	return (i2s_priv->mclk_apll == cur_apll) ? 1 : 0;
+}
+
+static const struct snd_soc_dapm_route mtk_dai_i2s_routes[] = {
+	/* i2s0 */
+	{"I2S0", NULL, "I2S0_EN"},
+	{"I2S0", NULL, "I2S1_EN", mtk_afe_i2s_share_connect},
+	{"I2S0", NULL, "I2S2_EN", mtk_afe_i2s_share_connect},
+	{"I2S0", NULL, "I2S3_EN", mtk_afe_i2s_share_connect},
+	{"I2S0", NULL, "I2S5_EN", mtk_afe_i2s_share_connect},
+
+	{"I2S0", NULL, I2S0_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S0", NULL, I2S1_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S0", NULL, I2S2_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S0", NULL, I2S3_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S0", NULL, I2S5_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{I2S0_HD_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_i2s_apll_connect},
+	{I2S0_HD_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_i2s_apll_connect},
+
+	{"I2S0", NULL, I2S0_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S0", NULL, I2S1_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S0", NULL, I2S2_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S0", NULL, I2S3_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S0", NULL, I2S5_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{I2S0_MCLK_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{I2S0_MCLK_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	/* i2s1 */
+	{"I2S1_CH1", "DL1_CH1", "DL1"},
+	{"I2S1_CH2", "DL1_CH2", "DL1"},
+
+	{"I2S1_CH1", "DL2_CH1", "DL2"},
+	{"I2S1_CH2", "DL2_CH2", "DL2"},
+
+	{"I2S1_CH1", "DL3_CH1", "DL3"},
+	{"I2S1_CH2", "DL3_CH2", "DL3"},
+
+	{"I2S1", NULL, "I2S1_CH1"},
+	{"I2S1", NULL, "I2S1_CH2"},
+
+	{"I2S1", NULL, "I2S0_EN", mtk_afe_i2s_share_connect},
+	{"I2S1", NULL, "I2S1_EN"},
+	{"I2S1", NULL, "I2S2_EN", mtk_afe_i2s_share_connect},
+	{"I2S1", NULL, "I2S3_EN", mtk_afe_i2s_share_connect},
+	{"I2S1", NULL, "I2S5_EN", mtk_afe_i2s_share_connect},
+
+	{"I2S1", NULL, I2S0_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S1", NULL, I2S1_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S1", NULL, I2S2_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S1", NULL, I2S3_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S1", NULL, I2S5_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{I2S1_HD_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_i2s_apll_connect},
+	{I2S1_HD_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_i2s_apll_connect},
+
+	{"I2S1", NULL, I2S0_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S1", NULL, I2S1_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S1", NULL, I2S2_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S1", NULL, I2S3_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S1", NULL, I2S5_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{I2S1_MCLK_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{I2S1_MCLK_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	/* i2s2 */
+	{"I2S2", NULL, "I2S0_EN", mtk_afe_i2s_share_connect},
+	{"I2S2", NULL, "I2S1_EN", mtk_afe_i2s_share_connect},
+	{"I2S2", NULL, "I2S2_EN"},
+	{"I2S2", NULL, "I2S3_EN", mtk_afe_i2s_share_connect},
+	{"I2S2", NULL, "I2S5_EN", mtk_afe_i2s_share_connect},
+
+	{"I2S2", NULL, I2S0_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S2", NULL, I2S1_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S2", NULL, I2S2_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S2", NULL, I2S3_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S2", NULL, I2S5_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{I2S2_HD_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_i2s_apll_connect},
+	{I2S2_HD_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_i2s_apll_connect},
+
+	{"I2S2", NULL, I2S0_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S2", NULL, I2S1_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S2", NULL, I2S2_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S2", NULL, I2S3_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S2", NULL, I2S5_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{I2S2_MCLK_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{I2S2_MCLK_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	/* i2s3 */
+	{"I2S3_CH1", "DL1_CH1", "DL1"},
+	{"I2S3_CH2", "DL1_CH2", "DL1"},
+
+	{"I2S3_CH1", "DL2_CH1", "DL2"},
+	{"I2S3_CH2", "DL2_CH2", "DL2"},
+
+	{"I2S3_CH1", "DL3_CH1", "DL3"},
+	{"I2S3_CH2", "DL3_CH2", "DL3"},
+
+	{"I2S3", NULL, "I2S3_CH1"},
+	{"I2S3", NULL, "I2S3_CH2"},
+
+	{"I2S3", NULL, "I2S0_EN", mtk_afe_i2s_share_connect},
+	{"I2S3", NULL, "I2S1_EN", mtk_afe_i2s_share_connect},
+	{"I2S3", NULL, "I2S2_EN", mtk_afe_i2s_share_connect},
+	{"I2S3", NULL, "I2S3_EN"},
+	{"I2S3", NULL, "I2S5_EN", mtk_afe_i2s_share_connect},
+
+	{"I2S3", NULL, I2S0_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S3", NULL, I2S1_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S3", NULL, I2S2_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S3", NULL, I2S3_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S3", NULL, I2S5_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{I2S3_HD_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_i2s_apll_connect},
+	{I2S3_HD_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_i2s_apll_connect},
+
+	{"I2S3", NULL, I2S0_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S3", NULL, I2S1_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S3", NULL, I2S2_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S3", NULL, I2S3_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S3", NULL, I2S5_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{I2S3_MCLK_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{I2S3_MCLK_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+
+	/* i2s5 */
+	{"I2S5_CH1", "DL1_CH1", "DL1"},
+	{"I2S5_CH2", "DL1_CH2", "DL1"},
+
+	{"I2S5_CH1", "DL2_CH1", "DL2"},
+	{"I2S5_CH2", "DL2_CH2", "DL2"},
+
+	{"I2S5_CH1", "DL3_CH1", "DL3"},
+	{"I2S5_CH2", "DL3_CH2", "DL3"},
+
+	{"I2S5", NULL, "I2S5_CH1"},
+	{"I2S5", NULL, "I2S5_CH2"},
+
+	{"I2S5", NULL, "I2S0_EN", mtk_afe_i2s_share_connect},
+	{"I2S5", NULL, "I2S1_EN", mtk_afe_i2s_share_connect},
+	{"I2S5", NULL, "I2S2_EN", mtk_afe_i2s_share_connect},
+	{"I2S5", NULL, "I2S3_EN", mtk_afe_i2s_share_connect},
+	{"I2S5", NULL, "I2S5_EN"},
+
+	{"I2S5", NULL, I2S0_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S5", NULL, I2S1_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S5", NULL, I2S2_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S5", NULL, I2S3_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{"I2S5", NULL, I2S5_HD_EN_W_NAME, mtk_afe_i2s_hd_connect},
+	{I2S5_HD_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_i2s_apll_connect},
+	{I2S5_HD_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_i2s_apll_connect},
+
+	{"I2S5", NULL, I2S0_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S5", NULL, I2S1_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S5", NULL, I2S2_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S5", NULL, I2S3_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{"I2S5", NULL, I2S5_MCLK_EN_W_NAME, mtk_afe_i2s_mclk_connect},
+	{I2S5_MCLK_EN_W_NAME, NULL, APLL1_W_NAME, mtk_afe_mclk_apll_connect},
+	{I2S5_MCLK_EN_W_NAME, NULL, APLL2_W_NAME, mtk_afe_mclk_apll_connect},
+};
+
+/* dai ops */
+static int mtk_dai_i2s_config(struct mtk_base_afe *afe,
+			      struct snd_pcm_hw_params *params,
+			      int i2s_id)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_i2s_priv *i2s_priv = afe_priv->dai_priv[i2s_id];
+
+	unsigned int rate = params_rate(params);
+	unsigned int rate_reg = mt8183_rate_transform(afe->dev,
+						      rate, i2s_id);
+	snd_pcm_format_t format = params_format(params);
+	unsigned int i2s_con = 0;
+	int ret = 0;
+
+	dev_info(afe->dev, "%s(), id %d, rate %d, format %d\n",
+		 __func__,
+		 i2s_id,
+		 rate, format);
+
+	if (i2s_priv)
+		i2s_priv->rate = rate;
+	else
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+
+	switch (i2s_id) {
+	case MT8183_DAI_I2S_0:
+		regmap_update_bits(afe->regmap, AFE_DAC_CON1,
+				   I2S_MODE_MASK_SFT, rate_reg << I2S_MODE_SFT);
+		i2s_con = I2S_IN_PAD_IO_MUX << I2SIN_PAD_SEL_SFT;
+		i2s_con |= I2S_FMT_I2S << I2S_FMT_SFT;
+		i2s_con |= get_i2s_wlen(format) << I2S_WLEN_SFT;
+		regmap_update_bits(afe->regmap, AFE_I2S_CON,
+				   0xffffeffe, i2s_con);
+		break;
+	case MT8183_DAI_I2S_1:
+		i2s_con = I2S1_SEL_O28_O29 << I2S2_SEL_O03_O04_SFT;
+		i2s_con |= rate_reg << I2S2_OUT_MODE_SFT;
+		i2s_con |= I2S_FMT_I2S << I2S2_FMT_SFT;
+		i2s_con |= get_i2s_wlen(format) << I2S2_WLEN_SFT;
+		regmap_update_bits(afe->regmap, AFE_I2S_CON1,
+				   0xffffeffe, i2s_con);
+		break;
+	case MT8183_DAI_I2S_2:
+		i2s_con = 8 << I2S3_UPDATE_WORD_SFT;
+		i2s_con |= rate_reg << I2S3_OUT_MODE_SFT;
+		i2s_con |= I2S_FMT_I2S << I2S3_FMT_SFT;
+		i2s_con |= get_i2s_wlen(format) << I2S3_WLEN_SFT;
+		regmap_update_bits(afe->regmap, AFE_I2S_CON2,
+				   0xffffeffe, i2s_con);
+		break;
+	case MT8183_DAI_I2S_3:
+		i2s_con = rate_reg << I2S4_OUT_MODE_SFT;
+		i2s_con |= I2S_FMT_I2S << I2S4_FMT_SFT;
+		i2s_con |= get_i2s_wlen(format) << I2S4_WLEN_SFT;
+		regmap_update_bits(afe->regmap, AFE_I2S_CON3,
+				   0xffffeffe, i2s_con);
+		break;
+	case MT8183_DAI_I2S_5:
+		i2s_con = rate_reg << I2S5_OUT_MODE_SFT;
+		i2s_con |= I2S_FMT_I2S << I2S5_FMT_SFT;
+		i2s_con |= get_i2s_wlen(format) << I2S5_WLEN_SFT;
+		regmap_update_bits(afe->regmap, AFE_I2S_CON4,
+				   0xffffeffe, i2s_con);
+		break;
+	default:
+		dev_warn(afe->dev, "%s(), id %d not support\n",
+			 __func__, i2s_id);
+		return -EINVAL;
+	}
+
+	/* set share i2s */
+	if (i2s_priv && i2s_priv->share_i2s_id >= 0)
+		ret = mtk_dai_i2s_config(afe, params, i2s_priv->share_i2s_id);
+
+	return ret;
+}
+
+static int mtk_dai_i2s_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	return mtk_dai_i2s_config(afe, params, dai->id);
+}
+
+static int mtk_dai_i2s_set_sysclk(struct snd_soc_dai *dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_i2s_priv *i2s_priv = afe_priv->dai_priv[dai->id];
+	int apll;
+	int apll_rate;
+
+	if (!i2s_priv) {
+		dev_warn(afe->dev, "%s(), i2s_priv == NULL", __func__);
+		return -EINVAL;
+	}
+
+	if (dir != SND_SOC_CLOCK_OUT) {
+		dev_warn(afe->dev, "%s(), dir != SND_SOC_CLOCK_OUT", __func__);
+		return -EINVAL;
+	}
+
+	dev_info(afe->dev, "%s(), freq %d\n", __func__, freq);
+
+	apll = mt8183_get_apll_by_rate(afe, freq);
+	apll_rate = mt8183_get_apll_rate(afe, apll);
+
+	if (freq > apll_rate) {
+		dev_warn(afe->dev, "%s(), freq > apll rate", __func__);
+		return -EINVAL;
+	}
+
+	if (apll_rate % freq != 0) {
+		dev_warn(afe->dev, "%s(), APLL cannot generate freq Hz",
+			 __func__);
+		return -EINVAL;
+	}
+
+	i2s_priv->mclk_rate = freq;
+	i2s_priv->mclk_apll = apll;
+
+	if (i2s_priv->share_i2s_id > 0) {
+		struct mtk_afe_i2s_priv *share_i2s_priv;
+
+		share_i2s_priv = afe_priv->dai_priv[i2s_priv->share_i2s_id];
+		if (!share_i2s_priv) {
+			dev_warn(afe->dev, "%s(), share_i2s_priv == NULL",
+				 __func__);
+			return -EINVAL;
+		}
+
+		share_i2s_priv->mclk_rate = i2s_priv->mclk_rate;
+		share_i2s_priv->mclk_apll = i2s_priv->mclk_apll;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_i2s_ops = {
+	.hw_params = mtk_dai_i2s_hw_params,
+	.set_sysclk = mtk_dai_i2s_set_sysclk,
+};
+
+/* dai driver */
+#define MTK_I2S_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		       SNDRV_PCM_RATE_88200 |\
+		       SNDRV_PCM_RATE_96000 |\
+		       SNDRV_PCM_RATE_176400 |\
+		       SNDRV_PCM_RATE_192000)
+
+#define MTK_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_i2s_driver[] = {
+	{
+		.name = "I2S0",
+		.id = MT8183_DAI_I2S_0,
+		.capture = {
+			.stream_name = "I2S0",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_I2S_RATES,
+			.formats = MTK_I2S_FORMATS,
+		},
+		.ops = &mtk_dai_i2s_ops,
+	},
+	{
+		.name = "I2S1",
+		.id = MT8183_DAI_I2S_1,
+		.playback = {
+			.stream_name = "I2S1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_I2S_RATES,
+			.formats = MTK_I2S_FORMATS,
+		},
+		.ops = &mtk_dai_i2s_ops,
+	},
+	{
+		.name = "I2S2",
+		.id = MT8183_DAI_I2S_2,
+		.capture = {
+			.stream_name = "I2S2",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_I2S_RATES,
+			.formats = MTK_I2S_FORMATS,
+		},
+		.ops = &mtk_dai_i2s_ops,
+	},
+	{
+		.name = "I2S3",
+		.id = MT8183_DAI_I2S_3,
+		.playback = {
+			.stream_name = "I2S3",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_I2S_RATES,
+			.formats = MTK_I2S_FORMATS,
+		},
+		.ops = &mtk_dai_i2s_ops,
+	},
+	{
+		.name = "I2S5",
+		.id = MT8183_DAI_I2S_5,
+		.playback = {
+			.stream_name = "I2S5",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_I2S_RATES,
+			.formats = MTK_I2S_FORMATS,
+		},
+		.ops = &mtk_dai_i2s_ops,
+	},
+};
+
+/* this enum is merely for mtk_afe_i2s_priv declare */
+enum {
+	DAI_I2S0 = 0,
+	DAI_I2S1,
+	DAI_I2S2,
+	DAI_I2S3,
+	DAI_I2S5,
+	DAI_I2S_NUM,
+};
+
+static const struct mtk_afe_i2s_priv mt8183_i2s_priv[DAI_I2S_NUM] = {
+	[DAI_I2S0] = {
+		.id = MT8183_DAI_I2S_0,
+		.mclk_id = MT8183_I2S0_MCK,
+		.share_property_name = "i2s0-share",
+		.share_i2s_id = -1,
+	},
+	[DAI_I2S1] = {
+		.id = MT8183_DAI_I2S_1,
+		.mclk_id = MT8183_I2S1_MCK,
+		.share_property_name = "i2s1-share",
+		.share_i2s_id = -1,
+	},
+	[DAI_I2S2] = {
+		.id = MT8183_DAI_I2S_2,
+		.mclk_id = MT8183_I2S2_MCK,
+		.share_property_name = "i2s2-share",
+		.share_i2s_id = -1,
+	},
+	[DAI_I2S3] = {
+		.id = MT8183_DAI_I2S_3,
+		.mclk_id = MT8183_I2S3_MCK,
+		.share_property_name = "i2s3-share",
+		.share_i2s_id = -1,
+	},
+	[DAI_I2S5] = {
+		.id = MT8183_DAI_I2S_5,
+		.mclk_id = MT8183_I2S5_MCK,
+		.share_property_name = "i2s5-share",
+		.share_i2s_id = -1,
+	},
+};
+
+int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	const struct device_node *of_node = afe->dev->of_node;
+	const char *of_str;
+	const char *property_name;
+	struct mtk_afe_i2s_priv *i2s_priv;
+	int i;
+
+	for (i = 0; i < DAI_I2S_NUM; i++) {
+		i2s_priv = afe_priv->dai_priv[mt8183_i2s_priv[i].id];
+		property_name = mt8183_i2s_priv[i].share_property_name;
+		if (of_property_read_string(of_node, property_name, &of_str))
+			continue;
+		i2s_priv->share_i2s_id = get_i2s_id_by_name(afe, of_str);
+	}
+
+	return 0;
+}
+
+int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_i2s_priv *i2s_priv;
+	int i;
+
+	for (i = 0; i < DAI_I2S_NUM; i++) {
+		i2s_priv = devm_kzalloc(afe->dev,
+					sizeof(struct mtk_afe_i2s_priv),
+					GFP_KERNEL);
+		if (!i2s_priv)
+			return -ENOMEM;
+
+		memcpy(i2s_priv, &mt8183_i2s_priv[i],
+		       sizeof(struct mtk_afe_i2s_priv));
+
+		afe_priv->dai_priv[mt8183_i2s_priv[i].id] = i2s_priv;
+	}
+
+	return 0;
+}
+
+int mt8183_dai_i2s_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+	int ret;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_i2s_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_i2s_driver);
+
+	dai->controls = mtk_dai_i2s_controls;
+	dai->num_controls = ARRAY_SIZE(mtk_dai_i2s_controls);
+	dai->dapm_widgets = mtk_dai_i2s_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_i2s_widgets);
+	dai->dapm_routes = mtk_dai_i2s_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_i2s_routes);
+
+	/* set all dai i2s private data */
+	ret = mt8183_dai_i2s_set_priv(afe);
+	if (ret)
+		return ret;
+
+	/* parse share i2s */
+	ret = mt8183_dai_i2s_get_share(afe);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-pcm.c b/sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
new file mode 100644
index 0000000..bc3ba32
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI I2S Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8183-afe-common.h"
+#include "mt8183-interconnection.h"
+#include "mt8183-reg.h"
+
+enum AUD_TX_LCH_RPT {
+	AUD_TX_LCH_RPT_NO_REPEAT = 0,
+	AUD_TX_LCH_RPT_REPEAT = 1
+};
+
+enum AUD_VBT_16K_MODE {
+	AUD_VBT_16K_MODE_DISABLE = 0,
+	AUD_VBT_16K_MODE_ENABLE = 1
+};
+
+enum AUD_EXT_MODEM {
+	AUD_EXT_MODEM_SELECT_INTERNAL = 0,
+	AUD_EXT_MODEM_SELECT_EXTERNAL = 1
+};
+
+enum AUD_PCM_SYNC_TYPE {
+	/* bck sync length = 1 */
+	AUD_PCM_ONE_BCK_CYCLE_SYNC = 0,
+	/* bck sync length = PCM_INTF_CON1[9:13] */
+	AUD_PCM_EXTENDED_BCK_CYCLE_SYNC = 1
+};
+
+enum AUD_BT_MODE {
+	AUD_BT_MODE_DUAL_MIC_ON_TX = 0,
+	AUD_BT_MODE_SINGLE_MIC_ON_TX = 1
+};
+
+enum AUD_PCM_AFIFO_SRC {
+	/* slave mode & external modem uses different crystal */
+	AUD_PCM_AFIFO_ASRC = 0,
+	/* slave mode & external modem uses the same crystal */
+	AUD_PCM_AFIFO_AFIFO = 1
+};
+
+enum AUD_PCM_CLOCK_SOURCE {
+	AUD_PCM_CLOCK_MASTER_MODE = 0,
+	AUD_PCM_CLOCK_SLAVE_MODE = 1
+};
+
+enum AUD_PCM_WLEN {
+	AUD_PCM_WLEN_PCM_32_BCK_CYCLES = 0,
+	AUD_PCM_WLEN_PCM_64_BCK_CYCLES = 1
+};
+
+enum AUD_PCM_MODE {
+	AUD_PCM_MODE_PCM_MODE_8K = 0,
+	AUD_PCM_MODE_PCM_MODE_16K = 1,
+	AUD_PCM_MODE_PCM_MODE_32K = 2,
+	AUD_PCM_MODE_PCM_MODE_48K = 3,
+};
+
+enum AUD_PCM_FMT {
+	AUD_PCM_FMT_I2S = 0,
+	AUD_PCM_FMT_EIAJ = 1,
+	AUD_PCM_FMT_PCM_MODE_A = 2,
+	AUD_PCM_FMT_PCM_MODE_B = 3
+};
+
+enum AUD_BCLK_OUT_INV {
+	AUD_BCLK_OUT_INV_NO_INVERSE = 0,
+	AUD_BCLK_OUT_INV_INVERSE = 1
+};
+
+enum AUD_PCM_EN {
+	AUD_PCM_EN_DISABLE = 0,
+	AUD_PCM_EN_ENABLE = 1
+};
+
+/* dai component */
+static const struct snd_kcontrol_new mtk_pcm_1_playback_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN7,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN7,
+				    I_DL2_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_1_playback_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN8,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN8,
+				    I_DL2_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_1_playback_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN27,
+				    I_DL1_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_2_playback_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN17,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1", AFE_CONN17,
+				    I_DL2_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_2_playback_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN18,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2", AFE_CONN18,
+				    I_DL2_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new mtk_pcm_2_playback_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1", AFE_CONN24,
+				    I_DL1_CH1, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_pcm_widgets[] = {
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("PCM_1_PB_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_1_playback_ch1_mix,
+			   ARRAY_SIZE(mtk_pcm_1_playback_ch1_mix)),
+	SND_SOC_DAPM_MIXER("PCM_1_PB_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_1_playback_ch2_mix,
+			   ARRAY_SIZE(mtk_pcm_1_playback_ch2_mix)),
+	SND_SOC_DAPM_MIXER("PCM_1_PB_CH4", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_1_playback_ch4_mix,
+			   ARRAY_SIZE(mtk_pcm_1_playback_ch4_mix)),
+	SND_SOC_DAPM_MIXER("PCM_2_PB_CH1", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_2_playback_ch1_mix,
+			   ARRAY_SIZE(mtk_pcm_2_playback_ch1_mix)),
+	SND_SOC_DAPM_MIXER("PCM_2_PB_CH2", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_2_playback_ch2_mix,
+			   ARRAY_SIZE(mtk_pcm_2_playback_ch2_mix)),
+	SND_SOC_DAPM_MIXER("PCM_2_PB_CH4", SND_SOC_NOPM, 0, 0,
+			   mtk_pcm_2_playback_ch4_mix,
+			   ARRAY_SIZE(mtk_pcm_2_playback_ch4_mix)),
+
+	SND_SOC_DAPM_SUPPLY("PCM_1_EN", PCM_INTF_CON1, PCM_EN_SFT, 0,
+			    NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("PCM_2_EN", PCM2_INTF_CON, PCM2_EN_SFT, 0,
+			    NULL, 0),
+
+	SND_SOC_DAPM_INPUT("MD1_TO_AFE"),
+	SND_SOC_DAPM_INPUT("MD2_TO_AFE"),
+	SND_SOC_DAPM_OUTPUT("AFE_TO_MD1"),
+	SND_SOC_DAPM_OUTPUT("AFE_TO_MD2"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_pcm_routes[] = {
+	{"PCM 1 Playback", NULL, "PCM_1_PB_CH1"},
+	{"PCM 1 Playback", NULL, "PCM_1_PB_CH2"},
+	{"PCM 1 Playback", NULL, "PCM_1_PB_CH4"},
+	{"PCM 2 Playback", NULL, "PCM_2_PB_CH1"},
+	{"PCM 2 Playback", NULL, "PCM_2_PB_CH2"},
+	{"PCM 2 Playback", NULL, "PCM_2_PB_CH4"},
+
+	{"PCM 1 Playback", NULL, "PCM_1_EN"},
+	{"PCM 2 Playback", NULL, "PCM_2_EN"},
+	{"PCM 1 Capture", NULL, "PCM_1_EN"},
+	{"PCM 2 Capture", NULL, "PCM_2_EN"},
+
+	{"AFE_TO_MD1", NULL, "PCM 2 Playback"},
+	{"AFE_TO_MD2", NULL, "PCM 1 Playback"},
+	{"PCM 2 Capture", NULL, "MD1_TO_AFE"},
+	{"PCM 1 Capture", NULL, "MD2_TO_AFE"},
+
+	{"PCM_1_PB_CH1", "DL2_CH1", "DL2"},
+	{"PCM_1_PB_CH2", "DL2_CH2", "DL2"},
+	{"PCM_1_PB_CH4", "DL1_CH1", "DL1"},
+	{"PCM_2_PB_CH1", "DL2_CH1", "DL2"},
+	{"PCM_2_PB_CH2", "DL2_CH2", "DL2"},
+	{"PCM_2_PB_CH4", "DL1_CH1", "DL1"},
+};
+
+/* dai ops */
+static int mtk_dai_pcm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	unsigned int rate_reg = mt8183_rate_transform(afe->dev, rate, dai->id);
+	unsigned int pcm_con = 0;
+
+	dev_dbg(afe->dev, "%s(), id %d, stream %d, rate %d, rate_reg %d, widget active p %d, c %d\n",
+		__func__,
+		dai->id,
+		substream->stream,
+		rate,
+		rate_reg,
+		dai->playback_widget->active,
+		dai->capture_widget->active);
+
+	if (dai->playback_widget->active || dai->capture_widget->active)
+		return 0;
+
+	switch (dai->id) {
+	case MT8183_DAI_PCM_1:
+		pcm_con |= AUD_BCLK_OUT_INV_NO_INVERSE << PCM_BCLK_OUT_INV_SFT;
+		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM_TX_LCH_RPT_SFT;
+		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM_VBT_16K_MODE_SFT;
+		pcm_con |= AUD_EXT_MODEM_SELECT_INTERNAL << PCM_EXT_MODEM_SFT;
+		pcm_con |= 0 << PCM_SYNC_LENGTH_SFT;
+		pcm_con |= AUD_PCM_ONE_BCK_CYCLE_SYNC << PCM_SYNC_TYPE_SFT;
+		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM_BT_MODE_SFT;
+		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM_BYP_ASRC_SFT;
+		pcm_con |= AUD_PCM_CLOCK_SLAVE_MODE << PCM_SLAVE_SFT;
+		pcm_con |= rate_reg << PCM_MODE_SFT;
+		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM_FMT_SFT;
+
+		regmap_update_bits(afe->regmap, PCM_INTF_CON1,
+				   0xfffffffe, pcm_con);
+		break;
+	case MT8183_DAI_PCM_2:
+		pcm_con |= AUD_TX_LCH_RPT_NO_REPEAT << PCM2_TX_LCH_RPT_SFT;
+		pcm_con |= AUD_VBT_16K_MODE_DISABLE << PCM2_VBT_16K_MODE_SFT;
+		pcm_con |= AUD_BT_MODE_DUAL_MIC_ON_TX << PCM2_BT_MODE_SFT;
+		pcm_con |= AUD_PCM_AFIFO_AFIFO << PCM2_AFIFO_SFT;
+		pcm_con |= AUD_PCM_WLEN_PCM_32_BCK_CYCLES << PCM2_WLEN_SFT;
+		pcm_con |= rate_reg << PCM2_MODE_SFT;
+		pcm_con |= AUD_PCM_FMT_PCM_MODE_B << PCM2_FMT_SFT;
+
+		regmap_update_bits(afe->regmap, PCM2_INTF_CON,
+				   0xfffffffe, pcm_con);
+		break;
+	default:
+		dev_warn(afe->dev, "%s(), id %d not support\n",
+			 __func__, dai->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_pcm_ops = {
+	.hw_params = mtk_dai_pcm_hw_params,
+};
+
+/* dai driver */
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000 |\
+		       SNDRV_PCM_RATE_16000 |\
+		       SNDRV_PCM_RATE_32000 |\
+		       SNDRV_PCM_RATE_48000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_pcm_driver[] = {
+	{
+		.name = "PCM 1",
+		.id = MT8183_DAI_PCM_1,
+		.playback = {
+			.stream_name = "PCM 1 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "PCM 1 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_dai_pcm_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+	{
+		.name = "PCM 2",
+		.id = MT8183_DAI_PCM_2,
+		.playback = {
+			.stream_name = "PCM 2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.capture = {
+			.stream_name = "PCM 2 Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_dai_pcm_ops,
+		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
+	},
+};
+
+int mt8183_dai_pcm_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_pcm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_pcm_driver);
+
+	dai->dapm_widgets = mtk_dai_pcm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_pcm_widgets);
+	dai->dapm_routes = mtk_dai_pcm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_pcm_routes);
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c b/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
new file mode 100644
index 0000000..8983d54a
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio DAI TDM Control
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8183-afe-clk.h"
+#include "mt8183-afe-common.h"
+#include "mt8183-interconnection.h"
+#include "mt8183-reg.h"
+
+struct mtk_afe_tdm_priv {
+	int bck_id;
+	int bck_rate;
+
+	int mclk_id;
+	int mclk_multiple; /* according to sample rate */
+	int mclk_rate;
+	int mclk_apll;
+};
+
+enum {
+	TDM_WLEN_16_BIT = 1,
+	TDM_WLEN_32_BIT = 2,
+};
+
+enum {
+	TDM_CHANNEL_BCK_16 = 0,
+	TDM_CHANNEL_BCK_24 = 1,
+	TDM_CHANNEL_BCK_32 = 2,
+};
+
+enum {
+	TDM_CHANNEL_NUM_2 = 0,
+	TDM_CHANNEL_NUM_4 = 1,
+	TDM_CHANNEL_NUM_8 = 2,
+};
+
+enum  {
+	TDM_CH_START_O30_O31 = 0,
+	TDM_CH_START_O32_O33,
+	TDM_CH_START_O34_O35,
+	TDM_CH_START_O36_O37,
+	TDM_CH_ZERO,
+};
+
+enum {
+	HDMI_BIT_WIDTH_16_BIT = 0,
+	HDMI_BIT_WIDTH_32_BIT = 1,
+};
+
+static unsigned int get_hdmi_wlen(snd_pcm_format_t format)
+{
+	return snd_pcm_format_physical_width(format) <= 16 ?
+	       HDMI_BIT_WIDTH_16_BIT : HDMI_BIT_WIDTH_32_BIT;
+}
+
+static unsigned int get_tdm_wlen(snd_pcm_format_t format)
+{
+	return snd_pcm_format_physical_width(format) <= 16 ?
+	       TDM_WLEN_16_BIT : TDM_WLEN_32_BIT;
+}
+
+static unsigned int get_tdm_channel_bck(snd_pcm_format_t format)
+{
+	return snd_pcm_format_physical_width(format) <= 16 ?
+	       TDM_CHANNEL_BCK_16 : TDM_CHANNEL_BCK_32;
+}
+
+static unsigned int get_tdm_lrck_width(snd_pcm_format_t format)
+{
+	return snd_pcm_format_physical_width(format) - 1;
+}
+
+static unsigned int get_tdm_ch(unsigned int ch)
+{
+	switch (ch) {
+	case 1:
+	case 2:
+		return TDM_CHANNEL_NUM_2;
+	case 3:
+	case 4:
+		return TDM_CHANNEL_NUM_4;
+	case 5:
+	case 6:
+	case 7:
+	case 8:
+	default:
+		return TDM_CHANNEL_NUM_8;
+	}
+}
+
+/* interconnection */
+enum {
+	HDMI_CONN_CH0 = 0,
+	HDMI_CONN_CH1,
+	HDMI_CONN_CH2,
+	HDMI_CONN_CH3,
+	HDMI_CONN_CH4,
+	HDMI_CONN_CH5,
+	HDMI_CONN_CH6,
+	HDMI_CONN_CH7,
+};
+
+static const char *const hdmi_conn_mux_map[] = {
+	"CH0", "CH1", "CH2", "CH3",
+	"CH4", "CH5", "CH6", "CH7",
+};
+
+static int hdmi_conn_mux_map_value[] = {
+	HDMI_CONN_CH0,
+	HDMI_CONN_CH1,
+	HDMI_CONN_CH2,
+	HDMI_CONN_CH3,
+	HDMI_CONN_CH4,
+	HDMI_CONN_CH5,
+	HDMI_CONN_CH6,
+	HDMI_CONN_CH7,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch0_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_0_SFT,
+				  HDMI_O_0_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch0_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH0_MUX", hdmi_ch0_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch1_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_1_SFT,
+				  HDMI_O_1_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch1_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH1_MUX", hdmi_ch1_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch2_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_2_SFT,
+				  HDMI_O_2_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch2_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH2_MUX", hdmi_ch2_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch3_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_3_SFT,
+				  HDMI_O_3_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch3_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH3_MUX", hdmi_ch3_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch4_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_4_SFT,
+				  HDMI_O_4_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch4_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH4_MUX", hdmi_ch4_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch5_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_5_SFT,
+				  HDMI_O_5_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch5_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH5_MUX", hdmi_ch5_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch6_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_6_SFT,
+				  HDMI_O_6_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch6_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH6_MUX", hdmi_ch6_mux_map_enum);
+
+static SOC_VALUE_ENUM_SINGLE_DECL(hdmi_ch7_mux_map_enum,
+				  AFE_HDMI_CONN0,
+				  HDMI_O_7_SFT,
+				  HDMI_O_7_MASK,
+				  hdmi_conn_mux_map,
+				  hdmi_conn_mux_map_value);
+
+static const struct snd_kcontrol_new hdmi_ch7_mux_control =
+	SOC_DAPM_ENUM("HDMI_CH7_MUX", hdmi_ch7_mux_map_enum);
+
+enum {
+	SUPPLY_SEQ_APLL,
+	SUPPLY_SEQ_TDM_MCK_EN,
+	SUPPLY_SEQ_TDM_BCK_EN,
+};
+
+static int mtk_tdm_bck_en_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol,
+				int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[MT8183_DAI_TDM];
+
+	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		 __func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		mt8183_mck_enable(afe, tdm_priv->bck_id, tdm_priv->bck_rate);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		mt8183_mck_disable(afe, tdm_priv->bck_id);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_tdm_mck_en_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol,
+				int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[MT8183_DAI_TDM];
+
+	dev_info(cmpnt->dev, "%s(), name %s, event 0x%x\n",
+		 __func__, w->name, event);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		mt8183_mck_enable(afe, tdm_priv->mclk_id, tdm_priv->mclk_rate);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		tdm_priv->mclk_rate = 0;
+		mt8183_mck_disable(afe, tdm_priv->mclk_id);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget mtk_dai_tdm_widgets[] = {
+	SND_SOC_DAPM_MUX("HDMI_CH0_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch0_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH1_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch1_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH2_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch2_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH3_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch3_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH4_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch4_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH5_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch5_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH6_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch6_mux_control),
+	SND_SOC_DAPM_MUX("HDMI_CH7_MUX", SND_SOC_NOPM, 0, 0,
+			 &hdmi_ch7_mux_control),
+
+	SND_SOC_DAPM_CLOCK_SUPPLY("aud_tdm_clk"),
+
+	SND_SOC_DAPM_SUPPLY_S("TDM_BCK", SUPPLY_SEQ_TDM_BCK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_tdm_bck_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SUPPLY_S("TDM_MCK", SUPPLY_SEQ_TDM_MCK_EN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_tdm_mck_en_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static int mtk_afe_tdm_apll_connect(struct snd_soc_dapm_widget *source,
+				    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_dapm_widget *w = sink;
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[MT8183_DAI_TDM];
+	int cur_apll;
+
+	/* which apll */
+	cur_apll = mt8183_get_apll_by_name(afe, source->name);
+
+	return (tdm_priv->mclk_apll == cur_apll) ? 1 : 0;
+}
+
+static const struct snd_soc_dapm_route mtk_dai_tdm_routes[] = {
+	{"HDMI_CH0_MUX", "CH0", "HDMI"},
+	{"HDMI_CH0_MUX", "CH1", "HDMI"},
+	{"HDMI_CH0_MUX", "CH2", "HDMI"},
+	{"HDMI_CH0_MUX", "CH3", "HDMI"},
+	{"HDMI_CH0_MUX", "CH4", "HDMI"},
+	{"HDMI_CH0_MUX", "CH5", "HDMI"},
+	{"HDMI_CH0_MUX", "CH6", "HDMI"},
+	{"HDMI_CH0_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH1_MUX", "CH0", "HDMI"},
+	{"HDMI_CH1_MUX", "CH1", "HDMI"},
+	{"HDMI_CH1_MUX", "CH2", "HDMI"},
+	{"HDMI_CH1_MUX", "CH3", "HDMI"},
+	{"HDMI_CH1_MUX", "CH4", "HDMI"},
+	{"HDMI_CH1_MUX", "CH5", "HDMI"},
+	{"HDMI_CH1_MUX", "CH6", "HDMI"},
+	{"HDMI_CH1_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH2_MUX", "CH0", "HDMI"},
+	{"HDMI_CH2_MUX", "CH1", "HDMI"},
+	{"HDMI_CH2_MUX", "CH2", "HDMI"},
+	{"HDMI_CH2_MUX", "CH3", "HDMI"},
+	{"HDMI_CH2_MUX", "CH4", "HDMI"},
+	{"HDMI_CH2_MUX", "CH5", "HDMI"},
+	{"HDMI_CH2_MUX", "CH6", "HDMI"},
+	{"HDMI_CH2_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH3_MUX", "CH0", "HDMI"},
+	{"HDMI_CH3_MUX", "CH1", "HDMI"},
+	{"HDMI_CH3_MUX", "CH2", "HDMI"},
+	{"HDMI_CH3_MUX", "CH3", "HDMI"},
+	{"HDMI_CH3_MUX", "CH4", "HDMI"},
+	{"HDMI_CH3_MUX", "CH5", "HDMI"},
+	{"HDMI_CH3_MUX", "CH6", "HDMI"},
+	{"HDMI_CH3_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH4_MUX", "CH0", "HDMI"},
+	{"HDMI_CH4_MUX", "CH1", "HDMI"},
+	{"HDMI_CH4_MUX", "CH2", "HDMI"},
+	{"HDMI_CH4_MUX", "CH3", "HDMI"},
+	{"HDMI_CH4_MUX", "CH4", "HDMI"},
+	{"HDMI_CH4_MUX", "CH5", "HDMI"},
+	{"HDMI_CH4_MUX", "CH6", "HDMI"},
+	{"HDMI_CH4_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH5_MUX", "CH0", "HDMI"},
+	{"HDMI_CH5_MUX", "CH1", "HDMI"},
+	{"HDMI_CH5_MUX", "CH2", "HDMI"},
+	{"HDMI_CH5_MUX", "CH3", "HDMI"},
+	{"HDMI_CH5_MUX", "CH4", "HDMI"},
+	{"HDMI_CH5_MUX", "CH5", "HDMI"},
+	{"HDMI_CH5_MUX", "CH6", "HDMI"},
+	{"HDMI_CH5_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH6_MUX", "CH0", "HDMI"},
+	{"HDMI_CH6_MUX", "CH1", "HDMI"},
+	{"HDMI_CH6_MUX", "CH2", "HDMI"},
+	{"HDMI_CH6_MUX", "CH3", "HDMI"},
+	{"HDMI_CH6_MUX", "CH4", "HDMI"},
+	{"HDMI_CH6_MUX", "CH5", "HDMI"},
+	{"HDMI_CH6_MUX", "CH6", "HDMI"},
+	{"HDMI_CH6_MUX", "CH7", "HDMI"},
+
+	{"HDMI_CH7_MUX", "CH0", "HDMI"},
+	{"HDMI_CH7_MUX", "CH1", "HDMI"},
+	{"HDMI_CH7_MUX", "CH2", "HDMI"},
+	{"HDMI_CH7_MUX", "CH3", "HDMI"},
+	{"HDMI_CH7_MUX", "CH4", "HDMI"},
+	{"HDMI_CH7_MUX", "CH5", "HDMI"},
+	{"HDMI_CH7_MUX", "CH6", "HDMI"},
+	{"HDMI_CH7_MUX", "CH7", "HDMI"},
+
+	{"TDM", NULL, "HDMI_CH0_MUX"},
+	{"TDM", NULL, "HDMI_CH1_MUX"},
+	{"TDM", NULL, "HDMI_CH2_MUX"},
+	{"TDM", NULL, "HDMI_CH3_MUX"},
+	{"TDM", NULL, "HDMI_CH4_MUX"},
+	{"TDM", NULL, "HDMI_CH5_MUX"},
+	{"TDM", NULL, "HDMI_CH6_MUX"},
+	{"TDM", NULL, "HDMI_CH7_MUX"},
+
+	{"TDM", NULL, "aud_tdm_clk"},
+	{"TDM", NULL, "TDM_BCK"},
+	{"TDM_BCK", NULL, "TDM_MCK"},
+	{"TDM_MCK", NULL, APLL1_W_NAME, mtk_afe_tdm_apll_connect},
+	{"TDM_MCK", NULL, APLL2_W_NAME, mtk_afe_tdm_apll_connect},
+};
+
+/* dai ops */
+static int mtk_dai_tdm_cal_mclk(struct mtk_base_afe *afe,
+				struct mtk_afe_tdm_priv *tdm_priv,
+				int freq)
+{
+	int apll;
+	int apll_rate;
+
+	apll = mt8183_get_apll_by_rate(afe, freq);
+	apll_rate = mt8183_get_apll_rate(afe, apll);
+
+	if (!freq || freq > apll_rate) {
+		dev_warn(afe->dev,
+			 "%s(), freq(%d Hz) invalid\n", __func__, freq);
+		return -EINVAL;
+	}
+
+	if (apll_rate % freq != 0) {
+		dev_warn(afe->dev,
+			 "%s(), APLL cannot generate %d Hz", __func__, freq);
+		return -EINVAL;
+	}
+
+	tdm_priv->mclk_rate = freq;
+	tdm_priv->mclk_apll = apll;
+
+	return 0;
+}
+
+static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	int tdm_id = dai->id;
+	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[tdm_id];
+	unsigned int rate = params_rate(params);
+	unsigned int channels = params_channels(params);
+	snd_pcm_format_t format = params_format(params);
+	unsigned int tdm_con = 0;
+
+	/* calculate mclk_rate, if not set explicitly */
+	if (!tdm_priv->mclk_rate) {
+		tdm_priv->mclk_rate = rate * tdm_priv->mclk_multiple;
+		mtk_dai_tdm_cal_mclk(afe,
+				     tdm_priv,
+				     tdm_priv->mclk_rate);
+	}
+
+	/* calculate bck */
+	tdm_priv->bck_rate = rate *
+			     channels *
+			     snd_pcm_format_physical_width(format);
+
+	if (tdm_priv->bck_rate > tdm_priv->mclk_rate)
+		dev_warn(afe->dev, "%s(), bck_rate > mclk_rate rate", __func__);
+
+	if (tdm_priv->mclk_rate % tdm_priv->bck_rate != 0)
+		dev_warn(afe->dev, "%s(), bck cannot generate", __func__);
+
+	dev_info(afe->dev, "%s(), id %d, rate %d, channels %d, format %d, mclk_rate %d, bck_rate %d\n",
+		 __func__,
+		 tdm_id, rate, channels, format,
+		 tdm_priv->mclk_rate, tdm_priv->bck_rate);
+
+	/* set tdm */
+	tdm_con = 1 << BCK_INVERSE_SFT;
+	tdm_con |= 1 << LRCK_INVERSE_SFT;
+	tdm_con |= 1 << DELAY_DATA_SFT;
+	tdm_con |= 1 << LEFT_ALIGN_SFT;
+	tdm_con |= get_tdm_wlen(format) << WLEN_SFT;
+	tdm_con |= get_tdm_ch(channels) << CHANNEL_NUM_SFT;
+	tdm_con |= get_tdm_channel_bck(format) << CHANNEL_BCK_CYCLES_SFT;
+	tdm_con |= get_tdm_lrck_width(format) << LRCK_TDM_WIDTH_SFT;
+	regmap_write(afe->regmap, AFE_TDM_CON1, tdm_con);
+
+	switch (channels) {
+	case 1:
+	case 2:
+		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT1_SFT;
+		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT2_SFT;
+		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
+		break;
+	case 3:
+	case 4:
+		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+		tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
+		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT2_SFT;
+		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
+		break;
+	case 5:
+	case 6:
+		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+		tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
+		tdm_con |= TDM_CH_START_O34_O35 << ST_CH_PAIR_SOUT2_SFT;
+		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
+		break;
+	case 7:
+	case 8:
+		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+		tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
+		tdm_con |= TDM_CH_START_O34_O35 << ST_CH_PAIR_SOUT2_SFT;
+		tdm_con |= TDM_CH_START_O36_O37 << ST_CH_PAIR_SOUT3_SFT;
+		break;
+	default:
+		tdm_con = 0;
+	}
+	regmap_write(afe->regmap, AFE_TDM_CON2, tdm_con);
+
+	regmap_update_bits(afe->regmap, AFE_HDMI_OUT_CON0,
+			   AFE_HDMI_OUT_CH_NUM_MASK_SFT,
+			   channels << AFE_HDMI_OUT_CH_NUM_SFT);
+
+	regmap_update_bits(afe->regmap, AFE_HDMI_OUT_CON0,
+			   AFE_HDMI_OUT_BIT_WIDTH_MASK_SFT,
+			   get_hdmi_wlen(format) << AFE_HDMI_OUT_BIT_WIDTH_SFT);
+	return 0;
+}
+
+static int mtk_dai_tdm_trigger(struct snd_pcm_substream *substream,
+			       int cmd,
+			       struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* enable Out control */
+		regmap_update_bits(afe->regmap, AFE_HDMI_OUT_CON0,
+				   AFE_HDMI_OUT_ON_MASK_SFT,
+				   0x1 << AFE_HDMI_OUT_ON_SFT);
+		/* enable tdm */
+		regmap_update_bits(afe->regmap, AFE_TDM_CON1,
+				   TDM_EN_MASK_SFT, 0x1 << TDM_EN_SFT);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		/* disable tdm */
+		regmap_update_bits(afe->regmap, AFE_TDM_CON1,
+				   TDM_EN_MASK_SFT, 0);
+		/* disable Out control */
+		regmap_update_bits(afe->regmap, AFE_HDMI_OUT_CON0,
+				   AFE_HDMI_OUT_ON_MASK_SFT,
+				   0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mtk_dai_tdm_set_sysclk(struct snd_soc_dai *dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai->id];
+
+	if (!tdm_priv) {
+		dev_warn(afe->dev, "%s(), tdm_priv == NULL", __func__);
+		return -EINVAL;
+	}
+
+	if (dir != SND_SOC_CLOCK_OUT) {
+		dev_warn(afe->dev, "%s(), dir != SND_SOC_CLOCK_OUT", __func__);
+		return -EINVAL;
+	}
+
+	dev_info(afe->dev, "%s(), freq %d\n", __func__, freq);
+
+	return mtk_dai_tdm_cal_mclk(afe, tdm_priv, freq);
+}
+
+static const struct snd_soc_dai_ops mtk_dai_tdm_ops = {
+	.hw_params = mtk_dai_tdm_hw_params,
+	.trigger = mtk_dai_tdm_trigger,
+	.set_sysclk = mtk_dai_tdm_set_sysclk,
+};
+
+/* dai driver */
+#define MTK_TDM_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		       SNDRV_PCM_RATE_88200 |\
+		       SNDRV_PCM_RATE_96000 |\
+		       SNDRV_PCM_RATE_176400 |\
+		       SNDRV_PCM_RATE_192000)
+
+#define MTK_TDM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_tdm_driver[] = {
+	{
+		.name = "TDM",
+		.id = MT8183_DAI_TDM,
+		.playback = {
+			.stream_name = "TDM",
+			.channels_min = 2,
+			.channels_max = 8,
+			.rates = MTK_TDM_RATES,
+			.formats = MTK_TDM_FORMATS,
+		},
+		.ops = &mtk_dai_tdm_ops,
+	},
+};
+
+int mt8183_dai_tdm_register(struct mtk_base_afe *afe)
+{
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_tdm_priv *tdm_priv;
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_tdm_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_tdm_driver);
+
+	dai->dapm_widgets = mtk_dai_tdm_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_tdm_widgets);
+	dai->dapm_routes = mtk_dai_tdm_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_tdm_routes);
+
+	tdm_priv = devm_kzalloc(afe->dev, sizeof(struct mtk_afe_tdm_priv),
+				GFP_KERNEL);
+	if (!tdm_priv)
+		return -ENOMEM;
+
+	tdm_priv->mclk_multiple = 128;
+	tdm_priv->bck_id = MT8183_I2S4_BCK;
+	tdm_priv->mclk_id = MT8183_I2S4_MCK;
+
+	afe_priv->dai_priv[MT8183_DAI_TDM] = tdm_priv;
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8183/mt8183-interconnection.h b/sound/soc/mediatek/mt8183/mt8183-interconnection.h
new file mode 100644
index 0000000..6332f5f
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-interconnection.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Mediatek MT8183 audio driver interconnection definition
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ */
+
+#ifndef _MT8183_INTERCONNECTION_H_
+#define _MT8183_INTERCONNECTION_H_
+
+#define I_I2S0_CH1 0
+#define I_I2S0_CH2 1
+#define I_ADDA_UL_CH1 3
+#define I_ADDA_UL_CH2 4
+#define I_DL1_CH1 5
+#define I_DL1_CH2 6
+#define I_DL2_CH1 7
+#define I_DL2_CH2 8
+#define I_PCM_1_CAP_CH1 9
+#define I_GAIN1_OUT_CH1 10
+#define I_GAIN1_OUT_CH2 11
+#define I_GAIN2_OUT_CH1 12
+#define I_GAIN2_OUT_CH2 13
+#define I_PCM_2_CAP_CH1 14
+#define I_PCM_2_CAP_CH2 21
+#define I_PCM_1_CAP_CH2 22
+#define I_DL3_CH1 23
+#define I_DL3_CH2 24
+#define I_I2S2_CH1 25
+#define I_I2S2_CH2 26
+
+#endif
diff --git a/sound/soc/mediatek/mt8183/mt8183-reg.h b/sound/soc/mediatek/mt8183/mt8183-reg.h
new file mode 100644
index 0000000..e0482f2
--- /dev/null
+++ b/sound/soc/mediatek/mt8183/mt8183-reg.h
@@ -0,0 +1,1666 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8183-reg.h  --  Mediatek 8183 audio driver reg definition
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ */
+
+#ifndef _MT8183_REG_H_
+#define _MT8183_REG_H_
+
+#define AUDIO_TOP_CON0              0x0000
+#define AUDIO_TOP_CON1              0x0004
+#define AUDIO_TOP_CON3              0x000c
+#define AFE_DAC_CON0                0x0010
+#define AFE_DAC_CON1                0x0014
+#define AFE_I2S_CON                 0x0018
+#define AFE_DAIBT_CON0              0x001c
+#define AFE_CONN0                   0x0020
+#define AFE_CONN1                   0x0024
+#define AFE_CONN2                   0x0028
+#define AFE_CONN3                   0x002c
+#define AFE_CONN4                   0x0030
+#define AFE_I2S_CON1                0x0034
+#define AFE_I2S_CON2                0x0038
+#define AFE_MRGIF_CON               0x003c
+#define AFE_DL1_BASE                0x0040
+#define AFE_DL1_CUR                 0x0044
+#define AFE_DL1_END                 0x0048
+#define AFE_I2S_CON3                0x004c
+#define AFE_DL2_BASE                0x0050
+#define AFE_DL2_CUR                 0x0054
+#define AFE_DL2_END                 0x0058
+#define AFE_CONN5                   0x005c
+#define AFE_CONN_24BIT              0x006c
+#define AFE_AWB_BASE                0x0070
+#define AFE_AWB_END                 0x0078
+#define AFE_AWB_CUR                 0x007c
+#define AFE_VUL_BASE                0x0080
+#define AFE_VUL_END                 0x0088
+#define AFE_VUL_CUR                 0x008c
+#define AFE_CONN6                   0x00bc
+#define AFE_MEMIF_MSB               0x00cc
+#define AFE_MEMIF_MON0              0x00d0
+#define AFE_MEMIF_MON1              0x00d4
+#define AFE_MEMIF_MON2              0x00d8
+#define AFE_MEMIF_MON3              0x00dc
+#define AFE_MEMIF_MON4              0x00e0
+#define AFE_MEMIF_MON5              0x00e4
+#define AFE_MEMIF_MON6              0x00e8
+#define AFE_MEMIF_MON7              0x00ec
+#define AFE_MEMIF_MON8              0x00f0
+#define AFE_MEMIF_MON9              0x00f4
+#define AFE_ADDA_DL_SRC2_CON0       0x0108
+#define AFE_ADDA_DL_SRC2_CON1       0x010c
+#define AFE_ADDA_UL_SRC_CON0        0x0114
+#define AFE_ADDA_UL_SRC_CON1        0x0118
+#define AFE_ADDA_TOP_CON0           0x0120
+#define AFE_ADDA_UL_DL_CON0         0x0124
+#define AFE_ADDA_SRC_DEBUG          0x012c
+#define AFE_ADDA_SRC_DEBUG_MON0     0x0130
+#define AFE_ADDA_SRC_DEBUG_MON1     0x0134
+#define AFE_ADDA_UL_SRC_MON0        0x0148
+#define AFE_ADDA_UL_SRC_MON1        0x014c
+#define AFE_SIDETONE_DEBUG          0x01d0
+#define AFE_SIDETONE_MON            0x01d4
+#define AFE_SINEGEN_CON2            0x01dc
+#define AFE_SIDETONE_CON0           0x01e0
+#define AFE_SIDETONE_COEFF          0x01e4
+#define AFE_SIDETONE_CON1           0x01e8
+#define AFE_SIDETONE_GAIN           0x01ec
+#define AFE_SINEGEN_CON0            0x01f0
+#define AFE_TOP_CON0                0x0200
+#define AFE_BUS_CFG                 0x0240
+#define AFE_BUS_MON0                0x0244
+#define AFE_ADDA_PREDIS_CON0        0x0260
+#define AFE_ADDA_PREDIS_CON1        0x0264
+#define AFE_MRGIF_MON0              0x0270
+#define AFE_MRGIF_MON1              0x0274
+#define AFE_MRGIF_MON2              0x0278
+#define AFE_I2S_MON                 0x027c
+#define AFE_ADDA_IIR_COEF_02_01     0x0290
+#define AFE_ADDA_IIR_COEF_04_03     0x0294
+#define AFE_ADDA_IIR_COEF_06_05     0x0298
+#define AFE_ADDA_IIR_COEF_08_07     0x029c
+#define AFE_ADDA_IIR_COEF_10_09     0x02a0
+#define AFE_DAC_CON2                0x02e0
+#define AFE_IRQ_MCU_CON1            0x02e4
+#define AFE_IRQ_MCU_CON2            0x02e8
+#define AFE_DAC_MON                 0x02ec
+#define AFE_VUL2_BASE               0x02f0
+#define AFE_VUL2_END                0x02f8
+#define AFE_VUL2_CUR                0x02fc
+#define AFE_IRQ_MCU_CNT0            0x0300
+#define AFE_IRQ_MCU_CNT6            0x0304
+#define AFE_IRQ_MCU_CNT8            0x0308
+#define AFE_IRQ_MCU_EN1             0x030c
+#define AFE_IRQ0_MCU_CNT_MON        0x0310
+#define AFE_IRQ6_MCU_CNT_MON        0x0314
+#define AFE_MOD_DAI_BASE            0x0330
+#define AFE_MOD_DAI_END             0x0338
+#define AFE_MOD_DAI_CUR             0x033c
+#define AFE_VUL_D2_BASE             0x0350
+#define AFE_VUL_D2_END              0x0358
+#define AFE_VUL_D2_CUR              0x035c
+#define AFE_DL3_BASE                0x0360
+#define AFE_DL3_CUR                 0x0364
+#define AFE_DL3_END                 0x0368
+#define AFE_HDMI_OUT_CON0           0x0370
+#define AFE_HDMI_OUT_BASE           0x0374
+#define AFE_HDMI_OUT_CUR            0x0378
+#define AFE_HDMI_OUT_END            0x037c
+#define AFE_HDMI_CONN0              0x0390
+#define AFE_IRQ3_MCU_CNT_MON        0x0398
+#define AFE_IRQ4_MCU_CNT_MON        0x039c
+#define AFE_IRQ_MCU_CON0            0x03a0
+#define AFE_IRQ_MCU_STATUS          0x03a4
+#define AFE_IRQ_MCU_CLR             0x03a8
+#define AFE_IRQ_MCU_CNT1            0x03ac
+#define AFE_IRQ_MCU_CNT2            0x03b0
+#define AFE_IRQ_MCU_EN              0x03b4
+#define AFE_IRQ_MCU_MON2            0x03b8
+#define AFE_IRQ_MCU_CNT5            0x03bc
+#define AFE_IRQ1_MCU_CNT_MON        0x03c0
+#define AFE_IRQ2_MCU_CNT_MON        0x03c4
+#define AFE_IRQ1_MCU_EN_CNT_MON     0x03c8
+#define AFE_IRQ5_MCU_CNT_MON        0x03cc
+#define AFE_MEMIF_MINLEN            0x03d0
+#define AFE_MEMIF_MAXLEN            0x03d4
+#define AFE_MEMIF_PBUF_SIZE         0x03d8
+#define AFE_IRQ_MCU_CNT7            0x03dc
+#define AFE_IRQ7_MCU_CNT_MON        0x03e0
+#define AFE_IRQ_MCU_CNT3            0x03e4
+#define AFE_IRQ_MCU_CNT4            0x03e8
+#define AFE_IRQ_MCU_CNT11           0x03ec
+#define AFE_APLL1_TUNER_CFG         0x03f0
+#define AFE_APLL2_TUNER_CFG         0x03f4
+#define AFE_MEMIF_HD_MODE           0x03f8
+#define AFE_MEMIF_HDALIGN           0x03fc
+#define AFE_CONN33                  0x0408
+#define AFE_IRQ_MCU_CNT12           0x040c
+#define AFE_GAIN1_CON0              0x0410
+#define AFE_GAIN1_CON1              0x0414
+#define AFE_GAIN1_CON2              0x0418
+#define AFE_GAIN1_CON3              0x041c
+#define AFE_CONN7                   0x0420
+#define AFE_GAIN1_CUR               0x0424
+#define AFE_GAIN2_CON0              0x0428
+#define AFE_GAIN2_CON1              0x042c
+#define AFE_GAIN2_CON2              0x0430
+#define AFE_GAIN2_CON3              0x0434
+#define AFE_CONN8                   0x0438
+#define AFE_GAIN2_CUR               0x043c
+#define AFE_CONN9                   0x0440
+#define AFE_CONN10                  0x0444
+#define AFE_CONN11                  0x0448
+#define AFE_CONN12                  0x044c
+#define AFE_CONN13                  0x0450
+#define AFE_CONN14                  0x0454
+#define AFE_CONN15                  0x0458
+#define AFE_CONN16                  0x045c
+#define AFE_CONN17                  0x0460
+#define AFE_CONN18                  0x0464
+#define AFE_CONN19                  0x0468
+#define AFE_CONN20                  0x046c
+#define AFE_CONN21                  0x0470
+#define AFE_CONN22                  0x0474
+#define AFE_CONN23                  0x0478
+#define AFE_CONN24                  0x047c
+#define AFE_CONN_RS                 0x0494
+#define AFE_CONN_DI                 0x0498
+#define AFE_CONN25                  0x04b0
+#define AFE_CONN26                  0x04b4
+#define AFE_CONN27                  0x04b8
+#define AFE_CONN28                  0x04bc
+#define AFE_CONN29                  0x04c0
+#define AFE_CONN30                  0x04c4
+#define AFE_CONN31                  0x04c8
+#define AFE_CONN32                  0x04cc
+#define AFE_SRAM_DELSEL_CON0        0x04f0
+#define AFE_SRAM_DELSEL_CON2        0x04f8
+#define AFE_SRAM_DELSEL_CON3        0x04fc
+#define AFE_ASRC_2CH_CON12          0x0528
+#define AFE_ASRC_2CH_CON13          0x052c
+#define PCM_INTF_CON1               0x0530
+#define PCM_INTF_CON2               0x0538
+#define PCM2_INTF_CON               0x053c
+#define AFE_TDM_CON1                0x0548
+#define AFE_TDM_CON2                0x054c
+#define AFE_CONN34                  0x0580
+#define FPGA_CFG0                   0x05b0
+#define FPGA_CFG1                   0x05b4
+#define FPGA_CFG2                   0x05c0
+#define FPGA_CFG3                   0x05c4
+#define AUDIO_TOP_DBG_CON           0x05c8
+#define AUDIO_TOP_DBG_MON0          0x05cc
+#define AUDIO_TOP_DBG_MON1          0x05d0
+#define AFE_IRQ8_MCU_CNT_MON        0x05e4
+#define AFE_IRQ11_MCU_CNT_MON       0x05e8
+#define AFE_IRQ12_MCU_CNT_MON       0x05ec
+#define AFE_GENERAL_REG0            0x0800
+#define AFE_GENERAL_REG1            0x0804
+#define AFE_GENERAL_REG2            0x0808
+#define AFE_GENERAL_REG3            0x080c
+#define AFE_GENERAL_REG4            0x0810
+#define AFE_GENERAL_REG5            0x0814
+#define AFE_GENERAL_REG6            0x0818
+#define AFE_GENERAL_REG7            0x081c
+#define AFE_GENERAL_REG8            0x0820
+#define AFE_GENERAL_REG9            0x0824
+#define AFE_GENERAL_REG10           0x0828
+#define AFE_GENERAL_REG11           0x082c
+#define AFE_GENERAL_REG12           0x0830
+#define AFE_GENERAL_REG13           0x0834
+#define AFE_GENERAL_REG14           0x0838
+#define AFE_GENERAL_REG15           0x083c
+#define AFE_CBIP_CFG0               0x0840
+#define AFE_CBIP_MON0               0x0844
+#define AFE_CBIP_SLV_MUX_MON0       0x0848
+#define AFE_CBIP_SLV_DECODER_MON0   0x084c
+#define AFE_CONN0_1                 0x0900
+#define AFE_CONN1_1                 0x0904
+#define AFE_CONN2_1                 0x0908
+#define AFE_CONN3_1                 0x090c
+#define AFE_CONN4_1                 0x0910
+#define AFE_CONN5_1                 0x0914
+#define AFE_CONN6_1                 0x0918
+#define AFE_CONN7_1                 0x091c
+#define AFE_CONN8_1                 0x0920
+#define AFE_CONN9_1                 0x0924
+#define AFE_CONN10_1                0x0928
+#define AFE_CONN11_1                0x092c
+#define AFE_CONN12_1                0x0930
+#define AFE_CONN13_1                0x0934
+#define AFE_CONN14_1                0x0938
+#define AFE_CONN15_1                0x093c
+#define AFE_CONN16_1                0x0940
+#define AFE_CONN17_1                0x0944
+#define AFE_CONN18_1                0x0948
+#define AFE_CONN19_1                0x094c
+#define AFE_CONN20_1                0x0950
+#define AFE_CONN21_1                0x0954
+#define AFE_CONN22_1                0x0958
+#define AFE_CONN23_1                0x095c
+#define AFE_CONN24_1                0x0960
+#define AFE_CONN25_1                0x0964
+#define AFE_CONN26_1                0x0968
+#define AFE_CONN27_1                0x096c
+#define AFE_CONN28_1                0x0970
+#define AFE_CONN29_1                0x0974
+#define AFE_CONN30_1                0x0978
+#define AFE_CONN31_1                0x097c
+#define AFE_CONN32_1                0x0980
+#define AFE_CONN33_1                0x0984
+#define AFE_CONN34_1                0x0988
+#define AFE_CONN_RS_1               0x098c
+#define AFE_CONN_DI_1               0x0990
+#define AFE_CONN_24BIT_1            0x0994
+#define AFE_CONN_REG                0x0998
+#define AFE_CONN35                  0x09a0
+#define AFE_CONN36                  0x09a4
+#define AFE_CONN37                  0x09a8
+#define AFE_CONN38                  0x09ac
+#define AFE_CONN35_1                0x09b0
+#define AFE_CONN36_1                0x09b4
+#define AFE_CONN37_1                0x09b8
+#define AFE_CONN38_1                0x09bc
+#define AFE_CONN39                  0x09c0
+#define AFE_CONN40                  0x09c4
+#define AFE_CONN41                  0x09c8
+#define AFE_CONN42                  0x09cc
+#define AFE_CONN39_1                0x09e0
+#define AFE_CONN40_1                0x09e4
+#define AFE_CONN41_1                0x09e8
+#define AFE_CONN42_1                0x09ec
+#define AFE_I2S_CON4                0x09f8
+#define AFE_ADDA6_TOP_CON0          0x0a80
+#define AFE_ADDA6_UL_SRC_CON0       0x0a84
+#define AFE_ADD6_UL_SRC_CON1        0x0a88
+#define AFE_ADDA6_SRC_DEBUG         0x0a8c
+#define AFE_ADDA6_SRC_DEBUG_MON0    0x0a90
+#define AFE_ADDA6_ULCF_CFG_02_01    0x0aa0
+#define AFE_ADDA6_ULCF_CFG_04_03    0x0aa4
+#define AFE_ADDA6_ULCF_CFG_06_05    0x0aa8
+#define AFE_ADDA6_ULCF_CFG_08_07    0x0aac
+#define AFE_ADDA6_ULCF_CFG_10_09    0x0ab0
+#define AFE_ADDA6_ULCF_CFG_12_11    0x0ab4
+#define AFE_ADDA6_ULCF_CFG_14_13    0x0ab8
+#define AFE_ADDA6_ULCF_CFG_16_15    0x0abc
+#define AFE_ADDA6_ULCF_CFG_18_17    0x0ac0
+#define AFE_ADDA6_ULCF_CFG_20_19    0x0ac4
+#define AFE_ADDA6_ULCF_CFG_22_21    0x0ac8
+#define AFE_ADDA6_ULCF_CFG_24_23    0x0acc
+#define AFE_ADDA6_ULCF_CFG_26_25    0x0ad0
+#define AFE_ADDA6_ULCF_CFG_28_27    0x0ad4
+#define AFE_ADDA6_ULCF_CFG_30_29    0x0ad8
+#define AFE_ADD6A_UL_SRC_MON0       0x0ae4
+#define AFE_ADDA6_UL_SRC_MON1       0x0ae8
+#define AFE_CONN43                  0x0af8
+#define AFE_CONN43_1                0x0afc
+#define AFE_DL1_BASE_MSB            0x0b00
+#define AFE_DL1_CUR_MSB             0x0b04
+#define AFE_DL1_END_MSB             0x0b08
+#define AFE_DL2_BASE_MSB            0x0b10
+#define AFE_DL2_CUR_MSB             0x0b14
+#define AFE_DL2_END_MSB             0x0b18
+#define AFE_AWB_BASE_MSB            0x0b20
+#define AFE_AWB_END_MSB             0x0b28
+#define AFE_AWB_CUR_MSB             0x0b2c
+#define AFE_VUL_BASE_MSB            0x0b30
+#define AFE_VUL_END_MSB             0x0b38
+#define AFE_VUL_CUR_MSB             0x0b3c
+#define AFE_VUL2_BASE_MSB           0x0b50
+#define AFE_VUL2_END_MSB            0x0b58
+#define AFE_VUL2_CUR_MSB            0x0b5c
+#define AFE_MOD_DAI_BASE_MSB        0x0b60
+#define AFE_MOD_DAI_END_MSB         0x0b68
+#define AFE_MOD_DAI_CUR_MSB         0x0b6c
+#define AFE_VUL_D2_BASE_MSB         0x0b80
+#define AFE_VUL_D2_END_MSB          0x0b88
+#define AFE_VUL_D2_CUR_MSB          0x0b8c
+#define AFE_DL3_BASE_MSB            0x0b90
+#define AFE_DL3_CUR_MSB             0x0b94
+#define AFE_DL3_END_MSB             0x0b98
+#define AFE_HDMI_OUT_BASE_MSB       0x0ba4
+#define AFE_HDMI_OUT_CUR_MSB        0x0ba8
+#define AFE_HDMI_OUT_END_MSB        0x0bac
+#define AFE_AWB2_BASE               0x0bd0
+#define AFE_AWB2_END                0x0bd8
+#define AFE_AWB2_CUR                0x0bdc
+#define AFE_AWB2_BASE_MSB           0x0be0
+#define AFE_AWB2_END_MSB            0x0be8
+#define AFE_AWB2_CUR_MSB            0x0bec
+#define AFE_ADDA_DL_SDM_DCCOMP_CON  0x0c50
+#define AFE_ADDA_DL_SDM_TEST        0x0c54
+#define AFE_ADDA_DL_DC_COMP_CFG0    0x0c58
+#define AFE_ADDA_DL_DC_COMP_CFG1    0x0c5c
+#define AFE_ADDA_DL_SDM_FIFO_MON    0x0c60
+#define AFE_ADDA_DL_SRC_LCH_MON     0x0c64
+#define AFE_ADDA_DL_SRC_RCH_MON     0x0c68
+#define AFE_ADDA_DL_SDM_OUT_MON     0x0c6c
+#define AFE_CONNSYS_I2S_CON         0x0c78
+#define AFE_CONNSYS_I2S_MON         0x0c7c
+#define AFE_ASRC_2CH_CON0           0x0c80
+#define AFE_ASRC_2CH_CON1           0x0c84
+#define AFE_ASRC_2CH_CON2           0x0c88
+#define AFE_ASRC_2CH_CON3           0x0c8c
+#define AFE_ASRC_2CH_CON4           0x0c90
+#define AFE_ASRC_2CH_CON5           0x0c94
+#define AFE_ASRC_2CH_CON6           0x0c98
+#define AFE_ASRC_2CH_CON7           0x0c9c
+#define AFE_ASRC_2CH_CON8           0x0ca0
+#define AFE_ASRC_2CH_CON9           0x0ca4
+#define AFE_ASRC_2CH_CON10          0x0ca8
+#define AFE_ADDA6_IIR_COEF_02_01    0x0ce0
+#define AFE_ADDA6_IIR_COEF_04_03    0x0ce4
+#define AFE_ADDA6_IIR_COEF_06_05    0x0ce8
+#define AFE_ADDA6_IIR_COEF_08_07    0x0cec
+#define AFE_ADDA6_IIR_COEF_10_09    0x0cf0
+#define AFE_ADDA_PREDIS_CON2        0x0d40
+#define AFE_ADDA_PREDIS_CON3        0x0d44
+#define AFE_MEMIF_MON12             0x0d70
+#define AFE_MEMIF_MON13             0x0d74
+#define AFE_MEMIF_MON14             0x0d78
+#define AFE_MEMIF_MON15             0x0d7c
+#define AFE_MEMIF_MON16             0x0d80
+#define AFE_MEMIF_MON17             0x0d84
+#define AFE_MEMIF_MON18             0x0d88
+#define AFE_MEMIF_MON19             0x0d8c
+#define AFE_MEMIF_MON20             0x0d90
+#define AFE_MEMIF_MON21             0x0d94
+#define AFE_MEMIF_MON22             0x0d98
+#define AFE_MEMIF_MON23             0x0d9c
+#define AFE_MEMIF_MON24             0x0da0
+#define AFE_HD_ENGEN_ENABLE         0x0dd0
+#define AFE_ADDA_MTKAIF_CFG0        0x0e00
+#define AFE_ADDA_MTKAIF_TX_CFG1     0x0e14
+#define AFE_ADDA_MTKAIF_RX_CFG0     0x0e20
+#define AFE_ADDA_MTKAIF_RX_CFG1     0x0e24
+#define AFE_ADDA_MTKAIF_RX_CFG2     0x0e28
+#define AFE_ADDA_MTKAIF_MON0        0x0e34
+#define AFE_ADDA_MTKAIF_MON1        0x0e38
+#define AFE_AUD_PAD_TOP             0x0e40
+#define AFE_GENERAL1_ASRC_2CH_CON0  0x0e80
+#define AFE_GENERAL1_ASRC_2CH_CON1  0x0e84
+#define AFE_GENERAL1_ASRC_2CH_CON2  0x0e88
+#define AFE_GENERAL1_ASRC_2CH_CON3  0x0e8c
+#define AFE_GENERAL1_ASRC_2CH_CON4  0x0e90
+#define AFE_GENERAL1_ASRC_2CH_CON5  0x0e94
+#define AFE_GENERAL1_ASRC_2CH_CON6  0x0e98
+#define AFE_GENERAL1_ASRC_2CH_CON7  0x0e9c
+#define AFE_GENERAL1_ASRC_2CH_CON8  0x0ea0
+#define AFE_GENERAL1_ASRC_2CH_CON9  0x0ea4
+#define AFE_GENERAL1_ASRC_2CH_CON10 0x0ea8
+#define AFE_GENERAL1_ASRC_2CH_CON12 0x0eb0
+#define AFE_GENERAL1_ASRC_2CH_CON13 0x0eb4
+#define GENERAL_ASRC_MODE           0x0eb8
+#define GENERAL_ASRC_EN_ON          0x0ebc
+#define AFE_GENERAL2_ASRC_2CH_CON0  0x0f00
+#define AFE_GENERAL2_ASRC_2CH_CON1  0x0f04
+#define AFE_GENERAL2_ASRC_2CH_CON2  0x0f08
+#define AFE_GENERAL2_ASRC_2CH_CON3  0x0f0c
+#define AFE_GENERAL2_ASRC_2CH_CON4  0x0f10
+#define AFE_GENERAL2_ASRC_2CH_CON5  0x0f14
+#define AFE_GENERAL2_ASRC_2CH_CON6  0x0f18
+#define AFE_GENERAL2_ASRC_2CH_CON7  0x0f1c
+#define AFE_GENERAL2_ASRC_2CH_CON8  0x0f20
+#define AFE_GENERAL2_ASRC_2CH_CON9  0x0f24
+#define AFE_GENERAL2_ASRC_2CH_CON10 0x0f28
+#define AFE_GENERAL2_ASRC_2CH_CON12 0x0f30
+#define AFE_GENERAL2_ASRC_2CH_CON13 0x0f34
+
+#define AFE_MAX_REGISTER AFE_GENERAL2_ASRC_2CH_CON13
+#define AFE_IRQ_STATUS_BITS 0x1fff
+
+/* AFE_DAC_CON0 */
+#define AWB2_ON_SFT                                   29
+#define AWB2_ON_MASK                                  0x1
+#define AWB2_ON_MASK_SFT                              (0x1 << 29)
+#define VUL2_ON_SFT                                   27
+#define VUL2_ON_MASK                                  0x1
+#define VUL2_ON_MASK_SFT                              (0x1 << 27)
+#define MOD_DAI_DUP_WR_SFT                            26
+#define MOD_DAI_DUP_WR_MASK                           0x1
+#define MOD_DAI_DUP_WR_MASK_SFT                       (0x1 << 26)
+#define VUL12_MODE_SFT                                20
+#define VUL12_MODE_MASK                               0xf
+#define VUL12_MODE_MASK_SFT                           (0xf << 20)
+#define VUL12_R_MONO_SFT                              11
+#define VUL12_R_MONO_MASK                             0x1
+#define VUL12_R_MONO_MASK_SFT                         (0x1 << 11)
+#define VUL12_MONO_SFT                                10
+#define VUL12_MONO_MASK                               0x1
+#define VUL12_MONO_MASK_SFT                           (0x1 << 10)
+#define VUL12_ON_SFT                                  9
+#define VUL12_ON_MASK                                 0x1
+#define VUL12_ON_MASK_SFT                             (0x1 << 9)
+#define MOD_DAI_ON_SFT                                7
+#define MOD_DAI_ON_MASK                               0x1
+#define MOD_DAI_ON_MASK_SFT                           (0x1 << 7)
+#define AWB_ON_SFT                                    6
+#define AWB_ON_MASK                                   0x1
+#define AWB_ON_MASK_SFT                               (0x1 << 6)
+#define DL3_ON_SFT                                    5
+#define DL3_ON_MASK                                   0x1
+#define DL3_ON_MASK_SFT                               (0x1 << 5)
+#define VUL_ON_SFT                                    3
+#define VUL_ON_MASK                                   0x1
+#define VUL_ON_MASK_SFT                               (0x1 << 3)
+#define DL2_ON_SFT                                    2
+#define DL2_ON_MASK                                   0x1
+#define DL2_ON_MASK_SFT                               (0x1 << 2)
+#define DL1_ON_SFT                                    1
+#define DL1_ON_MASK                                   0x1
+#define DL1_ON_MASK_SFT                               (0x1 << 1)
+#define AFE_ON_SFT                                    0
+#define AFE_ON_MASK                                   0x1
+#define AFE_ON_MASK_SFT                               (0x1 << 0)
+
+/* AFE_DAC_CON1 */
+#define MOD_DAI_MODE_SFT                              30
+#define MOD_DAI_MODE_MASK                             0x3
+#define MOD_DAI_MODE_MASK_SFT                         (0x3 << 30)
+#define VUL_R_MONO_SFT                                28
+#define VUL_R_MONO_MASK                               0x1
+#define VUL_R_MONO_MASK_SFT                           (0x1 << 28)
+#define VUL_DATA_SFT                                  27
+#define VUL_DATA_MASK                                 0x1
+#define VUL_DATA_MASK_SFT                             (0x1 << 27)
+#define AWB_R_MONO_SFT                                25
+#define AWB_R_MONO_MASK                               0x1
+#define AWB_R_MONO_MASK_SFT                           (0x1 << 25)
+#define AWB_DATA_SFT                                  24
+#define AWB_DATA_MASK                                 0x1
+#define AWB_DATA_MASK_SFT                             (0x1 << 24)
+#define DL3_DATA_SFT                                  23
+#define DL3_DATA_MASK                                 0x1
+#define DL3_DATA_MASK_SFT                             (0x1 << 23)
+#define DL2_DATA_SFT                                  22
+#define DL2_DATA_MASK                                 0x1
+#define DL2_DATA_MASK_SFT                             (0x1 << 22)
+#define DL1_DATA_SFT                                  21
+#define DL1_DATA_MASK                                 0x1
+#define DL1_DATA_MASK_SFT                             (0x1 << 21)
+#define VUL_MODE_SFT                                  16
+#define VUL_MODE_MASK                                 0xf
+#define VUL_MODE_MASK_SFT                             (0xf << 16)
+#define AWB_MODE_SFT                                  12
+#define AWB_MODE_MASK                                 0xf
+#define AWB_MODE_MASK_SFT                             (0xf << 12)
+#define I2S_MODE_SFT                                  8
+#define I2S_MODE_MASK                                 0xf
+#define I2S_MODE_MASK_SFT                             (0xf << 8)
+#define DL2_MODE_SFT                                  4
+#define DL2_MODE_MASK                                 0xf
+#define DL2_MODE_MASK_SFT                             (0xf << 4)
+#define DL1_MODE_SFT                                  0
+#define DL1_MODE_MASK                                 0xf
+#define DL1_MODE_MASK_SFT                             (0xf << 0)
+
+/* AFE_DAC_CON2 */
+#define AWB2_R_MONO_SFT                               21
+#define AWB2_R_MONO_MASK                              0x1
+#define AWB2_R_MONO_MASK_SFT                          (0x1 << 21)
+#define AWB2_DATA_SFT                                 20
+#define AWB2_DATA_MASK                                0x1
+#define AWB2_DATA_MASK_SFT                            (0x1 << 20)
+#define AWB2_MODE_SFT                                 16
+#define AWB2_MODE_MASK                                0xf
+#define AWB2_MODE_MASK_SFT                            (0xf << 16)
+#define DL3_MODE_SFT                                  8
+#define DL3_MODE_MASK                                 0xf
+#define DL3_MODE_MASK_SFT                             (0xf << 8)
+#define VUL2_MODE_SFT                                 4
+#define VUL2_MODE_MASK                                0xf
+#define VUL2_MODE_MASK_SFT                            (0xf << 4)
+#define VUL2_R_MONO_SFT                               1
+#define VUL2_R_MONO_MASK                              0x1
+#define VUL2_R_MONO_MASK_SFT                          (0x1 << 1)
+#define VUL2_DATA_SFT                                 0
+#define VUL2_DATA_MASK                                0x1
+#define VUL2_DATA_MASK_SFT                            (0x1 << 0)
+
+/* AFE_DAC_MON */
+#define AFE_ON_RETM_SFT                               0
+#define AFE_ON_RETM_MASK                              0x1
+#define AFE_ON_RETM_MASK_SFT                          (0x1 << 0)
+
+/* AFE_I2S_CON */
+#define BCK_NEG_EG_LATCH_SFT                          30
+#define BCK_NEG_EG_LATCH_MASK                         0x1
+#define BCK_NEG_EG_LATCH_MASK_SFT                     (0x1 << 30)
+#define BCK_INV_SFT                                   29
+#define BCK_INV_MASK                                  0x1
+#define BCK_INV_MASK_SFT                              (0x1 << 29)
+#define I2SIN_PAD_SEL_SFT                             28
+#define I2SIN_PAD_SEL_MASK                            0x1
+#define I2SIN_PAD_SEL_MASK_SFT                        (0x1 << 28)
+#define I2S_LOOPBACK_SFT                              20
+#define I2S_LOOPBACK_MASK                             0x1
+#define I2S_LOOPBACK_MASK_SFT                         (0x1 << 20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT             17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK            0x1
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT        (0x1 << 17)
+#define I2S1_HD_EN_SFT                                12
+#define I2S1_HD_EN_MASK                               0x1
+#define I2S1_HD_EN_MASK_SFT                           (0x1 << 12)
+#define INV_PAD_CTRL_SFT                              7
+#define INV_PAD_CTRL_MASK                             0x1
+#define INV_PAD_CTRL_MASK_SFT                         (0x1 << 7)
+#define I2S_BYPSRC_SFT                                6
+#define I2S_BYPSRC_MASK                               0x1
+#define I2S_BYPSRC_MASK_SFT                           (0x1 << 6)
+#define INV_LRCK_SFT                                  5
+#define INV_LRCK_MASK                                 0x1
+#define INV_LRCK_MASK_SFT                             (0x1 << 5)
+#define I2S_FMT_SFT                                   3
+#define I2S_FMT_MASK                                  0x1
+#define I2S_FMT_MASK_SFT                              (0x1 << 3)
+#define I2S_SRC_SFT                                   2
+#define I2S_SRC_MASK                                  0x1
+#define I2S_SRC_MASK_SFT                              (0x1 << 2)
+#define I2S_WLEN_SFT                                  1
+#define I2S_WLEN_MASK                                 0x1
+#define I2S_WLEN_MASK_SFT                             (0x1 << 1)
+#define I2S_EN_SFT                                    0
+#define I2S_EN_MASK                                   0x1
+#define I2S_EN_MASK_SFT                               (0x1 << 0)
+
+/* AFE_I2S_CON1 */
+#define I2S2_LR_SWAP_SFT                              31
+#define I2S2_LR_SWAP_MASK                             0x1
+#define I2S2_LR_SWAP_MASK_SFT                         (0x1 << 31)
+#define I2S2_SEL_O19_O20_SFT                          18
+#define I2S2_SEL_O19_O20_MASK                         0x1
+#define I2S2_SEL_O19_O20_MASK_SFT                     (0x1 << 18)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT             17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK            0x1
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT        (0x1 << 17)
+#define I2S2_SEL_O03_O04_SFT                          16
+#define I2S2_SEL_O03_O04_MASK                         0x1
+#define I2S2_SEL_O03_O04_MASK_SFT                     (0x1 << 16)
+#define I2S2_32BIT_EN_SFT                             13
+#define I2S2_32BIT_EN_MASK                            0x1
+#define I2S2_32BIT_EN_MASK_SFT                        (0x1 << 13)
+#define I2S2_HD_EN_SFT                                12
+#define I2S2_HD_EN_MASK                               0x1
+#define I2S2_HD_EN_MASK_SFT                           (0x1 << 12)
+#define I2S2_OUT_MODE_SFT                             8
+#define I2S2_OUT_MODE_MASK                            0xf
+#define I2S2_OUT_MODE_MASK_SFT                        (0xf << 8)
+#define INV_LRCK_SFT                                  5
+#define INV_LRCK_MASK                                 0x1
+#define INV_LRCK_MASK_SFT                             (0x1 << 5)
+#define I2S2_FMT_SFT                                  3
+#define I2S2_FMT_MASK                                 0x1
+#define I2S2_FMT_MASK_SFT                             (0x1 << 3)
+#define I2S2_WLEN_SFT                                 1
+#define I2S2_WLEN_MASK                                0x1
+#define I2S2_WLEN_MASK_SFT                            (0x1 << 1)
+#define I2S2_EN_SFT                                   0
+#define I2S2_EN_MASK                                  0x1
+#define I2S2_EN_MASK_SFT                              (0x1 << 0)
+
+/* AFE_I2S_CON2 */
+#define I2S3_LR_SWAP_SFT                              31
+#define I2S3_LR_SWAP_MASK                             0x1
+#define I2S3_LR_SWAP_MASK_SFT                         (0x1 << 31)
+#define I2S3_UPDATE_WORD_SFT                          24
+#define I2S3_UPDATE_WORD_MASK                         0x1f
+#define I2S3_UPDATE_WORD_MASK_SFT                     (0x1f << 24)
+#define I2S3_BCK_INV_SFT                              23
+#define I2S3_BCK_INV_MASK                             0x1
+#define I2S3_BCK_INV_MASK_SFT                         (0x1 << 23)
+#define I2S3_FPGA_BIT_TEST_SFT                        22
+#define I2S3_FPGA_BIT_TEST_MASK                       0x1
+#define I2S3_FPGA_BIT_TEST_MASK_SFT                   (0x1 << 22)
+#define I2S3_FPGA_BIT_SFT                             21
+#define I2S3_FPGA_BIT_MASK                            0x1
+#define I2S3_FPGA_BIT_MASK_SFT                        (0x1 << 21)
+#define I2S3_LOOPBACK_SFT                             20
+#define I2S3_LOOPBACK_MASK                            0x1
+#define I2S3_LOOPBACK_MASK_SFT                        (0x1 << 20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT             17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK            0x1
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT        (0x1 << 17)
+#define I2S3_HD_EN_SFT                                12
+#define I2S3_HD_EN_MASK                               0x1
+#define I2S3_HD_EN_MASK_SFT                           (0x1 << 12)
+#define I2S3_OUT_MODE_SFT                             8
+#define I2S3_OUT_MODE_MASK                            0xf
+#define I2S3_OUT_MODE_MASK_SFT                        (0xf << 8)
+#define I2S3_FMT_SFT                                  3
+#define I2S3_FMT_MASK                                 0x1
+#define I2S3_FMT_MASK_SFT                             (0x1 << 3)
+#define I2S3_WLEN_SFT                                 1
+#define I2S3_WLEN_MASK                                0x1
+#define I2S3_WLEN_MASK_SFT                            (0x1 << 1)
+#define I2S3_EN_SFT                                   0
+#define I2S3_EN_MASK                                  0x1
+#define I2S3_EN_MASK_SFT                              (0x1 << 0)
+
+/* AFE_I2S_CON3 */
+#define I2S4_LR_SWAP_SFT                              31
+#define I2S4_LR_SWAP_MASK                             0x1
+#define I2S4_LR_SWAP_MASK_SFT                         (0x1 << 31)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT             17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK            0x1
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT        (0x1 << 17)
+#define I2S4_32BIT_EN_SFT                             13
+#define I2S4_32BIT_EN_MASK                            0x1
+#define I2S4_32BIT_EN_MASK_SFT                        (0x1 << 13)
+#define I2S4_HD_EN_SFT                                12
+#define I2S4_HD_EN_MASK                               0x1
+#define I2S4_HD_EN_MASK_SFT                           (0x1 << 12)
+#define I2S4_OUT_MODE_SFT                             8
+#define I2S4_OUT_MODE_MASK                            0xf
+#define I2S4_OUT_MODE_MASK_SFT                        (0xf << 8)
+#define INV_LRCK_SFT                                  5
+#define INV_LRCK_MASK                                 0x1
+#define INV_LRCK_MASK_SFT                             (0x1 << 5)
+#define I2S4_FMT_SFT                                  3
+#define I2S4_FMT_MASK                                 0x1
+#define I2S4_FMT_MASK_SFT                             (0x1 << 3)
+#define I2S4_WLEN_SFT                                 1
+#define I2S4_WLEN_MASK                                0x1
+#define I2S4_WLEN_MASK_SFT                            (0x1 << 1)
+#define I2S4_EN_SFT                                   0
+#define I2S4_EN_MASK                                  0x1
+#define I2S4_EN_MASK_SFT                              (0x1 << 0)
+
+/* AFE_I2S_CON4 */
+#define I2S5_LR_SWAP_SFT                              31
+#define I2S5_LR_SWAP_MASK                             0x1
+#define I2S5_LR_SWAP_MASK_SFT                         (0x1 << 31)
+#define I2S_LOOPBACK_SFT                              20
+#define I2S_LOOPBACK_MASK                             0x1
+#define I2S_LOOPBACK_MASK_SFT                         (0x1 << 20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT             17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK            0x1
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT        (0x1 << 17)
+#define I2S5_32BIT_EN_SFT                             13
+#define I2S5_32BIT_EN_MASK                            0x1
+#define I2S5_32BIT_EN_MASK_SFT                        (0x1 << 13)
+#define I2S5_HD_EN_SFT                                12
+#define I2S5_HD_EN_MASK                               0x1
+#define I2S5_HD_EN_MASK_SFT                           (0x1 << 12)
+#define I2S5_OUT_MODE_SFT                             8
+#define I2S5_OUT_MODE_MASK                            0xf
+#define I2S5_OUT_MODE_MASK_SFT                        (0xf << 8)
+#define INV_LRCK_SFT                                  5
+#define INV_LRCK_MASK                                 0x1
+#define INV_LRCK_MASK_SFT                             (0x1 << 5)
+#define I2S5_FMT_SFT                                  3
+#define I2S5_FMT_MASK                                 0x1
+#define I2S5_FMT_MASK_SFT                             (0x1 << 3)
+#define I2S5_WLEN_SFT                                 1
+#define I2S5_WLEN_MASK                                0x1
+#define I2S5_WLEN_MASK_SFT                            (0x1 << 1)
+#define I2S5_EN_SFT                                   0
+#define I2S5_EN_MASK                                  0x1
+#define I2S5_EN_MASK_SFT                              (0x1 << 0)
+
+/* AFE_GAIN1_CON0 */
+#define GAIN1_SAMPLE_PER_STEP_SFT                     8
+#define GAIN1_SAMPLE_PER_STEP_MASK                    0xff
+#define GAIN1_SAMPLE_PER_STEP_MASK_SFT                (0xff << 8)
+#define GAIN1_MODE_SFT                                4
+#define GAIN1_MODE_MASK                               0xf
+#define GAIN1_MODE_MASK_SFT                           (0xf << 4)
+#define GAIN1_ON_SFT                                  0
+#define GAIN1_ON_MASK                                 0x1
+#define GAIN1_ON_MASK_SFT                             (0x1 << 0)
+
+/* AFE_GAIN1_CON1 */
+#define GAIN1_TARGET_SFT                              0
+#define GAIN1_TARGET_MASK                             0xfffff
+#define GAIN1_TARGET_MASK_SFT                         (0xfffff << 0)
+
+/* AFE_GAIN2_CON0 */
+#define GAIN2_SAMPLE_PER_STEP_SFT                     8
+#define GAIN2_SAMPLE_PER_STEP_MASK                    0xff
+#define GAIN2_SAMPLE_PER_STEP_MASK_SFT                (0xff << 8)
+#define GAIN2_MODE_SFT                                4
+#define GAIN2_MODE_MASK                               0xf
+#define GAIN2_MODE_MASK_SFT                           (0xf << 4)
+#define GAIN2_ON_SFT                                  0
+#define GAIN2_ON_MASK                                 0x1
+#define GAIN2_ON_MASK_SFT                             (0x1 << 0)
+
+/* AFE_GAIN2_CON1 */
+#define GAIN2_TARGET_SFT                              0
+#define GAIN2_TARGET_MASK                             0xfffff
+#define GAIN2_TARGET_MASK_SFT                         (0xfffff << 0)
+
+/* AFE_GAIN1_CUR */
+#define AFE_GAIN1_CUR_SFT                             0
+#define AFE_GAIN1_CUR_MASK                            0xfffff
+#define AFE_GAIN1_CUR_MASK_SFT                        (0xfffff << 0)
+
+/* AFE_GAIN2_CUR */
+#define AFE_GAIN2_CUR_SFT                             0
+#define AFE_GAIN2_CUR_MASK                            0xfffff
+#define AFE_GAIN2_CUR_MASK_SFT                        (0xfffff << 0)
+
+/* AFE_MEMIF_HD_MODE */
+#define AWB2_HD_SFT                                   28
+#define AWB2_HD_MASK                                  0x3
+#define AWB2_HD_MASK_SFT                              (0x3 << 28)
+#define HDMI_HD_SFT                                   20
+#define HDMI_HD_MASK                                  0x3
+#define HDMI_HD_MASK_SFT                              (0x3 << 20)
+#define MOD_DAI_HD_SFT                                18
+#define MOD_DAI_HD_MASK                               0x3
+#define MOD_DAI_HD_MASK_SFT                           (0x3 << 18)
+#define DAI_HD_SFT                                    16
+#define DAI_HD_MASK                                   0x3
+#define DAI_HD_MASK_SFT                               (0x3 << 16)
+#define VUL2_HD_SFT                                   14
+#define VUL2_HD_MASK                                  0x3
+#define VUL2_HD_MASK_SFT                              (0x3 << 14)
+#define VUL12_HD_SFT                                  12
+#define VUL12_HD_MASK                                 0x3
+#define VUL12_HD_MASK_SFT                             (0x3 << 12)
+#define VUL_HD_SFT                                    10
+#define VUL_HD_MASK                                   0x3
+#define VUL_HD_MASK_SFT                               (0x3 << 10)
+#define AWB_HD_SFT                                    8
+#define AWB_HD_MASK                                   0x3
+#define AWB_HD_MASK_SFT                               (0x3 << 8)
+#define DL3_HD_SFT                                    6
+#define DL3_HD_MASK                                   0x3
+#define DL3_HD_MASK_SFT                               (0x3 << 6)
+#define DL2_HD_SFT                                    4
+#define DL2_HD_MASK                                   0x3
+#define DL2_HD_MASK_SFT                               (0x3 << 4)
+#define DL1_HD_SFT                                    0
+#define DL1_HD_MASK                                   0x3
+#define DL1_HD_MASK_SFT                               (0x3 << 0)
+
+/* AFE_MEMIF_HDALIGN */
+#define AWB2_NORMAL_MODE_SFT                          30
+#define AWB2_NORMAL_MODE_MASK                         0x1
+#define AWB2_NORMAL_MODE_MASK_SFT                     (0x1 << 30)
+#define HDMI_NORMAL_MODE_SFT                          26
+#define HDMI_NORMAL_MODE_MASK                         0x1
+#define HDMI_NORMAL_MODE_MASK_SFT                     (0x1 << 26)
+#define MOD_DAI_NORMAL_MODE_SFT                       25
+#define MOD_DAI_NORMAL_MODE_MASK                      0x1
+#define MOD_DAI_NORMAL_MODE_MASK_SFT                  (0x1 << 25)
+#define DAI_NORMAL_MODE_SFT                           24
+#define DAI_NORMAL_MODE_MASK                          0x1
+#define DAI_NORMAL_MODE_MASK_SFT                      (0x1 << 24)
+#define VUL2_NORMAL_MODE_SFT                          23
+#define VUL2_NORMAL_MODE_MASK                         0x1
+#define VUL2_NORMAL_MODE_MASK_SFT                     (0x1 << 23)
+#define VUL12_NORMAL_MODE_SFT                         22
+#define VUL12_NORMAL_MODE_MASK                        0x1
+#define VUL12_NORMAL_MODE_MASK_SFT                    (0x1 << 22)
+#define VUL_NORMAL_MODE_SFT                           21
+#define VUL_NORMAL_MODE_MASK                          0x1
+#define VUL_NORMAL_MODE_MASK_SFT                      (0x1 << 21)
+#define AWB_NORMAL_MODE_SFT                           20
+#define AWB_NORMAL_MODE_MASK                          0x1
+#define AWB_NORMAL_MODE_MASK_SFT                      (0x1 << 20)
+#define DL3_NORMAL_MODE_SFT                           19
+#define DL3_NORMAL_MODE_MASK                          0x1
+#define DL3_NORMAL_MODE_MASK_SFT                      (0x1 << 19)
+#define DL2_NORMAL_MODE_SFT                           18
+#define DL2_NORMAL_MODE_MASK                          0x1
+#define DL2_NORMAL_MODE_MASK_SFT                      (0x1 << 18)
+#define DL1_NORMAL_MODE_SFT                           16
+#define DL1_NORMAL_MODE_MASK                          0x1
+#define DL1_NORMAL_MODE_MASK_SFT                      (0x1 << 16)
+#define RESERVED1_SFT                                 15
+#define RESERVED1_MASK                                0x1
+#define RESERVED1_MASK_SFT                            (0x1 << 15)
+#define AWB2_ALIGN_SFT                                14
+#define AWB2_ALIGN_MASK                               0x1
+#define AWB2_ALIGN_MASK_SFT                           (0x1 << 14)
+#define HDMI_HD_ALIGN_SFT                             10
+#define HDMI_HD_ALIGN_MASK                            0x1
+#define HDMI_HD_ALIGN_MASK_SFT                        (0x1 << 10)
+#define MOD_DAI_HD_ALIGN_SFT                          9
+#define MOD_DAI_HD_ALIGN_MASK                         0x1
+#define MOD_DAI_HD_ALIGN_MASK_SFT                     (0x1 << 9)
+#define VUL2_HD_ALIGN_SFT                             7
+#define VUL2_HD_ALIGN_MASK                            0x1
+#define VUL2_HD_ALIGN_MASK_SFT                        (0x1 << 7)
+#define VUL12_HD_ALIGN_SFT                            6
+#define VUL12_HD_ALIGN_MASK                           0x1
+#define VUL12_HD_ALIGN_MASK_SFT                       (0x1 << 6)
+#define VUL_HD_ALIGN_SFT                              5
+#define VUL_HD_ALIGN_MASK                             0x1
+#define VUL_HD_ALIGN_MASK_SFT                         (0x1 << 5)
+#define AWB_HD_ALIGN_SFT                              4
+#define AWB_HD_ALIGN_MASK                             0x1
+#define AWB_HD_ALIGN_MASK_SFT                         (0x1 << 4)
+#define DL3_HD_ALIGN_SFT                              3
+#define DL3_HD_ALIGN_MASK                             0x1
+#define DL3_HD_ALIGN_MASK_SFT                         (0x1 << 3)
+#define DL2_HD_ALIGN_SFT                              2
+#define DL2_HD_ALIGN_MASK                             0x1
+#define DL2_HD_ALIGN_MASK_SFT                         (0x1 << 2)
+#define DL1_HD_ALIGN_SFT                              0
+#define DL1_HD_ALIGN_MASK                             0x1
+#define DL1_HD_ALIGN_MASK_SFT                         (0x1 << 0)
+
+/* PCM_INTF_CON1 */
+#define PCM_FIX_VALUE_SEL_SFT                         31
+#define PCM_FIX_VALUE_SEL_MASK                        0x1
+#define PCM_FIX_VALUE_SEL_MASK_SFT                    (0x1 << 31)
+#define PCM_BUFFER_LOOPBACK_SFT                       30
+#define PCM_BUFFER_LOOPBACK_MASK                      0x1
+#define PCM_BUFFER_LOOPBACK_MASK_SFT                  (0x1 << 30)
+#define PCM_PARALLEL_LOOPBACK_SFT                     29
+#define PCM_PARALLEL_LOOPBACK_MASK                    0x1
+#define PCM_PARALLEL_LOOPBACK_MASK_SFT                (0x1 << 29)
+#define PCM_SERIAL_LOOPBACK_SFT                       28
+#define PCM_SERIAL_LOOPBACK_MASK                      0x1
+#define PCM_SERIAL_LOOPBACK_MASK_SFT                  (0x1 << 28)
+#define PCM_DAI_PCM_LOOPBACK_SFT                      27
+#define PCM_DAI_PCM_LOOPBACK_MASK                     0x1
+#define PCM_DAI_PCM_LOOPBACK_MASK_SFT                 (0x1 << 27)
+#define PCM_I2S_PCM_LOOPBACK_SFT                      26
+#define PCM_I2S_PCM_LOOPBACK_MASK                     0x1
+#define PCM_I2S_PCM_LOOPBACK_MASK_SFT                 (0x1 << 26)
+#define PCM_SYNC_DELSEL_SFT                           25
+#define PCM_SYNC_DELSEL_MASK                          0x1
+#define PCM_SYNC_DELSEL_MASK_SFT                      (0x1 << 25)
+#define PCM_TX_LR_SWAP_SFT                            24
+#define PCM_TX_LR_SWAP_MASK                           0x1
+#define PCM_TX_LR_SWAP_MASK_SFT                       (0x1 << 24)
+#define PCM_SYNC_OUT_INV_SFT                          23
+#define PCM_SYNC_OUT_INV_MASK                         0x1
+#define PCM_SYNC_OUT_INV_MASK_SFT                     (0x1 << 23)
+#define PCM_BCLK_OUT_INV_SFT                          22
+#define PCM_BCLK_OUT_INV_MASK                         0x1
+#define PCM_BCLK_OUT_INV_MASK_SFT                     (0x1 << 22)
+#define PCM_SYNC_IN_INV_SFT                           21
+#define PCM_SYNC_IN_INV_MASK                          0x1
+#define PCM_SYNC_IN_INV_MASK_SFT                      (0x1 << 21)
+#define PCM_BCLK_IN_INV_SFT                           20
+#define PCM_BCLK_IN_INV_MASK                          0x1
+#define PCM_BCLK_IN_INV_MASK_SFT                      (0x1 << 20)
+#define PCM_TX_LCH_RPT_SFT                            19
+#define PCM_TX_LCH_RPT_MASK                           0x1
+#define PCM_TX_LCH_RPT_MASK_SFT                       (0x1 << 19)
+#define PCM_VBT_16K_MODE_SFT                          18
+#define PCM_VBT_16K_MODE_MASK                         0x1
+#define PCM_VBT_16K_MODE_MASK_SFT                     (0x1 << 18)
+#define PCM_EXT_MODEM_SFT                             17
+#define PCM_EXT_MODEM_MASK                            0x1
+#define PCM_EXT_MODEM_MASK_SFT                        (0x1 << 17)
+#define PCM_24BIT_SFT                                 16
+#define PCM_24BIT_MASK                                0x1
+#define PCM_24BIT_MASK_SFT                            (0x1 << 16)
+#define PCM_WLEN_SFT                                  14
+#define PCM_WLEN_MASK                                 0x3
+#define PCM_WLEN_MASK_SFT                             (0x3 << 14)
+#define PCM_SYNC_LENGTH_SFT                           9
+#define PCM_SYNC_LENGTH_MASK                          0x1f
+#define PCM_SYNC_LENGTH_MASK_SFT                      (0x1f << 9)
+#define PCM_SYNC_TYPE_SFT                             8
+#define PCM_SYNC_TYPE_MASK                            0x1
+#define PCM_SYNC_TYPE_MASK_SFT                        (0x1 << 8)
+#define PCM_BT_MODE_SFT                               7
+#define PCM_BT_MODE_MASK                              0x1
+#define PCM_BT_MODE_MASK_SFT                          (0x1 << 7)
+#define PCM_BYP_ASRC_SFT                              6
+#define PCM_BYP_ASRC_MASK                             0x1
+#define PCM_BYP_ASRC_MASK_SFT                         (0x1 << 6)
+#define PCM_SLAVE_SFT                                 5
+#define PCM_SLAVE_MASK                                0x1
+#define PCM_SLAVE_MASK_SFT                            (0x1 << 5)
+#define PCM_MODE_SFT                                  3
+#define PCM_MODE_MASK                                 0x3
+#define PCM_MODE_MASK_SFT                             (0x3 << 3)
+#define PCM_FMT_SFT                                   1
+#define PCM_FMT_MASK                                  0x3
+#define PCM_FMT_MASK_SFT                              (0x3 << 1)
+#define PCM_EN_SFT                                    0
+#define PCM_EN_MASK                                   0x1
+#define PCM_EN_MASK_SFT                               (0x1 << 0)
+
+/* PCM_INTF_CON2 */
+#define PCM1_TX_FIFO_OV_SFT                           31
+#define PCM1_TX_FIFO_OV_MASK                          0x1
+#define PCM1_TX_FIFO_OV_MASK_SFT                      (0x1 << 31)
+#define PCM1_RX_FIFO_OV_SFT                           30
+#define PCM1_RX_FIFO_OV_MASK                          0x1
+#define PCM1_RX_FIFO_OV_MASK_SFT                      (0x1 << 30)
+#define PCM2_TX_FIFO_OV_SFT                           29
+#define PCM2_TX_FIFO_OV_MASK                          0x1
+#define PCM2_TX_FIFO_OV_MASK_SFT                      (0x1 << 29)
+#define PCM2_RX_FIFO_OV_SFT                           28
+#define PCM2_RX_FIFO_OV_MASK                          0x1
+#define PCM2_RX_FIFO_OV_MASK_SFT                      (0x1 << 28)
+#define PCM1_SYNC_GLITCH_SFT                          27
+#define PCM1_SYNC_GLITCH_MASK                         0x1
+#define PCM1_SYNC_GLITCH_MASK_SFT                     (0x1 << 27)
+#define PCM2_SYNC_GLITCH_SFT                          26
+#define PCM2_SYNC_GLITCH_MASK                         0x1
+#define PCM2_SYNC_GLITCH_MASK_SFT                     (0x1 << 26)
+#define TX3_RCH_DBG_MODE_SFT                          17
+#define TX3_RCH_DBG_MODE_MASK                         0x1
+#define TX3_RCH_DBG_MODE_MASK_SFT                     (0x1 << 17)
+#define PCM1_PCM2_LOOPBACK_SFT                        16
+#define PCM1_PCM2_LOOPBACK_MASK                       0x1
+#define PCM1_PCM2_LOOPBACK_MASK_SFT                   (0x1 << 16)
+#define DAI_PCM_LOOPBACK_CH_SFT                       14
+#define DAI_PCM_LOOPBACK_CH_MASK                      0x3
+#define DAI_PCM_LOOPBACK_CH_MASK_SFT                  (0x3 << 14)
+#define I2S_PCM_LOOPBACK_CH_SFT                       12
+#define I2S_PCM_LOOPBACK_CH_MASK                      0x3
+#define I2S_PCM_LOOPBACK_CH_MASK_SFT                  (0x3 << 12)
+#define TX_FIX_VALUE_SFT                              0
+#define TX_FIX_VALUE_MASK                             0xff
+#define TX_FIX_VALUE_MASK_SFT                         (0xff << 0)
+
+/* PCM2_INTF_CON */
+#define PCM2_TX_FIX_VALUE_SFT                         24
+#define PCM2_TX_FIX_VALUE_MASK                        0xff
+#define PCM2_TX_FIX_VALUE_MASK_SFT                    (0xff << 24)
+#define PCM2_FIX_VALUE_SEL_SFT                        23
+#define PCM2_FIX_VALUE_SEL_MASK                       0x1
+#define PCM2_FIX_VALUE_SEL_MASK_SFT                   (0x1 << 23)
+#define PCM2_BUFFER_LOOPBACK_SFT                      22
+#define PCM2_BUFFER_LOOPBACK_MASK                     0x1
+#define PCM2_BUFFER_LOOPBACK_MASK_SFT                 (0x1 << 22)
+#define PCM2_PARALLEL_LOOPBACK_SFT                    21
+#define PCM2_PARALLEL_LOOPBACK_MASK                   0x1
+#define PCM2_PARALLEL_LOOPBACK_MASK_SFT               (0x1 << 21)
+#define PCM2_SERIAL_LOOPBACK_SFT                      20
+#define PCM2_SERIAL_LOOPBACK_MASK                     0x1
+#define PCM2_SERIAL_LOOPBACK_MASK_SFT                 (0x1 << 20)
+#define PCM2_DAI_PCM_LOOPBACK_SFT                     19
+#define PCM2_DAI_PCM_LOOPBACK_MASK                    0x1
+#define PCM2_DAI_PCM_LOOPBACK_MASK_SFT                (0x1 << 19)
+#define PCM2_I2S_PCM_LOOPBACK_SFT                     18
+#define PCM2_I2S_PCM_LOOPBACK_MASK                    0x1
+#define PCM2_I2S_PCM_LOOPBACK_MASK_SFT                (0x1 << 18)
+#define PCM2_SYNC_DELSEL_SFT                          17
+#define PCM2_SYNC_DELSEL_MASK                         0x1
+#define PCM2_SYNC_DELSEL_MASK_SFT                     (0x1 << 17)
+#define PCM2_TX_LR_SWAP_SFT                           16
+#define PCM2_TX_LR_SWAP_MASK                          0x1
+#define PCM2_TX_LR_SWAP_MASK_SFT                      (0x1 << 16)
+#define PCM2_SYNC_IN_INV_SFT                          15
+#define PCM2_SYNC_IN_INV_MASK                         0x1
+#define PCM2_SYNC_IN_INV_MASK_SFT                     (0x1 << 15)
+#define PCM2_BCLK_IN_INV_SFT                          14
+#define PCM2_BCLK_IN_INV_MASK                         0x1
+#define PCM2_BCLK_IN_INV_MASK_SFT                     (0x1 << 14)
+#define PCM2_TX_LCH_RPT_SFT                           13
+#define PCM2_TX_LCH_RPT_MASK                          0x1
+#define PCM2_TX_LCH_RPT_MASK_SFT                      (0x1 << 13)
+#define PCM2_VBT_16K_MODE_SFT                         12
+#define PCM2_VBT_16K_MODE_MASK                        0x1
+#define PCM2_VBT_16K_MODE_MASK_SFT                    (0x1 << 12)
+#define PCM2_LOOPBACK_CH_SEL_SFT                      10
+#define PCM2_LOOPBACK_CH_SEL_MASK                     0x3
+#define PCM2_LOOPBACK_CH_SEL_MASK_SFT                 (0x3 << 10)
+#define PCM2_TX2_BT_MODE_SFT                          8
+#define PCM2_TX2_BT_MODE_MASK                         0x1
+#define PCM2_TX2_BT_MODE_MASK_SFT                     (0x1 << 8)
+#define PCM2_BT_MODE_SFT                              7
+#define PCM2_BT_MODE_MASK                             0x1
+#define PCM2_BT_MODE_MASK_SFT                         (0x1 << 7)
+#define PCM2_AFIFO_SFT                                6
+#define PCM2_AFIFO_MASK                               0x1
+#define PCM2_AFIFO_MASK_SFT                           (0x1 << 6)
+#define PCM2_WLEN_SFT                                 5
+#define PCM2_WLEN_MASK                                0x1
+#define PCM2_WLEN_MASK_SFT                            (0x1 << 5)
+#define PCM2_MODE_SFT                                 3
+#define PCM2_MODE_MASK                                0x3
+#define PCM2_MODE_MASK_SFT                            (0x3 << 3)
+#define PCM2_FMT_SFT                                  1
+#define PCM2_FMT_MASK                                 0x3
+#define PCM2_FMT_MASK_SFT                             (0x3 << 1)
+#define PCM2_EN_SFT                                   0
+#define PCM2_EN_MASK                                  0x1
+#define PCM2_EN_MASK_SFT                              (0x1 << 0)
+
+/* AFE_ADDA_MTKAIF_CFG0 */
+#define MTKAIF_RXIF_CLKINV_ADC_SFT                    31
+#define MTKAIF_RXIF_CLKINV_ADC_MASK                   0x1
+#define MTKAIF_RXIF_CLKINV_ADC_MASK_SFT               (0x1 << 31)
+#define MTKAIF_RXIF_BYPASS_SRC_SFT                    17
+#define MTKAIF_RXIF_BYPASS_SRC_MASK                   0x1
+#define MTKAIF_RXIF_BYPASS_SRC_MASK_SFT               (0x1 << 17)
+#define MTKAIF_RXIF_PROTOCOL2_SFT                     16
+#define MTKAIF_RXIF_PROTOCOL2_MASK                    0x1
+#define MTKAIF_RXIF_PROTOCOL2_MASK_SFT                (0x1 << 16)
+#define MTKAIF_TXIF_BYPASS_SRC_SFT                    5
+#define MTKAIF_TXIF_BYPASS_SRC_MASK                   0x1
+#define MTKAIF_TXIF_BYPASS_SRC_MASK_SFT               (0x1 << 5)
+#define MTKAIF_TXIF_PROTOCOL2_SFT                     4
+#define MTKAIF_TXIF_PROTOCOL2_MASK                    0x1
+#define MTKAIF_TXIF_PROTOCOL2_MASK_SFT                (0x1 << 4)
+#define MTKAIF_TXIF_8TO5_SFT                          2
+#define MTKAIF_TXIF_8TO5_MASK                         0x1
+#define MTKAIF_TXIF_8TO5_MASK_SFT                     (0x1 << 2)
+#define MTKAIF_RXIF_8TO5_SFT                          1
+#define MTKAIF_RXIF_8TO5_MASK                         0x1
+#define MTKAIF_RXIF_8TO5_MASK_SFT                     (0x1 << 1)
+#define MTKAIF_IF_LOOPBACK1_SFT                       0
+#define MTKAIF_IF_LOOPBACK1_MASK                      0x1
+#define MTKAIF_IF_LOOPBACK1_MASK_SFT                  (0x1 << 0)
+
+/* AFE_ADDA_MTKAIF_RX_CFG2 */
+#define MTKAIF_RXIF_DETECT_ON_PROTOCOL2_SFT           16
+#define MTKAIF_RXIF_DETECT_ON_PROTOCOL2_MASK          0x1
+#define MTKAIF_RXIF_DETECT_ON_PROTOCOL2_MASK_SFT      (0x1 << 16)
+#define MTKAIF_RXIF_DELAY_CYCLE_SFT                   12
+#define MTKAIF_RXIF_DELAY_CYCLE_MASK                  0xf
+#define MTKAIF_RXIF_DELAY_CYCLE_MASK_SFT              (0xf << 12)
+#define MTKAIF_RXIF_DELAY_DATA_SFT                    8
+#define MTKAIF_RXIF_DELAY_DATA_MASK                   0x1
+#define MTKAIF_RXIF_DELAY_DATA_MASK_SFT               (0x1 << 8)
+#define MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_SFT            4
+#define MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_MASK           0x7
+#define MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_MASK_SFT       (0x7 << 4)
+
+/* AFE_ADDA_DL_SRC2_CON0 */
+#define DL_2_INPUT_MODE_CTL_SFT                       28
+#define DL_2_INPUT_MODE_CTL_MASK                      0xf
+#define DL_2_INPUT_MODE_CTL_MASK_SFT                  (0xf << 28)
+#define DL_2_CH1_SATURATION_EN_CTL_SFT                27
+#define DL_2_CH1_SATURATION_EN_CTL_MASK               0x1
+#define DL_2_CH1_SATURATION_EN_CTL_MASK_SFT           (0x1 << 27)
+#define DL_2_CH2_SATURATION_EN_CTL_SFT                26
+#define DL_2_CH2_SATURATION_EN_CTL_MASK               0x1
+#define DL_2_CH2_SATURATION_EN_CTL_MASK_SFT           (0x1 << 26)
+#define DL_2_OUTPUT_SEL_CTL_SFT                       24
+#define DL_2_OUTPUT_SEL_CTL_MASK                      0x3
+#define DL_2_OUTPUT_SEL_CTL_MASK_SFT                  (0x3 << 24)
+#define DL_2_FADEIN_0START_EN_SFT                     16
+#define DL_2_FADEIN_0START_EN_MASK                    0x3
+#define DL_2_FADEIN_0START_EN_MASK_SFT                (0x3 << 16)
+#define DL_DISABLE_HW_CG_CTL_SFT                      15
+#define DL_DISABLE_HW_CG_CTL_MASK                     0x1
+#define DL_DISABLE_HW_CG_CTL_MASK_SFT                 (0x1 << 15)
+#define C_DATA_EN_SEL_CTL_PRE_SFT                     14
+#define C_DATA_EN_SEL_CTL_PRE_MASK                    0x1
+#define C_DATA_EN_SEL_CTL_PRE_MASK_SFT                (0x1 << 14)
+#define DL_2_SIDE_TONE_ON_CTL_PRE_SFT                 13
+#define DL_2_SIDE_TONE_ON_CTL_PRE_MASK                0x1
+#define DL_2_SIDE_TONE_ON_CTL_PRE_MASK_SFT            (0x1 << 13)
+#define DL_2_MUTE_CH1_OFF_CTL_PRE_SFT                 12
+#define DL_2_MUTE_CH1_OFF_CTL_PRE_MASK                0x1
+#define DL_2_MUTE_CH1_OFF_CTL_PRE_MASK_SFT            (0x1 << 12)
+#define DL_2_MUTE_CH2_OFF_CTL_PRE_SFT                 11
+#define DL_2_MUTE_CH2_OFF_CTL_PRE_MASK                0x1
+#define DL_2_MUTE_CH2_OFF_CTL_PRE_MASK_SFT            (0x1 << 11)
+#define DL2_ARAMPSP_CTL_PRE_SFT                       9
+#define DL2_ARAMPSP_CTL_PRE_MASK                      0x3
+#define DL2_ARAMPSP_CTL_PRE_MASK_SFT                  (0x3 << 9)
+#define DL_2_IIRMODE_CTL_PRE_SFT                      6
+#define DL_2_IIRMODE_CTL_PRE_MASK                     0x7
+#define DL_2_IIRMODE_CTL_PRE_MASK_SFT                 (0x7 << 6)
+#define DL_2_VOICE_MODE_CTL_PRE_SFT                   5
+#define DL_2_VOICE_MODE_CTL_PRE_MASK                  0x1
+#define DL_2_VOICE_MODE_CTL_PRE_MASK_SFT              (0x1 << 5)
+#define D2_2_MUTE_CH1_ON_CTL_PRE_SFT                  4
+#define D2_2_MUTE_CH1_ON_CTL_PRE_MASK                 0x1
+#define D2_2_MUTE_CH1_ON_CTL_PRE_MASK_SFT             (0x1 << 4)
+#define D2_2_MUTE_CH2_ON_CTL_PRE_SFT                  3
+#define D2_2_MUTE_CH2_ON_CTL_PRE_MASK                 0x1
+#define D2_2_MUTE_CH2_ON_CTL_PRE_MASK_SFT             (0x1 << 3)
+#define DL_2_IIR_ON_CTL_PRE_SFT                       2
+#define DL_2_IIR_ON_CTL_PRE_MASK                      0x1
+#define DL_2_IIR_ON_CTL_PRE_MASK_SFT                  (0x1 << 2)
+#define DL_2_GAIN_ON_CTL_PRE_SFT                      1
+#define DL_2_GAIN_ON_CTL_PRE_MASK                     0x1
+#define DL_2_GAIN_ON_CTL_PRE_MASK_SFT                 (0x1 << 1)
+#define DL_2_SRC_ON_TMP_CTL_PRE_SFT                   0
+#define DL_2_SRC_ON_TMP_CTL_PRE_MASK                  0x1
+#define DL_2_SRC_ON_TMP_CTL_PRE_MASK_SFT              (0x1 << 0)
+
+/* AFE_ADDA_DL_SRC2_CON1 */
+#define DL_2_GAIN_CTL_PRE_SFT                         16
+#define DL_2_GAIN_CTL_PRE_MASK                        0xffff
+#define DL_2_GAIN_CTL_PRE_MASK_SFT                    (0xffff << 16)
+#define DL_2_GAIN_MODE_CTL_SFT                        0
+#define DL_2_GAIN_MODE_CTL_MASK                       0x1
+#define DL_2_GAIN_MODE_CTL_MASK_SFT                   (0x1 << 0)
+
+/* AFE_ADDA_UL_SRC_CON0 */
+#define ULCF_CFG_EN_CTL_SFT                           31
+#define ULCF_CFG_EN_CTL_MASK                          0x1
+#define ULCF_CFG_EN_CTL_MASK_SFT                      (0x1 << 31)
+#define UL_MODE_3P25M_CH2_CTL_SFT                     22
+#define UL_MODE_3P25M_CH2_CTL_MASK                    0x1
+#define UL_MODE_3P25M_CH2_CTL_MASK_SFT                (0x1 << 22)
+#define UL_MODE_3P25M_CH1_CTL_SFT                     21
+#define UL_MODE_3P25M_CH1_CTL_MASK                    0x1
+#define UL_MODE_3P25M_CH1_CTL_MASK_SFT                (0x1 << 21)
+#define UL_VOICE_MODE_CH1_CH2_CTL_SFT                 17
+#define UL_VOICE_MODE_CH1_CH2_CTL_MASK                0x7
+#define UL_VOICE_MODE_CH1_CH2_CTL_MASK_SFT            (0x7 << 17)
+#define DMIC_LOW_POWER_MODE_CTL_SFT                   14
+#define DMIC_LOW_POWER_MODE_CTL_MASK                  0x3
+#define DMIC_LOW_POWER_MODE_CTL_MASK_SFT              (0x3 << 14)
+#define UL_DISABLE_HW_CG_CTL_SFT                      12
+#define UL_DISABLE_HW_CG_CTL_MASK                     0x1
+#define UL_DISABLE_HW_CG_CTL_MASK_SFT                 (0x1 << 12)
+#define UL_IIR_ON_TMP_CTL_SFT                         10
+#define UL_IIR_ON_TMP_CTL_MASK                        0x1
+#define UL_IIR_ON_TMP_CTL_MASK_SFT                    (0x1 << 10)
+#define UL_IIRMODE_CTL_SFT                            7
+#define UL_IIRMODE_CTL_MASK                           0x7
+#define UL_IIRMODE_CTL_MASK_SFT                       (0x7 << 7)
+#define DIGMIC_3P25M_1P625M_SEL_CTL_SFT               5
+#define DIGMIC_3P25M_1P625M_SEL_CTL_MASK              0x1
+#define DIGMIC_3P25M_1P625M_SEL_CTL_MASK_SFT          (0x1 << 5)
+#define UL_LOOP_BACK_MODE_CTL_SFT                     2
+#define UL_LOOP_BACK_MODE_CTL_MASK                    0x1
+#define UL_LOOP_BACK_MODE_CTL_MASK_SFT                (0x1 << 2)
+#define UL_SDM_3_LEVEL_CTL_SFT                        1
+#define UL_SDM_3_LEVEL_CTL_MASK                       0x1
+#define UL_SDM_3_LEVEL_CTL_MASK_SFT                   (0x1 << 1)
+#define UL_SRC_ON_TMP_CTL_SFT                         0
+#define UL_SRC_ON_TMP_CTL_MASK                        0x1
+#define UL_SRC_ON_TMP_CTL_MASK_SFT                    (0x1 << 0)
+
+/* AFE_ADDA_UL_SRC_CON1 */
+#define C_DAC_EN_CTL_SFT                              27
+#define C_DAC_EN_CTL_MASK                             0x1
+#define C_DAC_EN_CTL_MASK_SFT                         (0x1 << 27)
+#define C_MUTE_SW_CTL_SFT                             26
+#define C_MUTE_SW_CTL_MASK                            0x1
+#define C_MUTE_SW_CTL_MASK_SFT                        (0x1 << 26)
+#define ASDM_SRC_SEL_CTL_SFT                          25
+#define ASDM_SRC_SEL_CTL_MASK                         0x1
+#define ASDM_SRC_SEL_CTL_MASK_SFT                     (0x1 << 25)
+#define C_AMP_DIV_CH2_CTL_SFT                         21
+#define C_AMP_DIV_CH2_CTL_MASK                        0x7
+#define C_AMP_DIV_CH2_CTL_MASK_SFT                    (0x7 << 21)
+#define C_FREQ_DIV_CH2_CTL_SFT                        16
+#define C_FREQ_DIV_CH2_CTL_MASK                       0x1f
+#define C_FREQ_DIV_CH2_CTL_MASK_SFT                   (0x1f << 16)
+#define C_SINE_MODE_CH2_CTL_SFT                       12
+#define C_SINE_MODE_CH2_CTL_MASK                      0xf
+#define C_SINE_MODE_CH2_CTL_MASK_SFT                  (0xf << 12)
+#define C_AMP_DIV_CH1_CTL_SFT                         9
+#define C_AMP_DIV_CH1_CTL_MASK                        0x7
+#define C_AMP_DIV_CH1_CTL_MASK_SFT                    (0x7 << 9)
+#define C_FREQ_DIV_CH1_CTL_SFT                        4
+#define C_FREQ_DIV_CH1_CTL_MASK                       0x1f
+#define C_FREQ_DIV_CH1_CTL_MASK_SFT                   (0x1f << 4)
+#define C_SINE_MODE_CH1_CTL_SFT                       0
+#define C_SINE_MODE_CH1_CTL_MASK                      0xf
+#define C_SINE_MODE_CH1_CTL_MASK_SFT                  (0xf << 0)
+
+/* AFE_ADDA_TOP_CON0 */
+#define C_LOOP_BACK_MODE_CTL_SFT                      12
+#define C_LOOP_BACK_MODE_CTL_MASK                     0xf
+#define C_LOOP_BACK_MODE_CTL_MASK_SFT                 (0xf << 12)
+#define C_EXT_ADC_CTL_SFT                             0
+#define C_EXT_ADC_CTL_MASK                            0x1
+#define C_EXT_ADC_CTL_MASK_SFT                        (0x1 << 0)
+
+/* AFE_ADDA_UL_DL_CON0 */
+#define AFE_ADDA6_UL_LR_SWAP_SFT                      15
+#define AFE_ADDA6_UL_LR_SWAP_MASK                     0x1
+#define AFE_ADDA6_UL_LR_SWAP_MASK_SFT                 (0x1 << 15)
+#define AFE_ADDA6_CKDIV_RST_SFT                       14
+#define AFE_ADDA6_CKDIV_RST_MASK                      0x1
+#define AFE_ADDA6_CKDIV_RST_MASK_SFT                  (0x1 << 14)
+#define AFE_ADDA6_FIFO_AUTO_RST_SFT                   13
+#define AFE_ADDA6_FIFO_AUTO_RST_MASK                  0x1
+#define AFE_ADDA6_FIFO_AUTO_RST_MASK_SFT              (0x1 << 13)
+#define UL_FIFO_DIGMIC_TESTIN_SFT                     5
+#define UL_FIFO_DIGMIC_TESTIN_MASK                    0x3
+#define UL_FIFO_DIGMIC_TESTIN_MASK_SFT                (0x3 << 5)
+#define UL_FIFO_DIGMIC_WDATA_TESTEN_SFT               4
+#define UL_FIFO_DIGMIC_WDATA_TESTEN_MASK              0x1
+#define UL_FIFO_DIGMIC_WDATA_TESTEN_MASK_SFT          (0x1 << 4)
+#define ADDA_AFE_ON_SFT                               0
+#define ADDA_AFE_ON_MASK                              0x1
+#define ADDA_AFE_ON_MASK_SFT                          (0x1 << 0)
+
+/* AFE_SIDETONE_CON0 */
+#define R_RDY_SFT                                     30
+#define R_RDY_MASK                                    0x1
+#define R_RDY_MASK_SFT                                (0x1 << 30)
+#define W_RDY_SFT                                     29
+#define W_RDY_MASK                                    0x1
+#define W_RDY_MASK_SFT                                (0x1 << 29)
+#define R_W_EN_SFT                                    25
+#define R_W_EN_MASK                                   0x1
+#define R_W_EN_MASK_SFT                               (0x1 << 25)
+#define R_W_SEL_SFT                                   24
+#define R_W_SEL_MASK                                  0x1
+#define R_W_SEL_MASK_SFT                              (0x1 << 24)
+#define SEL_CH2_SFT                                   23
+#define SEL_CH2_MASK                                  0x1
+#define SEL_CH2_MASK_SFT                              (0x1 << 23)
+#define SIDE_TONE_COEFFICIENT_ADDR_SFT                16
+#define SIDE_TONE_COEFFICIENT_ADDR_MASK               0x1f
+#define SIDE_TONE_COEFFICIENT_ADDR_MASK_SFT           (0x1f << 16)
+#define SIDE_TONE_COEFFICIENT_SFT                     0
+#define SIDE_TONE_COEFFICIENT_MASK                    0xffff
+#define SIDE_TONE_COEFFICIENT_MASK_SFT                (0xffff << 0)
+
+/* AFE_SIDETONE_COEFF */
+#define SIDE_TONE_COEFF_SFT                           0
+#define SIDE_TONE_COEFF_MASK                          0xffff
+#define SIDE_TONE_COEFF_MASK_SFT                      (0xffff << 0)
+
+/* AFE_SIDETONE_CON1 */
+#define STF_BYPASS_MODE_SFT                           31
+#define STF_BYPASS_MODE_MASK                          0x1
+#define STF_BYPASS_MODE_MASK_SFT                      (0x1 << 31)
+#define STF_BYPASS_MODE_O28_O29_SFT                   30
+#define STF_BYPASS_MODE_O28_O29_MASK                  0x1
+#define STF_BYPASS_MODE_O28_O29_MASK_SFT              (0x1 << 30)
+#define STF_BYPASS_MODE_I2S4_SFT                      29
+#define STF_BYPASS_MODE_I2S4_MASK                     0x1
+#define STF_BYPASS_MODE_I2S4_MASK_SFT                 (0x1 << 29)
+#define STF_BYPASS_MODE_I2S5_SFT                      28
+#define STF_BYPASS_MODE_I2S5_MASK                     0x1
+#define STF_BYPASS_MODE_I2S5_MASK_SFT                 (0x1 << 28)
+#define STF_INPUT_EN_SEL_SFT                          13
+#define STF_INPUT_EN_SEL_MASK                         0x1
+#define STF_INPUT_EN_SEL_MASK_SFT                     (0x1 << 13)
+#define STF_SOURCE_FROM_O19O20_SFT                    12
+#define STF_SOURCE_FROM_O19O20_MASK                   0x1
+#define STF_SOURCE_FROM_O19O20_MASK_SFT               (0x1 << 12)
+#define SIDE_TONE_ON_SFT                              8
+#define SIDE_TONE_ON_MASK                             0x1
+#define SIDE_TONE_ON_MASK_SFT                         (0x1 << 8)
+#define SIDE_TONE_HALF_TAP_NUM_SFT                    0
+#define SIDE_TONE_HALF_TAP_NUM_MASK                   0x3f
+#define SIDE_TONE_HALF_TAP_NUM_MASK_SFT               (0x3f << 0)
+
+/* AFE_SIDETONE_GAIN */
+#define POSITIVE_GAIN_SFT                             16
+#define POSITIVE_GAIN_MASK                            0x7
+#define POSITIVE_GAIN_MASK_SFT                        (0x7 << 16)
+#define SIDE_TONE_GAIN_SFT                            0
+#define SIDE_TONE_GAIN_MASK                           0xffff
+#define SIDE_TONE_GAIN_MASK_SFT                       (0xffff << 0)
+
+/* AFE_ADDA_DL_SDM_DCCOMP_CON */
+#define AUD_DC_COMP_EN_SFT                            8
+#define AUD_DC_COMP_EN_MASK                           0x1
+#define AUD_DC_COMP_EN_MASK_SFT                       (0x1 << 8)
+#define ATTGAIN_CTL_SFT                               0
+#define ATTGAIN_CTL_MASK                              0x3f
+#define ATTGAIN_CTL_MASK_SFT                          (0x3f << 0)
+
+/* AFE_SINEGEN_CON0 */
+#define DAC_EN_SFT                                    26
+#define DAC_EN_MASK                                   0x1
+#define DAC_EN_MASK_SFT                               (0x1 << 26)
+#define MUTE_SW_CH2_SFT                               25
+#define MUTE_SW_CH2_MASK                              0x1
+#define MUTE_SW_CH2_MASK_SFT                          (0x1 << 25)
+#define MUTE_SW_CH1_SFT                               24
+#define MUTE_SW_CH1_MASK                              0x1
+#define MUTE_SW_CH1_MASK_SFT                          (0x1 << 24)
+#define SINE_MODE_CH2_SFT                             20
+#define SINE_MODE_CH2_MASK                            0xf
+#define SINE_MODE_CH2_MASK_SFT                        (0xf << 20)
+#define AMP_DIV_CH2_SFT                               17
+#define AMP_DIV_CH2_MASK                              0x7
+#define AMP_DIV_CH2_MASK_SFT                          (0x7 << 17)
+#define FREQ_DIV_CH2_SFT                              12
+#define FREQ_DIV_CH2_MASK                             0x1f
+#define FREQ_DIV_CH2_MASK_SFT                         (0x1f << 12)
+#define SINE_MODE_CH1_SFT                             8
+#define SINE_MODE_CH1_MASK                            0xf
+#define SINE_MODE_CH1_MASK_SFT                        (0xf << 8)
+#define AMP_DIV_CH1_SFT                               5
+#define AMP_DIV_CH1_MASK                              0x7
+#define AMP_DIV_CH1_MASK_SFT                          (0x7 << 5)
+#define FREQ_DIV_CH1_SFT                              0
+#define FREQ_DIV_CH1_MASK                             0x1f
+#define FREQ_DIV_CH1_MASK_SFT                         (0x1f << 0)
+
+/* AFE_SINEGEN_CON2 */
+#define INNER_LOOP_BACK_MODE_SFT                      0
+#define INNER_LOOP_BACK_MODE_MASK                     0x3f
+#define INNER_LOOP_BACK_MODE_MASK_SFT                 (0x3f << 0)
+
+/* AFE_MEMIF_MINLEN */
+#define HDMI_MINLEN_SFT                               24
+#define HDMI_MINLEN_MASK                              0xf
+#define HDMI_MINLEN_MASK_SFT                          (0xf << 24)
+#define DL3_MINLEN_SFT                                12
+#define DL3_MINLEN_MASK                               0xf
+#define DL3_MINLEN_MASK_SFT                           (0xf << 12)
+#define DL2_MINLEN_SFT                                8
+#define DL2_MINLEN_MASK                               0xf
+#define DL2_MINLEN_MASK_SFT                           (0xf << 8)
+#define DL1_DATA2_MINLEN_SFT                          4
+#define DL1_DATA2_MINLEN_MASK                         0xf
+#define DL1_DATA2_MINLEN_MASK_SFT                     (0xf << 4)
+#define DL1_MINLEN_SFT                                0
+#define DL1_MINLEN_MASK                               0xf
+#define DL1_MINLEN_MASK_SFT                           (0xf << 0)
+
+/* AFE_MEMIF_MAXLEN */
+#define HDMI_MAXLEN_SFT                               24
+#define HDMI_MAXLEN_MASK                              0xf
+#define HDMI_MAXLEN_MASK_SFT                          (0xf << 24)
+#define DL3_MAXLEN_SFT                                8
+#define DL3_MAXLEN_MASK                               0xf
+#define DL3_MAXLEN_MASK_SFT                           (0xf << 8)
+#define DL2_MAXLEN_SFT                                4
+#define DL2_MAXLEN_MASK                               0xf
+#define DL2_MAXLEN_MASK_SFT                           (0xf << 4)
+#define DL1_MAXLEN_SFT                                0
+#define DL1_MAXLEN_MASK                               0x3
+#define DL1_MAXLEN_MASK_SFT                           (0x3 << 0)
+
+/* AFE_MEMIF_PBUF_SIZE */
+#define VUL12_4CH_SFT                                 17
+#define VUL12_4CH_MASK                                0x1
+#define VUL12_4CH_MASK_SFT                            (0x1 << 17)
+#define DL3_PBUF_SIZE_SFT                             10
+#define DL3_PBUF_SIZE_MASK                            0x3
+#define DL3_PBUF_SIZE_MASK_SFT                        (0x3 << 10)
+#define HDMI_PBUF_SIZE_SFT                            4
+#define HDMI_PBUF_SIZE_MASK                           0x3
+#define HDMI_PBUF_SIZE_MASK_SFT                       (0x3 << 4)
+#define DL2_PBUF_SIZE_SFT                             2
+#define DL2_PBUF_SIZE_MASK                            0x3
+#define DL2_PBUF_SIZE_MASK_SFT                        (0x3 << 2)
+#define DL1_PBUF_SIZE_SFT                             0
+#define DL1_PBUF_SIZE_MASK                            0x3
+#define DL1_PBUF_SIZE_MASK_SFT                        (0x3 << 0)
+
+/* AFE_HD_ENGEN_ENABLE */
+#define AFE_24M_ON_SFT                                1
+#define AFE_24M_ON_MASK                               0x1
+#define AFE_24M_ON_MASK_SFT                           (0x1 << 1)
+#define AFE_22M_ON_SFT                                0
+#define AFE_22M_ON_MASK                               0x1
+#define AFE_22M_ON_MASK_SFT                           (0x1 << 0)
+
+/* AFE_IRQ_MCU_CON0 */
+#define IRQ12_MCU_ON_SFT                              12
+#define IRQ12_MCU_ON_MASK                             0x1
+#define IRQ12_MCU_ON_MASK_SFT                         (0x1 << 12)
+#define IRQ11_MCU_ON_SFT                              11
+#define IRQ11_MCU_ON_MASK                             0x1
+#define IRQ11_MCU_ON_MASK_SFT                         (0x1 << 11)
+#define IRQ10_MCU_ON_SFT                              10
+#define IRQ10_MCU_ON_MASK                             0x1
+#define IRQ10_MCU_ON_MASK_SFT                         (0x1 << 10)
+#define IRQ9_MCU_ON_SFT                               9
+#define IRQ9_MCU_ON_MASK                              0x1
+#define IRQ9_MCU_ON_MASK_SFT                          (0x1 << 9)
+#define IRQ8_MCU_ON_SFT                               8
+#define IRQ8_MCU_ON_MASK                              0x1
+#define IRQ8_MCU_ON_MASK_SFT                          (0x1 << 8)
+#define IRQ7_MCU_ON_SFT                               7
+#define IRQ7_MCU_ON_MASK                              0x1
+#define IRQ7_MCU_ON_MASK_SFT                          (0x1 << 7)
+#define IRQ6_MCU_ON_SFT                               6
+#define IRQ6_MCU_ON_MASK                              0x1
+#define IRQ6_MCU_ON_MASK_SFT                          (0x1 << 6)
+#define IRQ5_MCU_ON_SFT                               5
+#define IRQ5_MCU_ON_MASK                              0x1
+#define IRQ5_MCU_ON_MASK_SFT                          (0x1 << 5)
+#define IRQ4_MCU_ON_SFT                               4
+#define IRQ4_MCU_ON_MASK                              0x1
+#define IRQ4_MCU_ON_MASK_SFT                          (0x1 << 4)
+#define IRQ3_MCU_ON_SFT                               3
+#define IRQ3_MCU_ON_MASK                              0x1
+#define IRQ3_MCU_ON_MASK_SFT                          (0x1 << 3)
+#define IRQ2_MCU_ON_SFT                               2
+#define IRQ2_MCU_ON_MASK                              0x1
+#define IRQ2_MCU_ON_MASK_SFT                          (0x1 << 2)
+#define IRQ1_MCU_ON_SFT                               1
+#define IRQ1_MCU_ON_MASK                              0x1
+#define IRQ1_MCU_ON_MASK_SFT                          (0x1 << 1)
+#define IRQ0_MCU_ON_SFT                               0
+#define IRQ0_MCU_ON_MASK                              0x1
+#define IRQ0_MCU_ON_MASK_SFT                          (0x1 << 0)
+
+/* AFE_IRQ_MCU_CON1 */
+#define IRQ7_MCU_MODE_SFT                             28
+#define IRQ7_MCU_MODE_MASK                            0xf
+#define IRQ7_MCU_MODE_MASK_SFT                        (0xf << 28)
+#define IRQ6_MCU_MODE_SFT                             24
+#define IRQ6_MCU_MODE_MASK                            0xf
+#define IRQ6_MCU_MODE_MASK_SFT                        (0xf << 24)
+#define IRQ5_MCU_MODE_SFT                             20
+#define IRQ5_MCU_MODE_MASK                            0xf
+#define IRQ5_MCU_MODE_MASK_SFT                        (0xf << 20)
+#define IRQ4_MCU_MODE_SFT                             16
+#define IRQ4_MCU_MODE_MASK                            0xf
+#define IRQ4_MCU_MODE_MASK_SFT                        (0xf << 16)
+#define IRQ3_MCU_MODE_SFT                             12
+#define IRQ3_MCU_MODE_MASK                            0xf
+#define IRQ3_MCU_MODE_MASK_SFT                        (0xf << 12)
+#define IRQ2_MCU_MODE_SFT                             8
+#define IRQ2_MCU_MODE_MASK                            0xf
+#define IRQ2_MCU_MODE_MASK_SFT                        (0xf << 8)
+#define IRQ1_MCU_MODE_SFT                             4
+#define IRQ1_MCU_MODE_MASK                            0xf
+#define IRQ1_MCU_MODE_MASK_SFT                        (0xf << 4)
+#define IRQ0_MCU_MODE_SFT                             0
+#define IRQ0_MCU_MODE_MASK                            0xf
+#define IRQ0_MCU_MODE_MASK_SFT                        (0xf << 0)
+
+/* AFE_IRQ_MCU_CON2 */
+#define IRQ12_MCU_MODE_SFT                            4
+#define IRQ12_MCU_MODE_MASK                           0xf
+#define IRQ12_MCU_MODE_MASK_SFT                       (0xf << 4)
+#define IRQ11_MCU_MODE_SFT                            0
+#define IRQ11_MCU_MODE_MASK                           0xf
+#define IRQ11_MCU_MODE_MASK_SFT                       (0xf << 0)
+
+/* AFE_IRQ_MCU_CLR */
+#define IRQ12_MCU_MISS_CNT_CLR_SFT                    28
+#define IRQ12_MCU_MISS_CNT_CLR_MASK                   0x1
+#define IRQ12_MCU_MISS_CNT_CLR_MASK_SFT               (0x1 << 28)
+#define IRQ11_MCU_MISS_CNT_CLR_SFT                    27
+#define IRQ11_MCU_MISS_CNT_CLR_MASK                   0x1
+#define IRQ11_MCU_MISS_CNT_CLR_MASK_SFT               (0x1 << 27)
+#define IRQ10_MCU_MISS_CLR_SFT                        26
+#define IRQ10_MCU_MISS_CLR_MASK                       0x1
+#define IRQ10_MCU_MISS_CLR_MASK_SFT                   (0x1 << 26)
+#define IRQ9_MCU_MISS_CLR_SFT                         25
+#define IRQ9_MCU_MISS_CLR_MASK                        0x1
+#define IRQ9_MCU_MISS_CLR_MASK_SFT                    (0x1 << 25)
+#define IRQ8_MCU_MISS_CLR_SFT                         24
+#define IRQ8_MCU_MISS_CLR_MASK                        0x1
+#define IRQ8_MCU_MISS_CLR_MASK_SFT                    (0x1 << 24)
+#define IRQ7_MCU_MISS_CLR_SFT                         23
+#define IRQ7_MCU_MISS_CLR_MASK                        0x1
+#define IRQ7_MCU_MISS_CLR_MASK_SFT                    (0x1 << 23)
+#define IRQ6_MCU_MISS_CLR_SFT                         22
+#define IRQ6_MCU_MISS_CLR_MASK                        0x1
+#define IRQ6_MCU_MISS_CLR_MASK_SFT                    (0x1 << 22)
+#define IRQ5_MCU_MISS_CLR_SFT                         21
+#define IRQ5_MCU_MISS_CLR_MASK                        0x1
+#define IRQ5_MCU_MISS_CLR_MASK_SFT                    (0x1 << 21)
+#define IRQ4_MCU_MISS_CLR_SFT                         20
+#define IRQ4_MCU_MISS_CLR_MASK                        0x1
+#define IRQ4_MCU_MISS_CLR_MASK_SFT                    (0x1 << 20)
+#define IRQ3_MCU_MISS_CLR_SFT                         19
+#define IRQ3_MCU_MISS_CLR_MASK                        0x1
+#define IRQ3_MCU_MISS_CLR_MASK_SFT                    (0x1 << 19)
+#define IRQ2_MCU_MISS_CLR_SFT                         18
+#define IRQ2_MCU_MISS_CLR_MASK                        0x1
+#define IRQ2_MCU_MISS_CLR_MASK_SFT                    (0x1 << 18)
+#define IRQ1_MCU_MISS_CLR_SFT                         17
+#define IRQ1_MCU_MISS_CLR_MASK                        0x1
+#define IRQ1_MCU_MISS_CLR_MASK_SFT                    (0x1 << 17)
+#define IRQ0_MCU_MISS_CLR_SFT                         16
+#define IRQ0_MCU_MISS_CLR_MASK                        0x1
+#define IRQ0_MCU_MISS_CLR_MASK_SFT                    (0x1 << 16)
+#define IRQ12_MCU_CLR_SFT                             12
+#define IRQ12_MCU_CLR_MASK                            0x1
+#define IRQ12_MCU_CLR_MASK_SFT                        (0x1 << 12)
+#define IRQ11_MCU_CLR_SFT                             11
+#define IRQ11_MCU_CLR_MASK                            0x1
+#define IRQ11_MCU_CLR_MASK_SFT                        (0x1 << 11)
+#define IRQ10_MCU_CLR_SFT                             10
+#define IRQ10_MCU_CLR_MASK                            0x1
+#define IRQ10_MCU_CLR_MASK_SFT                        (0x1 << 10)
+#define IRQ9_MCU_CLR_SFT                              9
+#define IRQ9_MCU_CLR_MASK                             0x1
+#define IRQ9_MCU_CLR_MASK_SFT                         (0x1 << 9)
+#define IRQ8_MCU_CLR_SFT                              8
+#define IRQ8_MCU_CLR_MASK                             0x1
+#define IRQ8_MCU_CLR_MASK_SFT                         (0x1 << 8)
+#define IRQ7_MCU_CLR_SFT                              7
+#define IRQ7_MCU_CLR_MASK                             0x1
+#define IRQ7_MCU_CLR_MASK_SFT                         (0x1 << 7)
+#define IRQ6_MCU_CLR_SFT                              6
+#define IRQ6_MCU_CLR_MASK                             0x1
+#define IRQ6_MCU_CLR_MASK_SFT                         (0x1 << 6)
+#define IRQ5_MCU_CLR_SFT                              5
+#define IRQ5_MCU_CLR_MASK                             0x1
+#define IRQ5_MCU_CLR_MASK_SFT                         (0x1 << 5)
+#define IRQ4_MCU_CLR_SFT                              4
+#define IRQ4_MCU_CLR_MASK                             0x1
+#define IRQ4_MCU_CLR_MASK_SFT                         (0x1 << 4)
+#define IRQ3_MCU_CLR_SFT                              3
+#define IRQ3_MCU_CLR_MASK                             0x1
+#define IRQ3_MCU_CLR_MASK_SFT                         (0x1 << 3)
+#define IRQ2_MCU_CLR_SFT                              2
+#define IRQ2_MCU_CLR_MASK                             0x1
+#define IRQ2_MCU_CLR_MASK_SFT                         (0x1 << 2)
+#define IRQ1_MCU_CLR_SFT                              1
+#define IRQ1_MCU_CLR_MASK                             0x1
+#define IRQ1_MCU_CLR_MASK_SFT                         (0x1 << 1)
+#define IRQ0_MCU_CLR_SFT                              0
+#define IRQ0_MCU_CLR_MASK                             0x1
+#define IRQ0_MCU_CLR_MASK_SFT                         (0x1 << 0)
+
+/* AFE_MEMIF_MSB */
+#define CPU_COMPACT_MODE_SFT                          29
+#define CPU_COMPACT_MODE_MASK                         0x1
+#define CPU_COMPACT_MODE_MASK_SFT                     (0x1 << 29)
+#define CPU_HD_ALIGN_SFT                              28
+#define CPU_HD_ALIGN_MASK                             0x1
+#define CPU_HD_ALIGN_MASK_SFT                         (0x1 << 28)
+#define AWB2_AXI_WR_SIGN_SFT                          24
+#define AWB2_AXI_WR_SIGN_MASK                         0x1
+#define AWB2_AXI_WR_SIGN_MASK_SFT                     (0x1 << 24)
+#define VUL2_AXI_WR_SIGN_SFT                          22
+#define VUL2_AXI_WR_SIGN_MASK                         0x1
+#define VUL2_AXI_WR_SIGN_MASK_SFT                     (0x1 << 22)
+#define VUL12_AXI_WR_SIGN_SFT                         21
+#define VUL12_AXI_WR_SIGN_MASK                        0x1
+#define VUL12_AXI_WR_SIGN_MASK_SFT                    (0x1 << 21)
+#define VUL_AXI_WR_SIGN_SFT                           20
+#define VUL_AXI_WR_SIGN_MASK                          0x1
+#define VUL_AXI_WR_SIGN_MASK_SFT                      (0x1 << 20)
+#define MOD_DAI_AXI_WR_SIGN_SFT                       18
+#define MOD_DAI_AXI_WR_SIGN_MASK                      0x1
+#define MOD_DAI_AXI_WR_SIGN_MASK_SFT                  (0x1 << 18)
+#define AWB_MSTR_SIGN_SFT                             17
+#define AWB_MSTR_SIGN_MASK                            0x1
+#define AWB_MSTR_SIGN_MASK_SFT                        (0x1 << 17)
+#define SYSRAM_SIGN_SFT                               16
+#define SYSRAM_SIGN_MASK                              0x1
+#define SYSRAM_SIGN_MASK_SFT                          (0x1 << 16)
+
+/* AFE_HDMI_CONN0 */
+#define HDMI_O_7_SFT                                  21
+#define HDMI_O_7_MASK                                 0x7
+#define HDMI_O_7_MASK_SFT                             (0x7 << 21)
+#define HDMI_O_6_SFT                                  18
+#define HDMI_O_6_MASK                                 0x7
+#define HDMI_O_6_MASK_SFT                             (0x7 << 18)
+#define HDMI_O_5_SFT                                  15
+#define HDMI_O_5_MASK                                 0x7
+#define HDMI_O_5_MASK_SFT                             (0x7 << 15)
+#define HDMI_O_4_SFT                                  12
+#define HDMI_O_4_MASK                                 0x7
+#define HDMI_O_4_MASK_SFT                             (0x7 << 12)
+#define HDMI_O_3_SFT                                  9
+#define HDMI_O_3_MASK                                 0x7
+#define HDMI_O_3_MASK_SFT                             (0x7 << 9)
+#define HDMI_O_2_SFT                                  6
+#define HDMI_O_2_MASK                                 0x7
+#define HDMI_O_2_MASK_SFT                             (0x7 << 6)
+#define HDMI_O_1_SFT                                  3
+#define HDMI_O_1_MASK                                 0x7
+#define HDMI_O_1_MASK_SFT                             (0x7 << 3)
+#define HDMI_O_0_SFT                                  0
+#define HDMI_O_0_MASK                                 0x7
+#define HDMI_O_0_MASK_SFT                             (0x7 << 0)
+
+/* AFE_TDM_CON1 */
+#define TDM_EN_SFT                                    0
+#define TDM_EN_MASK                                   0x1
+#define TDM_EN_MASK_SFT                               (0x1 << 0)
+#define BCK_INVERSE_SFT                               1
+#define BCK_INVERSE_MASK                              0x1
+#define BCK_INVERSE_MASK_SFT                          (0x1 << 1)
+#define LRCK_INVERSE_SFT                              2
+#define LRCK_INVERSE_MASK                             0x1
+#define LRCK_INVERSE_MASK_SFT                         (0x1 << 2)
+#define DELAY_DATA_SFT                                3
+#define DELAY_DATA_MASK                               0x1
+#define DELAY_DATA_MASK_SFT                           (0x1 << 3)
+#define LEFT_ALIGN_SFT                                4
+#define LEFT_ALIGN_MASK                               0x1
+#define LEFT_ALIGN_MASK_SFT                           (0x1 << 4)
+#define WLEN_SFT                                      8
+#define WLEN_MASK                                     0x3
+#define WLEN_MASK_SFT                                 (0x3 << 8)
+#define CHANNEL_NUM_SFT                               10
+#define CHANNEL_NUM_MASK                              0x3
+#define CHANNEL_NUM_MASK_SFT                          (0x3 << 10)
+#define CHANNEL_BCK_CYCLES_SFT                        12
+#define CHANNEL_BCK_CYCLES_MASK                       0x3
+#define CHANNEL_BCK_CYCLES_MASK_SFT                   (0x3 << 12)
+#define DAC_BIT_NUM_SFT                               16
+#define DAC_BIT_NUM_MASK                              0x1f
+#define DAC_BIT_NUM_MASK_SFT                          (0x1f << 16)
+#define LRCK_TDM_WIDTH_SFT                            24
+#define LRCK_TDM_WIDTH_MASK                           0xff
+#define LRCK_TDM_WIDTH_MASK_SFT                       (0xff << 24)
+
+/* AFE_TDM_CON2 */
+#define ST_CH_PAIR_SOUT0_SFT                          0
+#define ST_CH_PAIR_SOUT0_MASK                         0x7
+#define ST_CH_PAIR_SOUT0_MASK_SFT                     (0x7 << 0)
+#define ST_CH_PAIR_SOUT1_SFT                          4
+#define ST_CH_PAIR_SOUT1_MASK                         0x7
+#define ST_CH_PAIR_SOUT1_MASK_SFT                     (0x7 << 4)
+#define ST_CH_PAIR_SOUT2_SFT                          8
+#define ST_CH_PAIR_SOUT2_MASK                         0x7
+#define ST_CH_PAIR_SOUT2_MASK_SFT                     (0x7 << 8)
+#define ST_CH_PAIR_SOUT3_SFT                          12
+#define ST_CH_PAIR_SOUT3_MASK                         0x7
+#define ST_CH_PAIR_SOUT3_MASK_SFT                     (0x7 << 12)
+#define TDM_FIX_VALUE_SEL_SFT                         16
+#define TDM_FIX_VALUE_SEL_MASK                        0x1
+#define TDM_FIX_VALUE_SEL_MASK_SFT                    (0x1 << 16)
+#define TDM_I2S_LOOPBACK_SFT                          20
+#define TDM_I2S_LOOPBACK_MASK                         0x1
+#define TDM_I2S_LOOPBACK_MASK_SFT                     (0x1 << 20)
+#define TDM_I2S_LOOPBACK_CH_SFT                       21
+#define TDM_I2S_LOOPBACK_CH_MASK                      0x3
+#define TDM_I2S_LOOPBACK_CH_MASK_SFT                  (0x3 << 21)
+#define TDM_FIX_VALUE_SFT                             24
+#define TDM_FIX_VALUE_MASK                            0xff
+#define TDM_FIX_VALUE_MASK_SFT                        (0xff << 24)
+
+/* AFE_HDMI_OUT_CON0 */
+#define AFE_HDMI_OUT_ON_RETM_SFT                      8
+#define AFE_HDMI_OUT_ON_RETM_MASK                     0x1
+#define AFE_HDMI_OUT_ON_RETM_MASK_SFT                 (0x1 << 8)
+#define AFE_HDMI_OUT_CH_NUM_SFT                       4
+#define AFE_HDMI_OUT_CH_NUM_MASK                      0xf
+#define AFE_HDMI_OUT_CH_NUM_MASK_SFT                  (0xf << 4)
+#define AFE_HDMI_OUT_BIT_WIDTH_SFT                    1
+#define AFE_HDMI_OUT_BIT_WIDTH_MASK                   0x1
+#define AFE_HDMI_OUT_BIT_WIDTH_MASK_SFT               (0x1 << 1)
+#define AFE_HDMI_OUT_ON_SFT                           0
+#define AFE_HDMI_OUT_ON_MASK                          0x1
+#define AFE_HDMI_OUT_ON_MASK_SFT                      (0x1 << 0)
+#endif
-- 
1.9.1
