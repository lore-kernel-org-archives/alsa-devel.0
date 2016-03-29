From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: bebob: remove module parameters to
	reduce maintenance work
Date: Tue, 29 Mar 2016 22:22:14 +0900
Message-ID: <1459257735-13596-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1459257735-13596-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 60379261AAB
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:22:23 +0200 (CEST)
In-Reply-To: <1459257735-13596-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

ALSA bebob driver has some parameters; 'index', 'id', 'enable'. Each
parameter consists of array. When a bebob unit is probed, it consumes
a set of elements from head of the array. Users can set preferred value to
the array, to assign these values to a card relevant to the unit.

The meaning of each parameter is:
 - index: used as 'card number' maintained by 'snd' module. The scope of
   card number is system wide. When duplicated value is set, the module
   detect it and the card fails to be probed.
 - id:  used as 'identification name'. For example, users can see it in
   '/proc/asound/cards'
 - enable: whether the element of array can be used or unused for a sound
   card instance. If not enabled, it skips and next element is used.

Well, this commit is going to purge these parameters. In alsa-lib, the card
number is used for users to identify preferred card, however ID name
can be also used for the same purpose (i.e. 'hw:F1814,0' can be used
instead of 'hw:1,0' in a case that the unit is identified as card
number 1). Users are not necessarily forced to use the card number.
Therefore, the 'index' parameter has less advantage.

Additionally, most users have one unit. If they have several units, these
units might not the same models. Thus, the 'id' parameter is useless
because these units mostly have the different names. If using units with
the same model, they can know which card corresponds to a unit, because
units on IEEE 1394 has global unique ID (GUID) and drivers in ALSA firewire
stack except for dice driver pushes the GUID to 'longname' field of sound
card. As another way, hwdep interface give a way for users to get the
correspondence between the sound card and GUID. For example, libhinawa is
such the hwdep application.

Removal of the parameters reduces relevant codes, thus reduces maintenance
work. This commit purge them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 49 ++++++--------------------------------------
 sound/firewire/bebob/bebob.h |  1 -
 2 files changed, 6 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 932901d..e429e54 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -18,20 +18,6 @@ MODULE_DESCRIPTION("BridgeCo BeBoB driver");
 MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
 MODULE_LICENSE("GPL v2");
 
-static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
-static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
-static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
-
-module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "card index");
-module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string");
-module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "enable BeBoB sound card");
-
-static DEFINE_MUTEX(devices_mutex);
-static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
-
 /* Offsets from information register. */
 #define INFO_OFFSET_BEBOB_VERSION	0x08
 #define INFO_OFFSET_GUID		0x10
@@ -142,12 +128,6 @@ bebob_card_free(struct snd_card *card)
 
 	kfree(bebob->maudio_special_quirk);
 
-	if (bebob->card_index >= 0) {
-		mutex_lock(&devices_mutex);
-		clear_bit(bebob->card_index, devices_used);
-		mutex_unlock(&devices_mutex);
-	}
-
 	mutex_destroy(&bebob->mutex);
 }
 
@@ -183,20 +163,8 @@ bebob_probe(struct fw_unit *unit,
 	struct snd_card *card;
 	struct snd_bebob *bebob;
 	const struct snd_bebob_spec *spec;
-	unsigned int card_index;
 	int err;
 
-	mutex_lock(&devices_mutex);
-
-	for (card_index = 0; card_index < SNDRV_CARDS; card_index++) {
-		if (!test_bit(card_index, devices_used) && enable[card_index])
-			break;
-	}
-	if (card_index >= SNDRV_CARDS) {
-		err = -ENOENT;
-		goto end;
-	}
-
 	if ((entry->vendor_id == VEN_FOCUSRITE) &&
 	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH))
 		spec = get_saffire_spec(unit);
@@ -210,19 +178,16 @@ bebob_probe(struct fw_unit *unit,
 	if (spec == NULL) {
 		if ((entry->vendor_id == VEN_MAUDIO1) ||
 		    (entry->vendor_id == VEN_MAUDIO2))
-			err = snd_bebob_maudio_load_firmware(unit);
+			return snd_bebob_maudio_load_firmware(unit);
 		else
-			err = -ENOSYS;
-		goto end;
+			return -ENOSYS;
 	}
 
-	err = snd_card_new(&unit->device, index[card_index], id[card_index],
-			   THIS_MODULE, sizeof(struct snd_bebob), &card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(struct snd_bebob), &card);
 	if (err < 0)
-		goto end;
+		return err;
 	bebob = card->private_data;
-	bebob->card_index = card_index;
-	set_bit(card_index, devices_used);
 	card->private_free = bebob_card_free;
 
 	bebob->card = card;
@@ -291,11 +256,9 @@ bebob_probe(struct fw_unit *unit,
 	}
 
 	dev_set_drvdata(&unit->device, bebob);
-end:
-	mutex_unlock(&devices_mutex);
+
 	return err;
 error:
-	mutex_unlock(&devices_mutex);
 	snd_card_free(card);
 	return err;
 }
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index b50bb33d..2f336a1 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -78,7 +78,6 @@ struct snd_bebob_spec {
 struct snd_bebob {
 	struct snd_card *card;
 	struct fw_unit *unit;
-	int card_index;
 
 	struct mutex mutex;
 	spinlock_t lock;
-- 
2.7.3
