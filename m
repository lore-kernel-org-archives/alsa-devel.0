From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Add a late_probe() callback to cards
Date: Wed,  2 Mar 2011 19:21:11 +0000
Message-ID: <1299093671-12309-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DF9E103834
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 20:20:54 +0100 (CET)
In-Reply-To: <1299093671-12309-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This is run after the DAPM widgets and routes are added, allowing setup
of things like jacks using the routes. The main card probe() is run before
anything else so can't be used for this purpose.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 601c41e..a23f5a5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -683,6 +683,7 @@ struct snd_soc_card {
 	bool instantiated;
 
 	int (*probe)(struct snd_soc_card *card);
+	int (*late_probe)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
 
 	/* the pre and post PM functions are used to do any PM work before and
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6a2839c..8926d38 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1892,6 +1892,15 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
 		 "%s", card->name);
 
+	if (card->late_probe) {
+		ret = card->late_probe(card);
+		if (ret < 0) {
+			dev_err(card->dev, "%s late_probe() failed: %d\n",
+				card->name, ret);
+			goto probe_aux_dev_err;
+		}
+	}
+
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: failed to register soundcard for %s\n", card->name);
-- 
1.7.2.3
