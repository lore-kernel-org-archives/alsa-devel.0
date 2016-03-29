From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: fireworks: remove module parameters
	to reduce maintenance work
Date: Tue, 29 Mar 2016 22:22:15 +0900
Message-ID: <1459257735-13596-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1459257735-13596-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF262605C3
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

ALSA fireworks driver has some parameters; 'index', 'id', 'enable'. Each
parameter consists of array. When a fireworks unit is probed, it consumes
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
can be also used for the same purpose (i.e. 'hw:AudioFire2,0' can be used
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
 sound/firewire/fireworks/fireworks.c | 43 ++++--------------------------------
 sound/firewire/fireworks/fireworks.h |  1 -
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 8380fb5..cbc0847 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -21,27 +21,15 @@ MODULE_DESCRIPTION("Echo Fireworks driver");
 MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
 MODULE_LICENSE("GPL v2");
 
-static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
-static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
-static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
 unsigned int snd_efw_resp_buf_size	= 1024;
 bool snd_efw_resp_buf_debug		= false;
 
-module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "card index");
-module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string");
-module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "enable Fireworks sound card");
 module_param_named(resp_buf_size, snd_efw_resp_buf_size, uint, 0444);
 MODULE_PARM_DESC(resp_buf_size,
 		 "response buffer size (max 4096, default 1024)");
 module_param_named(resp_buf_debug, snd_efw_resp_buf_debug, bool, 0444);
 MODULE_PARM_DESC(resp_buf_debug, "store all responses to buffer");
 
-static DEFINE_MUTEX(devices_mutex);
-static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
-
 #define VENDOR_LOUD			0x000ff2
 #define  MODEL_MACKIE_400F		0x00400f
 #define  MODEL_MACKIE_1200F		0x01200f
@@ -201,12 +189,6 @@ efw_card_free(struct snd_card *card)
 
 	kfree(efw->resp_buf);
 
-	if (efw->card_index >= 0) {
-		mutex_lock(&devices_mutex);
-		clear_bit(efw->card_index, devices_used);
-		mutex_unlock(&devices_mutex);
-	}
-
 	mutex_destroy(&efw->mutex);
 }
 
@@ -216,27 +198,13 @@ efw_probe(struct fw_unit *unit,
 {
 	struct snd_card *card;
 	struct snd_efw *efw;
-	int card_index, err;
-
-	mutex_lock(&devices_mutex);
-
-	/* check registered cards */
-	for (card_index = 0; card_index < SNDRV_CARDS; ++card_index) {
-		if (!test_bit(card_index, devices_used) && enable[card_index])
-			break;
-	}
-	if (card_index >= SNDRV_CARDS) {
-		err = -ENOENT;
-		goto end;
-	}
+	int err;
 
-	err = snd_card_new(&unit->device, index[card_index], id[card_index],
-			   THIS_MODULE, sizeof(struct snd_efw), &card);
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(struct snd_efw), &card);
 	if (err < 0)
-		goto end;
+		return err;
 	efw = card->private_data;
-	efw->card_index = card_index;
-	set_bit(card_index, devices_used);
 	card->private_free = efw_card_free;
 
 	efw->card = card;
@@ -287,12 +255,9 @@ efw_probe(struct fw_unit *unit,
 	}
 
 	dev_set_drvdata(&unit->device, efw);
-end:
-	mutex_unlock(&devices_mutex);
 	return err;
 error:
 	snd_efw_transaction_remove_instance(efw);
-	mutex_unlock(&devices_mutex);
 	snd_card_free(card);
 	return err;
 }
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 96c4e0c..57f9af5 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -60,7 +60,6 @@ struct snd_efw_phys_grp {
 struct snd_efw {
 	struct snd_card *card;
 	struct fw_unit *unit;
-	int card_index;
 
 	struct mutex mutex;
 	spinlock_t lock;
-- 
2.7.3
