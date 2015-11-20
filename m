From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: Update the rtd query
Date: Fri, 20 Nov 2015 22:45:20 +0530
Message-ID: <1448039720-1009-1-git-send-email-vinod.koul@intel.com>
References: <1448039081-772-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BA2E264FFF
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 18:11:38 +0100 (CET)
In-Reply-To: <1448039081-772-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

sound card rtd was an array and was updated to a list so update
the driver to use a list

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index f4b6c53146d5..c63d89da51f1 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -417,14 +417,16 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd = list_first_entry(
+			&card->rtd_list, struct snd_soc_pcm_runtime, list);
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct codec_priv *codec_priv = &priv->codec_priv;
 	struct device *dev = card->dev;
 	int ret;
 
 	if (fsl_asoc_card_is_ac97(priv)) {
 #if IS_ENABLED(CONFIG_SND_AC97_CODEC)
-		struct snd_soc_codec *codec = card->rtd[0].codec;
+		struct snd_soc_codec *codec = rtd->codec;
 		struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 
 		/*
-- 
1.9.1
