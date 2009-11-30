From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoc: pxa/raumfeld: adopt new
	snd_soc_dai_set_pll() API
Date: Mon, 30 Nov 2009 11:12:44 +0100
Message-ID: <1259575964-32251-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 81593103845
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 11:12:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is needed for recent changes in the for-2.6.33 branch.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/raumfeld.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 5d7bb8c..a43a16c 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -116,7 +116,7 @@ static int raumfeld_cs4270_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* setup the CPU DAI */
-	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk, clk);
 	if (ret < 0)
 		return ret;
 
@@ -205,7 +205,7 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/* setup the CPU DAI */
-	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
+	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk, clk);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.5.2
