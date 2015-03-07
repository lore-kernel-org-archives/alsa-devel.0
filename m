From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix component lists locking
Date: Sat,  7 Mar 2015 19:34:03 +0100
Message-ID: <1425753243-28288-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id 314F12605E8
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 19:34:04 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Any access to the component_list, codec_list and platform_list needs to be
properly locked by the client_mutex. Otherwise undefined behavior can occur
if the list is modified in one thread and concurrently accessed from another
thread.

This patch adds the missing locking to the debugfs file handlers that
display the registered components, as well as the various components
unregister functions.

Furthermore the client_lock is now held for the whole
snd_soc_instantiate_card() sequence to make sure that component removal does
not race against the card registration.

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5c0658d..07aa543 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -347,6 +347,8 @@ static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
+	mutex_lock(&client_mutex);
+
 	list_for_each_entry(codec, &codec_list, list) {
 		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
 			       codec->component.name);
@@ -358,6 +360,8 @@ static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
 		}
 	}
 
+	mutex_unlock(&client_mutex);
+
 	if (ret >= 0)
 		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
@@ -382,6 +386,8 @@ static ssize_t dai_list_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
+	mutex_lock(&client_mutex);
+
 	list_for_each_entry(component, &component_list, list) {
 		list_for_each_entry(dai, &component->dai_list, list) {
 			len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
@@ -395,6 +401,8 @@ static ssize_t dai_list_read_file(struct file *file, char __user *user_buf,
 		}
 	}
 
+	mutex_unlock(&client_mutex);
+
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
@@ -418,6 +426,8 @@ static ssize_t platform_list_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
+	mutex_lock(&client_mutex);
+
 	list_for_each_entry(platform, &platform_list, list) {
 		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
 			       platform->component.name);
@@ -429,6 +439,8 @@ static ssize_t platform_list_read_file(struct file *file,
 		}
 	}
 
+	mutex_unlock(&client_mutex);
+
 	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
@@ -836,6 +848,8 @@ static struct snd_soc_component *soc_find_component(
 {
 	struct snd_soc_component *component;
 
+	lockdep_assert_held(&client_mutex);
+
 	list_for_each_entry(component, &component_list, list) {
 		if (of_node) {
 			if (component->dev->of_node == of_node)
@@ -854,6 +868,8 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	struct snd_soc_component *component;
 	struct snd_soc_dai *dai;
 
+	lockdep_assert_held(&client_mutex);
+
 	/* Find CPU DAI from registered DAIs*/
 	list_for_each_entry(component, &component_list, list) {
 		if (dlc->of_node && component->dev->of_node != dlc->of_node)
@@ -1508,6 +1524,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 	int ret, i, order;
 
+	mutex_lock(&client_mutex);
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
 	/* bind DAIs */
@@ -1670,6 +1687,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
+	mutex_unlock(&client_mutex);
 
 	return 0;
 
@@ -1688,6 +1706,7 @@ card_probe_error:
 
 base_error:
 	mutex_unlock(&card->mutex);
+	mutex_unlock(&client_mutex);
 
 	return ret;
 }
@@ -2721,13 +2740,6 @@ static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 	list_del(&component->list);
 }
 
-static void snd_soc_component_del(struct snd_soc_component *component)
-{
-	mutex_lock(&client_mutex);
-	snd_soc_component_del_unlocked(component);
-	mutex_unlock(&client_mutex);
-}
-
 int snd_soc_register_component(struct device *dev,
 			       const struct snd_soc_component_driver *cmpnt_drv,
 			       struct snd_soc_dai_driver *dai_drv,
@@ -2775,14 +2787,17 @@ void snd_soc_unregister_component(struct device *dev)
 {
 	struct snd_soc_component *cmpnt;
 
+	mutex_lock(&client_mutex);
 	list_for_each_entry(cmpnt, &component_list, list) {
 		if (dev == cmpnt->dev && cmpnt->registered_as_component)
 			goto found;
 	}
+	mutex_unlock(&client_mutex);
 	return;
 
 found:
-	snd_soc_component_del(cmpnt);
+	snd_soc_component_del_unlocked(cmpnt);
+	mutex_unlock(&client_mutex);
 	snd_soc_component_cleanup(cmpnt);
 	kfree(cmpnt);
 }
@@ -2890,10 +2905,14 @@ struct snd_soc_platform *snd_soc_lookup_platform(struct device *dev)
 {
 	struct snd_soc_platform *platform;
 
+	mutex_lock(&client_mutex);
 	list_for_each_entry(platform, &platform_list, list) {
-		if (dev == platform->dev)
+		if (dev == platform->dev) {
+			mutex_unlock(&client_mutex);
 			return platform;
+		}
 	}
+	mutex_unlock(&client_mutex);
 
 	return NULL;
 }
@@ -3098,15 +3117,15 @@ void snd_soc_unregister_codec(struct device *dev)
 {
 	struct snd_soc_codec *codec;
 
+	mutex_lock(&client_mutex);
 	list_for_each_entry(codec, &codec_list, list) {
 		if (dev == codec->dev)
 			goto found;
 	}
+	mutex_unlock(&client_mutex);
 	return;
 
 found:
-
-	mutex_lock(&client_mutex);
 	list_del(&codec->list);
 	snd_soc_component_del_unlocked(&codec->component);
 	mutex_unlock(&client_mutex);
-- 
1.8.0
