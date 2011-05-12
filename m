From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - allow ASoC more flexible machine
	name
Date: Thu, 12 May 2011 16:14:04 +0100
Message-ID: <1305213244-4644-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A7CD1243C8
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 17:14:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Allow ASoC machine drivers to register a driver name
and a longname. This allows user space to determine
the flavour of machine driver.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b27c7a2..f1de3e0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -702,6 +702,8 @@ struct snd_soc_aux_dev {
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
+	const char *long_name;
+	const char *driver_name;
 	struct device *dev;
 	struct snd_card *snd_card;
 	struct module *owner;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a477e21..c1a4cf4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1926,9 +1926,11 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 					card->num_dapm_routes);
 
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
-		 "%s",  card->name);
-	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
 		 "%s", card->name);
+	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
+		 "%s", card->long_name ? card->long_name : card->name);
+	snprintf(card->snd_card->driver, sizeof(card->snd_card->driver),
+		 "%s", card->driver_name);
 
 	if (card->late_probe) {
 		ret = card->late_probe(card);
-- 
1.7.4.1
