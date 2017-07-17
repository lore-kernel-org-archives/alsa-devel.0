From: srinivas.kandagatla@linaro.org
Subject: [PATCH 1/3] ASoC: codecs: msm8916-wcd-digital: add
	support to set_sysclk
Date: Mon, 17 Jul 2017 15:54:08 +0200
Message-ID: <20170717135410.26812-2-srinivas.kandagatla@linaro.org>
References: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A0032669F3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 15:54:32 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id z62so43462465ioi.3
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 06:54:32 -0700 (PDT)
In-Reply-To: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to set_sysclk() which can let the sound
card driver to set default mclk rate. In this case MCLK for
internal audio codec is expected to be at 9.6MHz by default.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index f690442af8c9..126a0ee8aded 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -568,6 +568,16 @@ static int msm8916_wcd_digital_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int msm8916_set_dai_sysclk(struct snd_soc_dai *dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct msm8916_wcd_digital_priv *p = dev_get_drvdata(dai->codec->dev);
+
+	clk_set_rate(p->mclk, freq);
+
+	return 0;
+}
+
 static int msm8916_wcd_digital_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *params,
 					 struct snd_soc_dai *dai)
@@ -792,6 +802,7 @@ static struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
 	.startup = msm8916_wcd_digital_startup,
 	.shutdown = msm8916_wcd_digital_shutdown,
 	.hw_params = msm8916_wcd_digital_hw_params,
+	.set_sysclk = msm8916_set_dai_sysclk,
 };
 
 static struct snd_soc_dai_driver msm8916_wcd_digital_dai[] = {
-- 
2.11.0
