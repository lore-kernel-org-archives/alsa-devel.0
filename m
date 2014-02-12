From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/20] ALSA: Drop __bitwise and typedefs for
	snd_device attributes
Date: Wed, 12 Feb 2014 11:52:08 +0100
Message-ID: <1392202347-11774-2-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5FF265083
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BD2B3ABF7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

Using __bitwise and typedefs for the attributes of snd_device struct
isn't so useful, and rather it worsens the readability.  Let's drop
them and use the straightforward enum.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h  | 63 +++++++++++++++++++++++++++------------------------
 sound/aoa/aoa.h       |  2 +-
 sound/aoa/core/alsa.c |  2 +-
 sound/core/device.c   |  8 +++----
 4 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index e946b2428ea0..7c407b588697 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -48,32 +48,35 @@ struct device_attribute;
 
 #define SNDRV_DEV_TYPE_RANGE_SIZE		0x1000
 
-typedef int __bitwise snd_device_type_t;
-#define	SNDRV_DEV_TOPLEVEL	((__force snd_device_type_t) 0)
-#define	SNDRV_DEV_CONTROL	((__force snd_device_type_t) 1)
-#define	SNDRV_DEV_LOWLEVEL_PRE	((__force snd_device_type_t) 2)
-#define	SNDRV_DEV_LOWLEVEL_NORMAL ((__force snd_device_type_t) 0x1000)
-#define	SNDRV_DEV_PCM		((__force snd_device_type_t) 0x1001)
-#define	SNDRV_DEV_RAWMIDI	((__force snd_device_type_t) 0x1002)
-#define	SNDRV_DEV_TIMER		((__force snd_device_type_t) 0x1003)
-#define	SNDRV_DEV_SEQUENCER	((__force snd_device_type_t) 0x1004)
-#define	SNDRV_DEV_HWDEP		((__force snd_device_type_t) 0x1005)
-#define	SNDRV_DEV_INFO		((__force snd_device_type_t) 0x1006)
-#define	SNDRV_DEV_BUS		((__force snd_device_type_t) 0x1007)
-#define	SNDRV_DEV_CODEC		((__force snd_device_type_t) 0x1008)
-#define	SNDRV_DEV_JACK          ((__force snd_device_type_t) 0x1009)
-#define	SNDRV_DEV_COMPRESS	((__force snd_device_type_t) 0x100A)
-#define	SNDRV_DEV_LOWLEVEL	((__force snd_device_type_t) 0x2000)
-
-typedef int __bitwise snd_device_state_t;
-#define	SNDRV_DEV_BUILD		((__force snd_device_state_t) 0)
-#define	SNDRV_DEV_REGISTERED	((__force snd_device_state_t) 1)
-#define	SNDRV_DEV_DISCONNECTED	((__force snd_device_state_t) 2)
-
-typedef int __bitwise snd_device_cmd_t;
-#define	SNDRV_DEV_CMD_PRE	((__force snd_device_cmd_t) 0)
-#define	SNDRV_DEV_CMD_NORMAL	((__force snd_device_cmd_t) 1)	
-#define	SNDRV_DEV_CMD_POST	((__force snd_device_cmd_t) 2)
+enum snd_device_type {
+	SNDRV_DEV_TOPLEVEL	= 0,
+	SNDRV_DEV_CONTROL	= 1,
+	SNDRV_DEV_LOWLEVEL_PRE	= 2,
+	SNDRV_DEV_LOWLEVEL_NORMAL = 0x1000,
+	SNDRV_DEV_PCM,
+	SNDRV_DEV_RAWMIDI,
+	SNDRV_DEV_TIMER,
+	SNDRV_DEV_SEQUENCER,
+	SNDRV_DEV_HWDEP,
+	SNDRV_DEV_INFO,
+	SNDRV_DEV_BUS,
+	SNDRV_DEV_CODEC,
+	SNDRV_DEV_JACK,
+	SNDRV_DEV_COMPRESS,
+	SNDRV_DEV_LOWLEVEL	= 0x2000,
+};
+
+enum snd_device_state {
+	SNDRV_DEV_BUILD,
+	SNDRV_DEV_REGISTERED,
+	SNDRV_DEV_DISCONNECTED,
+};
+
+enum snd_device_cmd {
+	SNDRV_DEV_CMD_PRE,
+	SNDRV_DEV_CMD_NORMAL,
+	SNDRV_DEV_CMD_POST,
+};
 
 struct snd_device;
 
