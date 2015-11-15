From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/9] ALSA: oxfw: add a small framework for
	model-unique functionalities
Date: Sun, 15 Nov 2015 18:25:57 +0900
Message-ID: <1447579565-4615-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D47C2619BE
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:10 +0100 (CET)
In-Reply-To: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
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

Some models based on OXFW970/971 have unique functionalities, which kernel
driver should support.

This commit adds a small framework to assist implementation of the
functionalities. The 'struct snd_oxfw_spec' have callbacks of addition,
removal and bus update. The structure also has a member for the size of
private data to allocate memory block.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 25 +++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.h | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 588b93f..a9599ce 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -122,6 +122,13 @@ static void oxfw_card_free(struct snd_card *card)
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 
+	if (oxfw->spec) {
+		if (oxfw->spec->remove)
+			oxfw->spec->remove(oxfw);
+		if (oxfw->spec->private_size)
+			kfree(oxfw->spec->private_data);
+	}
+
 	fw_unit_put(oxfw->unit);
 
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
@@ -196,10 +203,25 @@ static int oxfw_probe(struct fw_unit *unit,
 
 	detect_quirks(oxfw);
 
+	if (oxfw->spec && oxfw->spec->private_size > 0) {
+		oxfw->spec->private_data =
+				kzalloc(oxfw->spec->private_size, GFP_KERNEL);
+		if (oxfw->spec->private_data == NULL) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	err = name_card(oxfw);
 	if (err < 0)
 		goto error;
 
+	if (oxfw->spec && oxfw->spec->add) {
+		err = oxfw->spec->add(oxfw);
+		if (err < 0)
+			goto error;
+	}
+
 	err = snd_oxfw_create_pcm(oxfw);
 	if (err < 0)
 		goto error;
@@ -250,6 +272,9 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 
 	fcp_bus_reset(oxfw->unit);
 
+	if (oxfw->spec && oxfw->spec->update)
+		oxfw->spec->update(oxfw);
+
 	mutex_lock(&oxfw->mutex);
 
 	snd_oxfw_stream_update_simplex(oxfw, &oxfw->rx_stream);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 8392c42..922e5da 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -40,6 +40,15 @@ struct device_info {
 	u8 volume_fb_id;
 };
 
+struct snd_oxfw;
+struct snd_oxfw_spec {
+	int (*add)(struct snd_oxfw *oxfw);
+	void (*update)(struct snd_oxfw *oxfw);
+	void (*remove)(struct snd_oxfw *oxfw);
+	void *private_data;
+	unsigned int private_size;
+};
+
 /* This is an arbitrary number for convinience. */
 #define	SND_OXFW_STREAM_FORMAT_ENTRIES	10
 struct snd_oxfw {
@@ -68,6 +77,7 @@ struct snd_oxfw {
 	s16 volume[6];
 	s16 volume_min;
 	s16 volume_max;
+	struct snd_oxfw_spec *spec;
 
 	int dev_lock_count;
 	bool dev_lock_changed;
-- 
2.5.0
