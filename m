From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 06/23] ASoC: tas2552: Simplify the
	tas2552_mute function
Date: Thu, 4 Jun 2015 16:04:18 +0300
Message-ID: <1433423075-14142-7-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 63346266511
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:04:56 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Initialize the cfg1_reg to 0 and set the mute bit only when it is needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 681b868a9e8c..2d52a397161d 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -254,13 +254,11 @@ static int tas2552_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 static int tas2552_mute(struct snd_soc_dai *dai, int mute)
 {
-	u8 cfg1_reg;
+	u8 cfg1_reg = 0;
 	struct snd_soc_codec *codec = dai->codec;
 
 	if (mute)
-		cfg1_reg = TAS2552_MUTE;
-	else
-		cfg1_reg = ~TAS2552_MUTE;
+		cfg1_reg |= TAS2552_MUTE;
 
 	snd_soc_update_bits(codec, TAS2552_CFG_1, TAS2552_MUTE, cfg1_reg);
 
-- 
2.4.2
