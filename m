From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Remove locking in snd_soc_{new,
	free}_ac97_codec()
Date: Tue, 23 Sep 2014 00:56:28 +0200
Message-ID: <1411426588-27149-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9388B261696
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 00:56:26 +0200 (CEST)
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

snd_soc_new_ac97_codec() and snd_soc_free_ac97_codec() are called from
within a CODEC's probe() and remove() callbacks. Those will not run
concurrently against each other for the same CODEC instance, hence it is not
necessary to protect the two functions with a mutex.

This removes the last user in the ASoC core of the snd_soc_codec mutex field
and will allow us to eventually remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 889f4e3..5289984 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2107,13 +2107,9 @@ static struct platform_driver soc_driver = {
 int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	struct snd_ac97_bus_ops *ops, int num)
 {
-	mutex_lock(&codec->mutex);
-
 	codec->ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
-	if (codec->ac97 == NULL) {
-		mutex_unlock(&codec->mutex);
+	if (codec->ac97 == NULL)
 		return -ENOMEM;
-	}
 
 	codec->ac97->bus = kzalloc(sizeof(struct snd_ac97_bus), GFP_KERNEL);
 	if (codec->ac97->bus == NULL) {
@@ -2132,7 +2128,6 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	 */
 	codec->ac97_created = 1;
 
-	mutex_unlock(&codec->mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
@@ -2302,7 +2297,6 @@ EXPORT_SYMBOL_GPL(snd_soc_set_ac97_ops_of_reset);
  */
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 {
-	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	soc_unregister_ac97_codec(codec);
 #endif
@@ -2310,7 +2304,6 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 	kfree(codec->ac97);
 	codec->ac97 = NULL;
 	codec->ac97_created = 0;
-	mutex_unlock(&codec->mutex);
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
 
-- 
1.8.0
