From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/5] ASoC: Fix prototype for nuc900_ac97_probe and
	nuc900_ac97_remove
Date: Mon, 29 Nov 2010 17:40:05 +0800
Message-ID: <1291023605.22911.4.camel@mola>
References: <1291023491.22911.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291023491.22911.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes below compile warning:

  CC      sound/soc/nuc900/nuc900-ac97.o
sound/soc/nuc900/nuc900-ac97.c:300: warning: initialization from incompatible pointer type
sound/soc/nuc900/nuc900-ac97.c:301: warning: initialization from incompatible pointer type

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/nuc900/nuc900-ac97.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 4f056b4..3d9d8b1 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -263,8 +263,7 @@ static int nuc900_ac97_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int nuc900_ac97_probe(struct platform_device *pdev,
-					struct snd_soc_dai *dai)
+static int nuc900_ac97_probe(struct snd_soc_dai *dai)
 {
 	struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
 	unsigned long val;
@@ -284,12 +283,12 @@ static int nuc900_ac97_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static void nuc900_ac97_remove(struct platform_device *pdev,
-						struct snd_soc_dai *dai)
+static int nuc900_ac97_remove(struct snd_soc_dai *dai)
 {
 	struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
 
 	clk_disable(nuc900_audio->clk);
+	return 0;
 }
 
 static struct snd_soc_dai_ops nuc900_ac97_dai_ops = {
-- 
1.7.2
