From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 2/2] ASoC: simple card: set cpu-dai sysclk with
	mclk-fs
Date: Fri, 5 Jun 2015 10:19:06 +0200
Message-ID: <1433492346-29506-3-git-send-email-arnaud.pouliquen@st.com>
References: <1433492346-29506-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D06526071E
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 10:19:43 +0200 (CEST)
In-Reply-To: <1433492346-29506-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Allows to request a specific mclk frequency per cpu_dai.
To support some codecs with mclk provided by the cpu_dai, the
mclk rate must be set depending on frame rate.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/generic/simple-card.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d555493..3ff76d4 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -76,6 +76,7 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
 		&priv->dai_props[rtd - rtd->card->rtd];
@@ -91,8 +92,16 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 		mclk = params_rate(params) * mclk_fs;
 		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 					     SND_SOC_CLOCK_IN);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
+
+		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+					     SND_SOC_CLOCK_OUT);
+		if (ret && ret != -ENOTSUPP)
+			goto err;
 	}
 
+err:
 	return ret;
 }
 
-- 
1.9.1
