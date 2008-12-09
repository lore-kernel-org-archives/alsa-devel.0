From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 17/18] ASoC: Wait for non-AC97 codec DAIs
	before instantiating
Date: Tue,  9 Dec 2008 14:01:41 +0000
Message-ID: <1228831302-17605-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-16-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4703924471
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-16-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This will allow codec drivers to be refactored to allow them to be
registered out of line with the ASoC device registration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 717db0e..76a89eb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -788,7 +788,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	struct snd_soc_codec_device *codec_dev = card->socdev->codec_dev;
 	struct snd_soc_platform *platform;
 	struct snd_soc_dai *dai;
-	int i, found, ret;
+	int i, found, ret, ac97;
 
 	if (card->instantiated)
 		return;
@@ -805,6 +805,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		return;
 	}
 
+	ac97 = 0;
 	for (i = 0; i < card->num_links; i++) {
 		found = 0;
 		list_for_each_entry(dai, &dai_list, list)
@@ -817,8 +818,32 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 				card->dai_link[i].cpu_dai->name);
 			return;
 		}
+
+		if (card->dai_link[i].cpu_dai->ac97_control)
+			ac97 = 1;
 	}
 
+	/* If we have AC97 in the system then don't wait for the
+	 * codec.  This will need revisiting if we have to handle
+	 * systems with mixed AC97 and non-AC97 parts.  Only check for
+	 * DAIs currently; we can't do this per link since some AC97
+	 * codecs have non-AC97 DAIs.
+	 */
+	if (!ac97)
+		for (i = 0; i < card->num_links; i++) {
+			found = 0;
+			list_for_each_entry(dai, &dai_list, list)
+				if (card->dai_link[i].codec_dai == dai) {
+					found = 1;
+					break;
+				}
+			if (!found) {
+				dev_dbg(card->dev, "DAI %s not registered\n",
+					card->dai_link[i].codec_dai->name);
+				return;
+			}
+		}
+
 	/* Note that we do not current check for codec components */
 
 	dev_dbg(card->dev, "All components present, instantiating\n");
-- 
1.5.6.5
