From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/17] ALSA: oxfw: reuse driver entry to detect
	quirk
Date: Sun,  6 Dec 2015 13:18:12 +0900
Message-ID: <1449375505-2704-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E5D9F2604A6
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:30 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, assignment to model-dependent quirk is corresponding to
asynchronous transactions on IEEE 1394 bus. This is also achieved with
device entry.

This commit changes the processing of model-dependent quirk with the
entry. As a result, the transactions are sent only for Loud models.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 38 ++++++++++++++++++++++----------------
 sound/firewire/oxfw/oxfw.h |  2 ++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 0304d45..836d757 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -59,6 +59,7 @@ static bool detect_loud_models(struct fw_unit *unit)
 static int name_card(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
+	const struct device_info *info;
 	char vendor[24];
 	char model[32];
 	const char *d, *v, *m;
@@ -84,10 +85,12 @@ static int name_card(struct snd_oxfw *oxfw)
 	be32_to_cpus(&firmware);
 
 	/* to apply card definitions */
-	if (oxfw->device_info) {
-		d = oxfw->device_info->driver_name;
-		v = oxfw->device_info->vendor_name;
-		m = oxfw->device_info->model_name;
+	if (oxfw->entry->vendor_id == VENDOR_GRIFFIN ||
+	    oxfw->entry->vendor_id == VENDOR_LACIE) {
+		info = (const struct device_info *)oxfw->entry->driver_data;
+		d = info->driver_name;
+		v = info->vendor_name;
+		m = info->model_name;
 	} else {
 		d = "OXFW";
 		v = vendor;
@@ -139,6 +142,16 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 	int key, val;
 	int vendor, model;
 
+	/*
+	 * TASCAM FireOne has physical control and requires a pair of additional
+	 * MIDI ports.
+	 */
+	if (oxfw->entry->vendor_id == VENDOR_TASCAM) {
+		oxfw->midi_input_ports++;
+		oxfw->midi_output_ports++;
+		return;
+	}
+
 	/* Seek from Root Directory of Config ROM. */
 	vendor = model = 0;
 	fw_csr_iterator_init(&it, fw_dev->config_rom + 5);
@@ -155,25 +168,16 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 	 */
 	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
 		oxfw->wrong_dbs = true;
-
-	/*
-	 * TASCAM FireOne has physical control and requires a pair of additional
-	 * MIDI ports.
-	 */
-	if (vendor == VENDOR_TASCAM) {
-		oxfw->midi_input_ports++;
-		oxfw->midi_output_ports++;
-	}
 }
 
 static int oxfw_probe(struct fw_unit *unit,
-		       const struct ieee1394_device_id *id)
+		      const struct ieee1394_device_id *entry)
 {
 	struct snd_card *card;
 	struct snd_oxfw *oxfw;
 	int err;
 
-	if ((id->vendor_id == VENDOR_LOUD) && !detect_loud_models(unit))
+	if (entry->vendor_id == VENDOR_LOUD && !detect_loud_models(unit))
 		return -ENODEV;
 
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
@@ -186,7 +190,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->card = card;
 	mutex_init(&oxfw->mutex);
 	oxfw->unit = fw_unit_get(unit);
-	oxfw->device_info = (const struct device_info *)id->driver_data;
+	oxfw->entry = entry;
 	spin_lock_init(&oxfw->lock);
 	init_waitqueue_head(&oxfw->hwdep_wait);
 
@@ -205,6 +209,8 @@ static int oxfw_probe(struct fw_unit *unit,
 		goto error;
 
 	if (oxfw->device_info) {
+		oxfw->device_info =
+				(const struct device_info *)entry->driver_data;
 		err = snd_oxfw_add_spkr(oxfw);
 		if (err < 0)
 			goto error;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 9efdc02..f3e14ff 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -72,6 +72,8 @@ struct snd_oxfw {
 	int dev_lock_count;
 	bool dev_lock_changed;
 	wait_queue_head_t hwdep_wait;
+
+	const struct ieee1394_device_id *entry;
 };
 
 /*
-- 
2.5.0