@@ -86,8 +89,8 @@ struct snd_device_ops {
 struct snd_device {
 	struct list_head list;		/* list of registered devices */
 	struct snd_card *card;		/* card which holds this device */
-	snd_device_state_t state;	/* state of the device */
-	snd_device_type_t type;		/* device type */
+	enum snd_device_state state;	/* state of the device */
+	enum snd_device_type type;	/* device type */
 	void *device_data;		/* device structure */
 	struct snd_device_ops *ops;	/* operations */
 };
@@ -310,14 +313,14 @@ void snd_card_unref(struct snd_card *card);
 
 /* device.c */
 
-int snd_device_new(struct snd_card *card, snd_device_type_t type,
+int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		   void *device_data, struct snd_device_ops *ops);
 int snd_device_register(struct snd_card *card, void *device_data);
 int snd_device_register_all(struct snd_card *card);
 int snd_device_disconnect(struct snd_card *card, void *device_data);
 int snd_device_disconnect_all(struct snd_card *card);
 int snd_device_free(struct snd_card *card, void *device_data);
-int snd_device_free_all(struct snd_card *card, snd_device_cmd_t cmd);
+int snd_device_free_all(struct snd_card *card, enum snd_device_cmd cmd);
 
 /* isadma.c */
 
diff --git a/sound/aoa/aoa.h b/sound/aoa/aoa.h
index e08789484e30..34c668f27798 100644
--- a/sound/aoa/aoa.h
+++ b/sound/aoa/aoa.h
@@ -116,7 +116,7 @@ struct aoa_card {
 	struct snd_card *alsa_card;
 };
         
-extern int aoa_snd_device_new(snd_device_type_t type,
+extern int aoa_snd_device_new(enum snd_device_type type,
 	void * device_data, struct snd_device_ops * ops);
 extern struct snd_card *aoa_get_card(void);
 extern int aoa_snd_ctl_add(struct snd_kcontrol* control);
diff --git a/sound/aoa/core/alsa.c b/sound/aoa/core/alsa.c
index 9913bf222073..4a7e4e6b746f 100644
--- a/sound/aoa/core/alsa.c
+++ b/sound/aoa/core/alsa.c
@@ -59,7 +59,7 @@ void aoa_alsa_cleanup(void)
 	}
 }
 
-int aoa_snd_device_new(snd_device_type_t type,
+int aoa_snd_device_new(enum snd_device_type type,
 		       void * device_data, struct snd_device_ops * ops)
 {
 	struct snd_card *card = aoa_get_card();
diff --git a/sound/core/device.c b/sound/core/device.c
index df88defed176..6f734fe50296 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -41,7 +41,7 @@
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_device_new(struct snd_card *card, snd_device_type_t type,
+int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		   void *device_data, struct snd_device_ops *ops)
 {
 	struct snd_device *dev;
@@ -222,7 +222,7 @@ int snd_device_disconnect_all(struct snd_card *card)
  * release all the devices on the card.
  * called from init.c
  */
-int snd_device_free_all(struct snd_card *card, snd_device_cmd_t cmd)
+int snd_device_free_all(struct snd_card *card, enum snd_device_cmd cmd)
 {
 	struct snd_device *dev;
 	int err;
@@ -230,11 +230,11 @@ int snd_device_free_all(struct snd_card *card, snd_device_cmd_t cmd)
 
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
-	range_low = (__force unsigned int)cmd * SNDRV_DEV_TYPE_RANGE_SIZE;
+	range_low = (unsigned int)cmd * SNDRV_DEV_TYPE_RANGE_SIZE;
 	range_high = range_low + SNDRV_DEV_TYPE_RANGE_SIZE - 1;
       __again:
 	list_for_each_entry(dev, &card->devices, list) {
-		type = (__force unsigned int)dev->type;
+		type = (unsigned int)dev->type;
 		if (type >= range_low && type <= range_high) {
 			if ((err = snd_device_free(card, dev->device_data)) < 0)
 				return err;
-- 
1.8.5.2
