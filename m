From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/17] ALSA: oxfw: gather model-dependent
	conditions to a function
Date: Sun,  6 Dec 2015 13:18:13 +0900
Message-ID: <1449375505-2704-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 718D12604AC
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
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

Adding control elements is just for models supported by old
firewire-speakers modules. Therefore, the processing should be in a
function to handle model-dependent quirk.

This commit moves the codes to the function. As a result, the function
should handle error state, thus this commit also changes prototype of
the function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 836d757..d4fb3c1 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -135,7 +135,7 @@ static void oxfw_card_free(struct snd_card *card)
 	mutex_destroy(&oxfw->mutex);
 }
 
-static void detect_quirks(struct snd_oxfw *oxfw)
+static int detect_quirks(struct snd_oxfw *oxfw)
 {
 	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
 	struct fw_csr_iterator it;
@@ -143,13 +143,24 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 	int vendor, model;
 
 	/*
+	 * Add ALSA control elements for two models to keep compatibility to
+	 * old firewire-speaker module.
+	 */
+	if (oxfw->entry->vendor_id == VENDOR_GRIFFIN ||
+	    oxfw->entry->vendor_id == VENDOR_LACIE) {
+		oxfw->device_info =
+			(const struct device_info *)oxfw->entry->driver_data;
+		return snd_oxfw_add_spkr(oxfw);
+	}
+
+	/*
 	 * TASCAM FireOne has physical control and requires a pair of additional
 	 * MIDI ports.
 	 */
 	if (oxfw->entry->vendor_id == VENDOR_TASCAM) {
 		oxfw->midi_input_ports++;
 		oxfw->midi_output_ports++;
-		return;
+		return 0;
 	}
 
 	/* Seek from Root Directory of Config ROM. */
@@ -168,6 +179,8 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 	 */
 	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
 		oxfw->wrong_dbs = true;
+
+	return 0;
 }
 
 static int oxfw_probe(struct fw_unit *unit,
@@ -198,7 +211,9 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	detect_quirks(oxfw);
+	err = detect_quirks(oxfw);
+	if (err < 0)
+		goto error;
 
 	err = name_card(oxfw);
 	if (err < 0)
@@ -208,14 +223,6 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	if (oxfw->device_info) {
-		oxfw->device_info =
-				(const struct device_info *)entry->driver_data;
-		err = snd_oxfw_add_spkr(oxfw);
-		if (err < 0)
-			goto error;
-	}
-
 	snd_oxfw_proc_init(oxfw);
 
 	err = snd_oxfw_create_midi(oxfw);
-- 
2.5.0
