From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: doc: More kerneldoc comments on core
	components
Date: Thu, 30 Oct 2014 16:06:20 +0100
Message-ID: <1414681581-4619-8-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E892652DB
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:24 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2EE6AAC01
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:24 +0000 (UTC)
In-Reply-To: <1414681581-4619-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some functions missed the proper kerneldoc comments.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c  | 33 ++++++++++++++++++++++-----------
 sound/core/sound.c |  9 +++++++--
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 7bdfd19e24a8..074875d68c15 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -438,17 +438,6 @@ int snd_card_disconnect(struct snd_card *card)
 
 EXPORT_SYMBOL(snd_card_disconnect);
 
-/**
- *  snd_card_free - frees given soundcard structure
- *  @card: soundcard structure
- *
- *  This function releases the soundcard structure and the all assigned
- *  devices automatically.  That is, you don't have to release the devices
- *  by yourself.
- *
- *  Return: Zero. Frees all associated devices and frees the control
- *  interface associated to given soundcard.
- */
 static int snd_card_do_free(struct snd_card *card)
 {
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
@@ -469,6 +458,15 @@ static int snd_card_do_free(struct snd_card *card)
 	return 0;
 }
 
+/**
+ * snd_card_free_when_closed - Disconnect the card, free it later eventually
+ * @card: soundcard structure
+ *
+ * Unlike snd_card_free(), this function doesn't try to release the card
+ * resource immediately, but tries to disconnect at first.  When the card
+ * is still in use, the function returns before freeing the resources.
+ * The card resources will be freed when the refcount gets to zero.
+ */
 int snd_card_free_when_closed(struct snd_card *card)
 {
 	int ret = snd_card_disconnect(card);
@@ -479,6 +477,19 @@ int snd_card_free_when_closed(struct snd_card *card)
 }
 EXPORT_SYMBOL(snd_card_free_when_closed);
 
+/**
+ * snd_card_free - frees given soundcard structure
+ * @card: soundcard structure
+ *
+ * This function releases the soundcard structure and the all assigned
+ * devices automatically.  That is, you don't have to release the devices
+ * by yourself.
+ *
+ * This function waits until the all resources are properly released.
+ *
+ * Return: Zero. Frees all associated devices and frees the control
+ * interface associated to given soundcard.
+ */
 int snd_card_free(struct snd_card *card)
 {
 	struct completion released;
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 38ad1a0dd3f7..f1333060bf1c 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -355,8 +355,13 @@ int snd_unregister_device(int type, struct snd_card *card, int dev)
 
 EXPORT_SYMBOL(snd_unregister_device);
 
-/* get the assigned device to the given type and device number;
- * the caller needs to release it via put_device() after using it
+/**
+ * snd_get_device - get the assigned device to the given type and device number
+ * @type: the device type, SNDRV_DEVICE_TYPE_XXX
+ * @card:the card instance
+ * @dev: the device index
+ *
+ * The caller needs to release it via put_device() after using it.
  */
 struct device *snd_get_device(int type, struct snd_card *card, int dev)
 {
-- 
2.1.2
