From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 49/49] firewire/bebob: Add a workaround for M-Audio special
	Firewire series
Date: Fri, 25 Apr 2014 22:45:30 +0900
Message-ID: <1398433530-13136-50-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In post commit, a quirk of this firmware about transactions is reported.
This commit apply a workaround for this quirk.

They often fail transactions due to gap_count mismatch. This state is changed
by generating bus reset.

The fw_schedule_bus_reset() is an exported symbol in firewire-core. But there
are no header for public. This commit moves its prototype from
drivers/firewire/core.h to include/linux/firewire.h.

This mismatch still affects bus management before generating this bus reset.
It still takes a time to call driver's probe() because transactions are still
often failed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core.h      |  1 -
 include/linux/firewire.h     |  3 +++
 sound/firewire/bebob/bebob.c | 32 ++++++++++++++++++++++++++++----
 sound/firewire/bebob/bebob.h |  1 +
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index c98764a..870044e 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -118,7 +118,6 @@ int fw_card_add(struct fw_card *card,
 		u32 max_receive, u32 link_speed, u64 guid);
 void fw_core_remove_card(struct fw_card *card);
 int fw_compute_block_crc(__be32 *block);
-void fw_schedule_bus_reset(struct fw_card *card, bool delayed, bool short_reset);
 void fw_schedule_bm_work(struct fw_card *card, unsigned long delay);
 
 /* -cdev */
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index c3683bd..d4b7683 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -367,6 +367,9 @@ static inline int fw_stream_packet_destination_id(int tag, int channel, int sy)
 	return tag << 14 | channel << 8 | sy;
 }
 
+void fw_schedule_bus_reset(struct fw_card *card, bool delayed,
+			   bool short_reset);
+
 struct fw_descriptor {
 	struct list_head link;
 	size_t length;
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index e1dd421..31b96b7 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -247,10 +247,26 @@ bebob_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_bebob_stream_destroy_duplex(bebob);
-		goto error;
+	if (!bebob->maudio_special_quirk) {
+		err = snd_card_register(card);
+		if (err < 0) {
+			snd_bebob_stream_destroy_duplex(bebob);
+			goto error;
+		}
+	} else {
+		/*
+		 * This is a workaround. This bus reset seems to have an effect
+		 * to make devices correctly handling transactions. Without
+		 * this, the devices have gap_count mismatch. This causes much
+		 * failure of transaction.
+		 *
+		 * Just after registration, user-land application receive
+		 * signals from dbus and starts I/Os. To avoid I/Os till the
+		 * future bus reset, registration is done in next update().
+		 */
+		bebob->deferred_registration = true;
+		fw_schedule_bus_reset(fw_parent_device(bebob->unit)->card,
+				      false, true);
 	}
 
 	dev_set_drvdata(&unit->device, bebob);
@@ -273,6 +289,14 @@ bebob_update(struct fw_unit *unit)
 
 	fcp_bus_reset(bebob->unit);
 	snd_bebob_stream_update_duplex(bebob);
+
+	if (bebob->deferred_registration) {
+		if (snd_card_register(bebob->card) < 0) {
+			snd_bebob_stream_destroy_duplex(bebob);
+			snd_card_free(bebob->card);
+		}
+		bebob->deferred_registration = false;
+	}
 }
 
 static void bebob_remove(struct fw_unit *unit)
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 4a54e74..91b26b0 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -109,6 +109,7 @@ struct snd_bebob {
 
 	/* for M-Audio special devices */
 	void *maudio_special_quirk;
+	bool deferred_registration;
 };
 
 static inline int
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
