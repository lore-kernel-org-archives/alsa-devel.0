From: olivier moysan <olivier.moysan@st.com>
Subject: [RFC PATCH 2/2] ASoC: wm8994: delay aifxclk activation
Date: Thu, 16 Mar 2017 17:41:23 +0100
Message-ID: <1489682483-13051-3-git-send-email-olivier.moysan@st.com>
References: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C772671A3
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 17:41:34 +0100 (CET)
In-Reply-To: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
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
