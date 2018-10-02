From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: oxfw: use managed-resource to
	maintain cache of stream formats
Date: Wed,  3 Oct 2018 08:21:54 +0900
Message-ID: <20181002232154.29225-6-o-takashi@sakamocchi.jp>
References: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95B472678AC
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 01:22:16 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so665992pgb.2
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 16:22:16 -0700 (PDT)
In-Reply-To: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA oxfw driver allocates memory objects for cache of stream formats.
The objects are used to maintain packet streaming by components for
ALSA rawMIDI/PCM interface. They can be released as managed-resource
of 'struct snd_card.card_dev'.

This commit uses managed-resource of the sound card device for this
purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 13 ++++++++-----
 sound/firewire/oxfw/oxfw.c        | 14 --------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index d9361f352133..f230a9e44c3c 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -517,8 +517,9 @@ assume_stream_formats(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
 	if (err < 0)
 		goto end;
 
-	formats[eid] = kmemdup(buf, *len, GFP_KERNEL);
-	if (formats[eid] == NULL) {
+	formats[eid] = devm_kmemdup(&oxfw->card->card_dev, buf, *len,
+				    GFP_KERNEL);
+	if (!formats[eid]) {
 		err = -ENOMEM;
 		goto end;
 	}
@@ -535,7 +536,8 @@ assume_stream_formats(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
 			continue;
 
 		eid++;
-		formats[eid] = kmemdup(buf, *len, GFP_KERNEL);
+		formats[eid] = devm_kmemdup(&oxfw->card->card_dev, buf, *len,
+					    GFP_KERNEL);
 		if (formats[eid] == NULL) {
 			err = -ENOMEM;
 			goto end;
@@ -597,8 +599,9 @@ static int fill_stream_formats(struct snd_oxfw *oxfw,
 		if (err < 0)
 			break;
 
-		formats[eid] = kmemdup(buf, len, GFP_KERNEL);
-		if (formats[eid] == NULL) {
+		formats[eid] = devm_kmemdup(&oxfw->card->card_dev, buf, len,
+					    GFP_KERNEL);
+		if (!formats[eid]) {
 			err = -ENOMEM;
 			break;
 		}
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 06d791acfdc5..6ac551786b93 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -115,17 +115,10 @@ static int name_card(struct snd_oxfw *oxfw)
 
 static void oxfw_free(struct snd_oxfw *oxfw)
 {
-	unsigned int i;
-
 	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 
-	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
-		kfree(oxfw->tx_stream_formats[i]);
-		kfree(oxfw->rx_stream_formats[i]);
-	}
-
 	mutex_destroy(&oxfw->mutex);
 	fw_unit_put(oxfw->unit);
 }
@@ -205,7 +198,6 @@ static int detect_quirks(struct snd_oxfw *oxfw)
 static void do_registration(struct work_struct *work)
 {
 	struct snd_oxfw *oxfw = container_of(work, struct snd_oxfw, dwork.work);
-	int i;
 	int err;
 
 	if (oxfw->registered)
@@ -268,12 +260,6 @@ static void do_registration(struct work_struct *work)
 	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
-	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; ++i) {
-		kfree(oxfw->tx_stream_formats[i]);
-		oxfw->tx_stream_formats[i] = NULL;
-		kfree(oxfw->rx_stream_formats[i]);
-		oxfw->rx_stream_formats[i] = NULL;
-	}
 	snd_card_free(oxfw->card);
 	dev_info(&oxfw->unit->device,
 		 "Sound card registration failed: %d\n", err);
-- 
2.17.1
