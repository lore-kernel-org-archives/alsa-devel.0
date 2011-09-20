From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Ensure we generate a card name
Date: Tue, 20 Sep 2011 11:42:21 +0100
Message-ID: <1316515341-21157-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53A86103919
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 12:42:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.cm>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Commit 873bd4c (ASoC: Don't set invalid name string to snd_card->driver
field) broke generation of a driver name for all ASoC cards relying on the
automatic generation of one. Fix this by using the old default with spaces
replaced by underscores.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 10e5cde..7e30c08 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1432,9 +1432,11 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		 "%s", card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
 		 "%s", card->long_name ? card->long_name : card->name);
-	if (card->driver_name)
-		strlcpy(card->snd_card->driver, card->driver_name,
-			sizeof(card->snd_card->driver));
+	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
+		 "%s", card->driver_name ? card->driver_name : card->name);
+	for (i = 0; i < ARRAY_SIZE(card->snd_card->driver); i++)
+		if (card->snd_card->driver[i] == ' ')
+			card->snd_card->driver[i] = '_';
 
 	if (card->late_probe) {
 		ret = card->late_probe(card);
-- 
1.7.6.3
