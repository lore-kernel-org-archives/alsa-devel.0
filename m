From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: hda - Embed struct
	hda_bus_unsolicited into struct hda_bus
Date: Fri, 20 Feb 2015 08:08:23 +0100
Message-ID: <1424416107-32470-3-git-send-email-tiwai@suse.de>
References: <1424416107-32470-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 190262605FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 08:08:30 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5FBD1ACD6
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 07:08:30 +0000 (UTC)
In-Reply-To: <1424416107-32470-1-git-send-email-tiwai@suse.de>
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

There is no big merit to handle hda_bus_unsolicited object
individually, as it's tightly coupled with the hda_bus object itself.
Embedding it makes the code simpler in the end.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 39 ++++-----------------------------------
 sound/pci/hda/hda_codec.h | 13 +++++++++++--
 sound/pci/hda/hda_local.h | 17 -----------------
 3 files changed, 15 insertions(+), 54 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 215bf048c668..0734cb35887d 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -762,10 +762,7 @@ int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex)
 		return 0;
 
 	trace_hda_unsol_event(bus, res, res_ex);
-	unsol = bus->unsol;
-	if (!unsol)
-		return 0;
-
+	unsol = &bus->unsol;
 	wp = (unsol->wp + 1) % HDA_UNSOL_QUEUE_SIZE;
 	unsol->wp = wp;
 
@@ -784,9 +781,8 @@ EXPORT_SYMBOL_GPL(snd_hda_queue_unsol_event);
  */
 static void process_unsol_events(struct work_struct *work)
 {
-	struct hda_bus_unsolicited *unsol =
-		container_of(work, struct hda_bus_unsolicited, work);
-	struct hda_bus *bus = unsol->bus;
+	struct hda_bus *bus = container_of(work, struct hda_bus, unsol.work);
+	struct hda_bus_unsolicited *unsol = &bus->unsol;
 	struct hda_codec *codec;
 	unsigned int rp, caddr, res;
 
@@ -805,27 +801,6 @@ static void process_unsol_events(struct work_struct *work)
 }
 
 /*
- * initialize unsolicited queue
- */
-static int init_unsol_queue(struct hda_bus *bus)
-{
-	struct hda_bus_unsolicited *unsol;
-
-	if (bus->unsol) /* already initialized */
-		return 0;
-
-	unsol = kzalloc(sizeof(*unsol), GFP_KERNEL);
-	if (!unsol) {
-		dev_err(bus->card->dev, "can't allocate unsolicited queue\n");
-		return -ENOMEM;
-	}
-	INIT_WORK(&unsol->work, process_unsol_events);
-	unsol->bus = bus;
-	bus->unsol = unsol;
-	return 0;
-}
-
-/*
  * destructor
  */
 static void snd_hda_bus_free(struct hda_bus *bus)
@@ -836,7 +811,6 @@ static void snd_hda_bus_free(struct hda_bus *bus)
 	WARN_ON(!list_empty(&bus->codec_list));
 	if (bus->workq)
 		flush_workqueue(bus->workq);
-	kfree(bus->unsol);
 	if (bus->ops.private_free)
 		bus->ops.private_free(bus);
 	if (bus->workq)
@@ -888,6 +862,7 @@ int snd_hda_bus_new(struct snd_card *card,
 	mutex_init(&bus->cmd_mutex);
 	mutex_init(&bus->prepare_mutex);
 	INIT_LIST_HEAD(&bus->codec_list);
+	INIT_WORK(&bus->unsol.work, process_unsol_events);
 
 	snprintf(bus->workq_name, sizeof(bus->workq_name),
 		 "hd-audio%d", card->number);
@@ -1689,12 +1664,6 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 		return err;
 	}
 
-	if (codec->patch_ops.unsol_event) {
-		err = init_unsol_queue(codec->bus);
-		if (err < 0)
-			return err;
-	}
-
 	/* audio codec should override the mixer name */
 	if (codec->afg || !*codec->bus->card->mixername)
 		snprintf(codec->bus->card->mixername,
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 5a6594884069..96421a3b32cd 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -66,7 +66,6 @@ struct hda_beep;
 struct hda_codec;
 struct hda_pcm;
 struct hda_pcm_stream;
-struct hda_bus_unsolicited;
 
 /* NID type */
 typedef u16 hda_nid_t;
@@ -101,6 +100,16 @@ struct hda_bus_ops {
 #endif
 };
 
+/* unsolicited event handler */
+#define HDA_UNSOL_QUEUE_SIZE	64
+struct hda_bus_unsolicited {
+	/* ring buffer */
+	u32 queue[HDA_UNSOL_QUEUE_SIZE * 2];
+	unsigned int rp, wp;
+	/* workqueue */
+	struct work_struct work;
+};
+
 /*
  * codec bus
  *
@@ -126,7 +135,7 @@ struct hda_bus {
 	struct mutex prepare_mutex;
 
 	/* unsolicited event queue */
-	struct hda_bus_unsolicited *unsol;
+	struct hda_bus_unsolicited unsol;
 	char workq_name[16];
 	struct workqueue_struct *workq;	/* common workqueue for codecs */
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 62658f2f8c9f..49c08a7278c4 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -466,23 +466,6 @@ void snd_hda_pick_pin_fixup(struct hda_codec *codec,
 			    const struct snd_hda_pin_quirk *pin_quirk,
 			    const struct hda_fixup *fixlist);
 
-
-/*
- * unsolicited event handler
- */
-
-#define HDA_UNSOL_QUEUE_SIZE	64
-
-struct hda_bus_unsolicited {
-	/* ring buffer */
-	u32 queue[HDA_UNSOL_QUEUE_SIZE * 2];
-	unsigned int rp, wp;
-
-	/* workqueue */
-	struct work_struct work;
-	struct hda_bus *bus;
-};
-
 /* helper macros to retrieve pin default-config values */
 #define get_defcfg_connect(cfg) \
 	((cfg & AC_DEFCFG_PORT_CONN) >> AC_DEFCFG_PORT_CONN_SHIFT)
-- 
2.3.0
