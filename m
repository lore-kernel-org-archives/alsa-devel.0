From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/13] ASoC: Replace
	list_empty(&card->codec_dev_list) with !card->instantiated
Date: Tue, 19 Aug 2014 15:51:30 +0200
Message-ID: <1408456290-13945-14-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id D4AA52657F1
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:55 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
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

With componentization we no longer necessarily need a snd_soc_codec struct for a
card. Instead of checking if the card's CODEC list is empty just use
card->instantiated to check if the card has been instantiated yet.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f359da2..e982cb0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -552,10 +552,8 @@ int snd_soc_suspend(struct device *dev)
 	struct snd_soc_codec *codec;
 	int i, j;
 
-	/* If the initialization of this soc device failed, there is no codec
-	 * associated with it. Just bail out in this case.
-	 */
-	if (list_empty(&card->codec_dev_list))
+	/* If the card is not initialized yet there is nothing to do */
+	if (!card->instantiated)
 		return 0;
 
 	/* Due to the resume being scheduled into a workqueue we could
@@ -808,10 +806,8 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i, ac97_control = 0;
 
-	/* If the initialization of this soc device failed, there is no codec
-	 * associated with it. Just bail out in this case.
-	 */
-	if (list_empty(&card->codec_dev_list))
+	/* If the card is not initialized yet there is nothing to do */
+	if (!card->instantiated)
 		return 0;
 
 	/* activate pins from sleep state */
-- 
1.8.0
