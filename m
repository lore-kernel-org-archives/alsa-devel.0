From: olivier moysan <olivier.moysan@st.com>
Subject: [RFC PATCH 1/2] ASoC: wm8994: default master clock
	selection
Date: Thu, 16 Mar 2017 17:41:22 +0100
Message-ID: <1489682483-13051-2-git-send-email-olivier.moysan@st.com>
References: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 98638267186
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 17:41:32 +0100 (CET)
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

This patch allows the wm8994 codec driver to be used
with simple card when mclk fs is provided in dai link.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/wm8994.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3896523..ccf640a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2389,6 +2389,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 
 	switch (clk_id) {
 	case WM8994_SYSCLK_MCLK1:
+	default:
 		wm8994->sysclk[dai->id - 1] = WM8994_SYSCLK_MCLK1;
 		wm8994->mclk[0] = freq;
 		dev_dbg(dai->dev, "AIF%d using MCLK1 at %uHz\n",
@@ -2431,9 +2432,6 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_2,
 					    WM8994_OPCLK_ENA, 0);
 		}
-
-	default:
-		return -EINVAL;
 	}
 
 	configure_clock(codec);
-- 
1.9.1
