From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 1/4] ASoC: mediatek: mt8183: move private
	structure
Date: Fri, 30 Aug 2019 15:42:37 +0800
Message-ID: <20190830074240.195166-2-tzungbi@google.com>
References: <20190830074240.195166-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD31AF80376
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 09:42:53 +0200 (CEST)
Received: by mail-yw1-xc49.google.com with SMTP id a12so4513446ywm.10
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 00:42:53 -0700 (PDT)
In-Reply-To: <20190830074240.195166-1-tzungbi@google.com>
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
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Move private structure to the beginning of file to declare earlier
so that most functions can see it.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 560fcc5923a4..1d4a1600f768 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -17,6 +17,22 @@
 
 static struct snd_soc_jack headset_jack;
 
+enum PINCTRL_PIN_STATE {
+	PIN_STATE_DEFAULT = 0,
+	PIN_TDM_OUT_ON,
+	PIN_TDM_OUT_OFF,
+	PIN_STATE_MAX
+};
+
+static const char * const mt8183_pin_str[PIN_STATE_MAX] = {
+	"default", "aud_tdm_out_on", "aud_tdm_out_off",
+};
+
+struct mt8183_mt6358_ts3a227_max98357_priv {
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pin_states[PIN_STATE_MAX];
+};
+
 static int mt8183_mt6358_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
@@ -46,22 +62,6 @@ static int mt8183_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-enum PINCTRL_PIN_STATE {
-	PIN_STATE_DEFAULT = 0,
-	PIN_TDM_OUT_ON,
-	PIN_TDM_OUT_OFF,
-	PIN_STATE_MAX
-};
-
-static const char * const mt8183_pin_str[PIN_STATE_MAX] = {
-	"default", "aud_tdm_out_on", "aud_tdm_out_off",
-};
-
-struct mt8183_mt6358_ts3a227_max98357_priv {
-	struct pinctrl *pinctrl;
-	struct pinctrl_state *pin_states[PIN_STATE_MAX];
-};
-
 static int
 mt8183_mt6358_ts3a227_max98357_bt_sco_startup(
 	struct snd_pcm_substream *substream)
-- 
2.23.0.187.g17f5b7556c-goog
