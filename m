From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/8] ALSA: firewire-lib: add new function to
	schedule a work for sound card registration
Date: Thu, 31 Mar 2016 08:47:04 +0900
Message-ID: <1459381629-24189-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C479265041
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:47:14 +0200 (CEST)
In-Reply-To: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commit, ALSA dice driver postpone sound card registration after
IEEE 1394 bus is calm. This idea has advantages for the other drivers.

This commit adds a helper function for it to firewire-lib module. The
function is really for the specific purpose. Callers should initialize
delayed work structure with callback function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 23 +++--------------------
 sound/firewire/lib.c       | 32 ++++++++++++++++++++++++++++++++
 sound/firewire/lib.h       |  3 +++
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 53ca441..96fe68f4 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -20,8 +20,6 @@ MODULE_LICENSE("GPL v2");
 #define WEISS_CATEGORY_ID	0x00
 #define LOUD_CATEGORY_ID	0x10
 
-#define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
-
 /*
  * Some models support several isochronous channels, while these streams are not
  * always available. In this case, add the model name to this list.
@@ -235,27 +233,12 @@ static void do_registration(struct work_struct *work)
 error:
 	snd_dice_stream_destroy_duplex(dice);
 	snd_dice_transaction_destroy(dice);
+	snd_dice_stream_destroy_duplex(dice);
 	snd_card_free(dice->card);
 	dev_info(&dice->unit->device,
 		 "Sound card registration failed: %d\n", err);
 }
 
-static void schedule_registration(struct snd_dice *dice)
-{
-	struct fw_card *fw_card = fw_parent_device(dice->unit)->card;
-	u64 now, delay;
-
-	now = get_jiffies_64();
-	delay = fw_card->reset_jiffies + msecs_to_jiffies(PROBE_DELAY_MS);
-
-	if (time_after64(delay, now))
-		delay -= now;
-	else
-		delay = 0;
-
-	mod_delayed_work(system_wq, &dice->dwork, delay);
-}
-
 static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 {
 	struct snd_dice *dice;
@@ -280,7 +263,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	/* Allocate and register this sound card later. */
 	INIT_DEFERRABLE_WORK(&dice->dwork, do_registration);
-	schedule_registration(dice);
+	snd_fw_schedule_registration(unit, &dice->dwork);
 
 	return 0;
 }
@@ -311,7 +294,7 @@ static void dice_bus_reset(struct fw_unit *unit)
 
 	/* Postpone a workqueue for deferred registration. */
 	if (!dice->registered)
-		schedule_registration(dice);
+		snd_fw_schedule_registration(unit, &dice->dwork);
 
 	/* The handler address register becomes initialized. */
 	snd_dice_transaction_reinit(dice);
diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index f80aafa..ca4dfcf 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -67,6 +67,38 @@ int snd_fw_transaction(struct fw_unit *unit, int tcode,
 }
 EXPORT_SYMBOL(snd_fw_transaction);
 
+#define PROBE_DELAY_MS		(2 * MSEC_PER_SEC)
+
+/**
+ * snd_fw_schedule_registration - schedule work for sound card registration
+ * @unit: an instance for unit on IEEE 1394 bus
+ * @dwork: delayed work with callback function
+ *
+ * This function is not designed for general purposes. When new unit is
+ * connected to IEEE 1394 bus, the bus is under bus-reset state because of
+ * topological change. In this state, units tend to fail both of asynchronous
+ * and isochronous communication. To avoid this problem, this function is used
+ * to postpone sound card registration after the state. The callers must
+ * set up instance of delayed work in advance.
+ */
+void snd_fw_schedule_registration(struct fw_unit *unit,
+				  struct delayed_work *dwork)
+{
+	u64 now, delay;
+
+	now = get_jiffies_64();
+	delay = fw_parent_device(unit)->card->reset_jiffies
+					+ msecs_to_jiffies(PROBE_DELAY_MS);
+
+	if (time_after64(delay, now))
+		delay -= now;
+	else
+		delay = 0;
+
+	mod_delayed_work(system_wq, dwork, delay);
+}
+EXPORT_SYMBOL(snd_fw_schedule_registration);
+
 static void async_midi_port_callback(struct fw_card *card, int rcode,
 				     void *data, size_t length,
 				     void *callback_data)
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index f3f6f84..f676931 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -22,6 +22,9 @@ static inline bool rcode_is_permanent_error(int rcode)
 	return rcode == RCODE_TYPE_ERROR || rcode == RCODE_ADDRESS_ERROR;
 }
 
+void snd_fw_schedule_registration(struct fw_unit *unit,
+				  struct delayed_work *dwork);
+
 struct snd_fw_async_midi_port;
 typedef int (*snd_fw_async_midi_port_fill)(
 				struct snd_rawmidi_substream *substream,
-- 
2.7.4
