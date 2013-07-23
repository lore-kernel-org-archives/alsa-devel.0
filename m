From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove unused dapm_get_snd_card() and
	dapm_get_soc_card()
Date: Tue, 23 Jul 2013 11:12:25 +0200
Message-ID: <1374570745-32224-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-088.synserver.de
 [212.40.185.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EA018261B0C
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 11:11:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

These two functions were added two years ago in commit 4805608 ("ASoC: dapm -
Add methods to retrieve snd_card and soc_card from dapm context.") but have
remained unused so far. Considering that the dapm context actually has a direct
pointer to the card the functions also seem to be unnecessary. E.g. the
expressions 'dapm_get_soc_card(dapm)' and 'dapm->card' yield the same result.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 346ac91..deb1b3d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -174,36 +174,6 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
 }
 
-/* get snd_card from DAPM context */
-static inline struct snd_card *dapm_get_snd_card(
-	struct snd_soc_dapm_context *dapm)
-{
-	if (dapm->codec)
-		return dapm->codec->card->snd_card;
-	else if (dapm->platform)
-		return dapm->platform->card->snd_card;
-	else
-		BUG();
-
-	/* unreachable */
-	return NULL;
-}
-
-/* get soc_card from DAPM context */
-static inline struct snd_soc_card *dapm_get_soc_card(
-		struct snd_soc_dapm_context *dapm)
-{
-	if (dapm->codec)
-		return dapm->codec->card;
-	else if (dapm->platform)
-		return dapm->platform->card;
-	else
-		BUG();
-
-	/* unreachable */
-	return NULL;
-}
-
 static void dapm_reset(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
-- 
1.8.0
