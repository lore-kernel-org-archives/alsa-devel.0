From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: dapm: Add missing return value check for
	snd_soc_dapm_new_dai
Date: Mon, 10 Sep 2018 15:28:39 +0100
Message-ID: <20180910142839.12051-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 58A82267806
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 16:28:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_new_dai may return an error pointer and currently this
isn't checked for in dapm_connect_dai_link_widgets. Add code to check
the return value and not add routes in that case.

Fixes: 778ff5bb8689 ("ASoC: dapm: Move connection of CODEC to CODEC DAIs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0dcdcc23dcfde..43983c69f6aad 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4087,6 +4087,13 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 				playback = snd_soc_dapm_new_dai(card, rtd,
 								playback_cpu,
 								codec);
+				if (IS_ERR(playback)) {
+					dev_err(rtd->dev,
+						"ASoC: Failed to create DAI %s: %ld\n",
+						codec_dai->name,
+						PTR_ERR(playback));
+					continue;
+				}
 
 				snd_soc_dapm_add_path(&card->dapm, playback_cpu,
 						      playback, NULL, NULL);
@@ -4099,7 +4106,9 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 			snd_soc_dapm_add_path(&card->dapm, playback, codec,
 					      NULL, NULL);
 		}
+	}
 
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
 		/* connect BE DAI capture if widgets are valid */
 		codec = codec_dai->capture_widget;
 
@@ -4108,6 +4117,13 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 				capture = snd_soc_dapm_new_dai(card, rtd,
 							       codec,
 							       capture_cpu);
+				if (IS_ERR(capture)) {
+					dev_err(rtd->dev,
+						"ASoC: Failed to create DAI %s: %ld\n",
+						codec_dai->name,
+						PTR_ERR(capture));
+					continue;
+				}
 
 				snd_soc_dapm_add_path(&card->dapm, capture,
 						      capture_cpu, NULL, NULL);
-- 
2.11.0
