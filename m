From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: seq: virmidi: Use
	READ_ONCE/WRITE_ONCE() macros
Date: Mon, 30 Jul 2018 18:52:30 +0200
Message-ID: <20180730165230.10388-2-tiwai@suse.de>
References: <20180730165230.10388-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3C7A26779C
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 18:52:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 20F79AF3A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 16:52:37 +0000 (UTC)
In-Reply-To: <20180730165230.10388-1-tiwai@suse.de>
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

The trigger flag in vmidi object can be referred in different contexts
concurrently, hence it's better to be put with READ_ONCE() and
WRITE_ONCE() macros to assure the accesses.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_virmidi.h  |  2 +-
 sound/core/seq/seq_virmidi.c | 14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/sound/seq_virmidi.h b/include/sound/seq_virmidi.h
index d488dcfa3a4e..796ce7772213 100644
--- a/include/sound/seq_virmidi.h
+++ b/include/sound/seq_virmidi.h
@@ -36,7 +36,7 @@ struct snd_virmidi {
 	int seq_mode;
 	int client;
 	int port;
-	unsigned int trigger: 1;
+	bool trigger;
 	struct snd_midi_event *parser;
 	struct snd_seq_event event;
 	struct snd_virmidi_dev *rdev;
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 67ea5d62cebc..03ac5e72dbe6 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -89,7 +89,7 @@ static int snd_virmidi_dev_receive_event(struct snd_virmidi_dev *rdev,
 	else
 		down_read(&rdev->filelist_sem);
 	list_for_each_entry(vmidi, &rdev->filelist, list) {
-		if (!vmidi->trigger)
+		if (!READ_ONCE(vmidi->trigger))
 			continue;
 		if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 			if ((ev->flags & SNDRV_SEQ_EVENT_LENGTH_MASK) != SNDRV_SEQ_EVENT_LENGTH_VARIABLE)
@@ -147,11 +147,7 @@ static void snd_virmidi_input_trigger(struct snd_rawmidi_substream *substream, i
 {
 	struct snd_virmidi *vmidi = substream->runtime->private_data;
 
-	if (up) {
-		vmidi->trigger = 1;
-	} else {
-		vmidi->trigger = 0;
-	}
+	WRITE_ONCE(vmidi->trigger, !!up);
 }
 
 /* process rawmidi bytes and send events;
@@ -175,7 +171,7 @@ static void snd_vmidi_output_work(struct work_struct *work)
 		return;
 	}
 
-	while (vmidi->trigger) {
+	while (READ_ONCE(vmidi->trigger)) {
 		if (snd_rawmidi_transmit(substream, &input, 1) != 1)
 			break;
 		if (snd_midi_event_encode_byte(vmidi->parser, input,
@@ -201,7 +197,7 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
 {
 	struct snd_virmidi *vmidi = substream->runtime->private_data;
 
-	vmidi->trigger = !!up;
+	WRITE_ONCE(vmidi->trigger, !!up);
 	if (up)
 		queue_work(system_highpri_wq, &vmidi->output_work);
 }
@@ -289,7 +285,7 @@ static int snd_virmidi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct snd_virmidi *vmidi = substream->runtime->private_data;
 
-	vmidi->trigger = 0; /* to be sure */
+	WRITE_ONCE(vmidi->trigger, false); /* to be sure */
 	cancel_work_sync(&vmidi->output_work);
 	snd_midi_event_free(vmidi->parser);
 	substream->runtime->private_data = NULL;
-- 
2.18.0
