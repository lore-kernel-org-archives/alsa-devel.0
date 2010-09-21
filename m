From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Report error codes for card DAI
	instantiation failures
Date: Tue, 21 Sep 2010 17:24:01 +0100
Message-ID: <1285086241-26354-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B7A524383
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 18:24:04 +0200 (CEST)
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

Also clean up the error print a bit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7c64e03..5c58651 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1568,7 +1568,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_links; i++) {
 		ret = soc_probe_dai_link(card, i);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: failed to instanciate card %s\n", card->name);
+			pr_err("asoc: failed to instantiate card %s: %d\n",
+			       card->name, ret);
 			goto probe_dai_err;
 		}
 	}
-- 
1.7.1
