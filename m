From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Ensure we generate a driver name
Date: Tue, 20 Sep 2011 14:16:03 +0100
Message-ID: <1316524563-22407-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF1A9103A0F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 15:16:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Commit 873bd4c (ASoC: Don't set invalid name string to snd_card->driver
field) broke generation of a driver name for all ASoC cards relying on the
automatic generation of one. Fix this by using the old default with spaces
replaced by underscores.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 10e5cde..bd20154 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -30,6 +30,7 @@
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/platform_device.h>
+#include <linux/ctype.h>
 #include <linux/slab.h>
 #include <sound/ac97_codec.h>
 #include <sound/core.h>
@@ -1432,9 +1433,20 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		 "%s", card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
 		 "%s", card->long_name ? card->long_name : card->name);
-	if (card->driver_name)
-		strlcpy(card->snd_card->driver, card->driver_name,
-			sizeof(card->snd_card->driver));
+	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
+		 "%s", card->driver_name ? card->driver_name : card->name);
+	for (i = 0; i < ARRAY_SIZE(card->snd_card->driver); i++) {
+		switch (card->snd_card->driver[i]) {
+		case '_':
+		case '-':
+		case '\0':
+			break;
+		default:
+			if (!isalnum(card->snd_card->driver[i]))
+				card->snd_card->driver[i] = '_';
+			break;
+		}
+	}
 
 	if (card->late_probe) {
 		ret = card->late_probe(card);
-- 
1.7.6.3
