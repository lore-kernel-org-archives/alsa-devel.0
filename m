From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] sound: soc-core: make kernel complaints on
 -EPROBE_DEFER dev_dbg
Date: Wed, 9 Nov 2016 15:00:36 +0100
Message-ID: <20161109140036.GB20859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id ED277267081
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:01:04 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992544AbcKIOBEsj0k0 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Wed, 9 Nov 2016 15:01:04 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is no point having these complaints to be dev_err as
they are just adding noise to bootlog.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd9..8a6ec52 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1013,7 +1013,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
 	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
 	if (!rtd->cpu_dai) {
-		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
+		dev_dbg(card->dev, "ASoC: CPU DAI %s not registered\n",
 			dai_link->cpu_dai_name);
 		goto _err_defer;
 	}
@@ -1025,7 +1025,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
+			dev_dbg(card->dev, "ASoC: CODEC DAI %s not registered\n",
 				codecs[i].dai_name);
 			goto _err_defer;
 		}
@@ -1054,7 +1054,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 		rtd->platform = platform;
 	}
 	if (!rtd->platform) {
-		dev_err(card->dev, "ASoC: platform %s not registered\n",
+		dev_dbg(card->dev, "ASoC: platform %s not registered\n",
 			dai_link->platform_name);
 		goto _err_defer;
 	}
-- 
2.1.4
