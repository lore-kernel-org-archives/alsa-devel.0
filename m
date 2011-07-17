From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] ASoC: core: make comments fit the code
Date: Sun, 17 Jul 2011 18:00:26 +0200
Message-ID: <1310918426-24194-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4E1A3245C3
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jul 2011 18:01:27 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In one comment, cpu_dai was mentioned although codec_dai was used in the
code. Also, fix the name for the card dai list which has no seperation
into card_dai and codec_dai.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d75043e..ba95444 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1631,7 +1631,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 			}
 		}
 		cpu_dai->probed = 1;
-		/* mark cpu_dai as probed and add to card cpu_dai list */
+		/* mark cpu_dai as probed and add to card dai list */
 		list_add(&cpu_dai->card_list, &card->dai_dev_list);
 	}
 
@@ -1672,7 +1672,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 			}
 		}
 
-		/* mark cpu_dai as probed and add to card cpu_dai list */
+		/* mark codec_dai as probed and add to card dai list */
 		codec_dai->probed = 1;
 		list_add(&codec_dai->card_list, &card->dai_dev_list);
 	}
-- 
1.7.5.4
