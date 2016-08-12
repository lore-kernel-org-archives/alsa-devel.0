From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda - repoll jack presence state on
	resume
Date: Fri, 12 Aug 2016 15:52:04 +0200
Message-ID: <1471009924-32261-1-git-send-email-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C25826724C
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 15:52:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The jack detection on resume might fail on some hardware
(Lenovo T430s, T440s and X1 Carbon 2016). The codec registers
reports that the jack is not used and the unsolicited event
is not sent on change (or perhaps, it's lost?).

This patch will repoll the jack presence state after
100ms again.

Because the jack status is updated from two workqueues now,
create a new codec->jack_mutex to protect the concurrent
access.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/hda_bind.c  | 2 ++
 sound/pci/hda/hda_codec.c | 9 ++++++++-
 sound/pci/hda/hda_codec.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 6efadbf..81a9284 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -42,8 +42,10 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 {
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
+	mutex_lock(&codec->jack_mutex);
 	if (codec->patch_ops.unsol_event)
 		codec->patch_ops.unsol_event(codec, ev);
+	mutex_unlock(&codec->jack_mutex);
 }
 
 /**
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9913be8..4339e98 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -592,8 +592,10 @@ static void hda_jackpoll_work(struct work_struct *work)
 	struct hda_codec *codec =
 		container_of(work, struct hda_codec, jackpoll_work.work);
 
+	mutex_lock(&codec->jack_mutex);
 	snd_hda_jack_set_dirty_all(codec);
 	snd_hda_jack_poll_all(codec);
+	mutex_unlock(&codec->jack_mutex);
 
 	if (!codec->jackpoll_interval)
 		return;
@@ -837,6 +839,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
+	mutex_init(&codec->jack_mutex);
 	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->nids, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->init_pins, sizeof(struct hda_pincfg), 16);
@@ -3002,8 +3005,12 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 
 	if (codec->jackpoll_interval)
 		hda_jackpoll_work(&codec->jackpoll_work.work);
-	else
+	else {
 		snd_hda_jack_report_sync(codec);
+		/* Some hw requires a little time to settle things */
+		schedule_delayed_work(&codec->jackpoll_work,
+					msecs_to_jiffies(100));
+	}
 	atomic_dec(&codec->core.in_pm);
 }
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 373fcad..6a4a631 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -213,6 +213,7 @@ struct hda_codec {
 
 	struct mutex spdif_mutex;
 	struct mutex control_mutex;
+	struct mutex jack_mutex;
 	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
-- 
2.5.5
