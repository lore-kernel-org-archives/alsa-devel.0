From: olivier moysan <olivier.moysan@st.com>
Subject: [RFC PATCH v2 2/2] ASoC: wm8994: delay aifxclk
	activation
Date: Fri, 17 Mar 2017 16:41:51 +0100
Message-ID: <1489765311-29857-3-git-send-email-olivier.moysan@st.com>
References: <1489765311-29857-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 93A1C267211
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 16:42:00 +0100 (CET)
In-Reply-To: <1489765311-29857-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com
List-Id: alsa-devel@alsa-project.org

This patch is a draft.

The aim of this patch is to allow the following use case:
- The codec wm8994 is configured as a slave of CPU DAI
- The codec is configured before runtime
- CPU DAI provides master clock to the codec at runtime only

The wm8994 cannot be configured as long as master clock
is not provided to the codec.
aif clock, charge pump and DC servo registers are written
to the codec but are not read back at their expected values,
when the master clock is not set during configuration.
In this use case, master clock is not available before
pcm stream start.
So previous settings are failing
if there are set in SND_SOC_DAPM_PRE_PMU stage.

A way to go around this problem, is to delay aifxclk activation
until SND_SOC_DAPM_POST_PMU DAPM stage.
However delaying aif clock may have side effect on other use cases.

The purpose of this patch is to illustrate the principle of the fix
and to check if it may be applicable in all other contexts.


Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/wm8994.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ccf640a..6782d9e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1262,7 +1262,7 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_POST_PMU:
 		if (wm8994->aif1clk_enable) {
 			aif1clk_ev(w, kcontrol, SND_SOC_DAPM_PRE_PMU);
 			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
@@ -1615,6 +1615,8 @@ static SOC_ENUM_SINGLE_DECL(aif2dacr_src_enum,
 SND_SOC_DAPM_MUX_E("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpr_mux,
 		   late_enable_ev, SND_SOC_DAPM_PRE_PMU),
 
+SND_SOC_DAPM_POST("Late Enable PGA", late_enable_ev),
+
 SND_SOC_DAPM_POST("Late Disable PGA", late_disable_ev)
 };
 
-- 
1.9.1
