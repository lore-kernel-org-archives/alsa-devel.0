From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] ASoC: core: Do not print an actual error
	when deferring probe
Date: Wed, 18 May 2016 15:41:29 +0200
Message-ID: <1463578889-13709-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id AC2762604BE
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 15:41:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

In case there is no DAI (yet), do not print an error, this might happen
a lot of times. Print a notice instead.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2e62b15..352f7c6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1001,7 +1001,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
 	rtd->cpu_dai = snd_soc_find_dai(&cpu_dai_component);
 	if (!rtd->cpu_dai) {
-		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
+		dev_notice(card->dev, "ASoC: CPU DAI %s not registered\n",
 			dai_link->cpu_dai_name);
 		goto _err_defer;
 	}
@@ -1013,7 +1013,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
-			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
+			dev_notice(card->dev, "ASoC: CODEC DAI %s not registered\n",
 				codecs[i].dai_name);
 			goto _err_defer;
 		}
@@ -1042,7 +1042,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 		rtd->platform = platform;
 	}
 	if (!rtd->platform) {
-		dev_err(card->dev, "ASoC: platform %s not registered\n",
+		dev_notice(card->dev, "ASoC: platform %s not registered\n",
 			dai_link->platform_name);
 		return -EPROBE_DEFER;
 	}
-- 
2.7.3
