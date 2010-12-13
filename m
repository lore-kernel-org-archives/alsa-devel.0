From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix AC'97 registration unwind
Date: Mon, 13 Dec 2010 17:04:11 +0000
Message-ID: <1292259851-31853-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C52F24679
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 18:04:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

soc_unregister_ac97_dai_link() takes a CODEC as an argument, not a
rtd like the registration function, so give it what it's looking for.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 68edc69..1dc4b11 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1830,7 +1830,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: failed to register AC97 %s\n", card->name);
 			while (--i >= 0)
-				soc_unregister_ac97_dai_link(&card->rtd[i]);
+				soc_unregister_ac97_dai_link(card->rtd[i].codec);
 			goto probe_aux_dev_err;
 		}
 	}
-- 
1.7.1
