From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/11] ALSA: usb: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:36 +0100
Message-ID: <20190204152036.14102-12-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 12C1F267568
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A95F8AF51
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:40 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
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

Simplify the proc fs creation code with new helper functions,
snd_card_ro_proc_new() and snd_card_rw_proc_new().
Just a code refactoring and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c        |  7 +++----
 sound/usb/mixer_quirks.c |  6 ++----
 sound/usb/proc.c         | 13 +++++--------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 8ad1a24c8f28..73d7dff425c1 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3441,7 +3441,6 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		.dev_free = snd_usb_mixer_dev_free
 	};
 	struct usb_mixer_interface *mixer;
-	struct snd_info_entry *entry;
 	int err;
 
 	strcpy(chip->card->mixername, "USB Mixer");
@@ -3497,9 +3496,9 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	if (err < 0)
 		goto _error;
 
-	if (list_empty(&chip->mixer_list) &&
-	    !snd_card_proc_new(chip->card, "usbmixer", &entry))
-		snd_info_set_text_ops(entry, chip, snd_usb_mixer_proc_read);
+	if (list_empty(&chip->mixer_list))
+		snd_card_ro_proc_new(chip->card, "usbmixer", chip,
+				     snd_usb_mixer_proc_read);
 
 	list_add(&mixer->list, &chip->mixer_list);
 	return 0;
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 85ae0ff2382a..a751a18ca4c2 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2195,7 +2195,6 @@ static int snd_rme_controls_create(struct usb_mixer_interface *mixer)
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
-	struct snd_info_entry *entry;
 
 	err = snd_usb_soundblaster_remote_init(mixer);
 	if (err < 0)
@@ -2214,9 +2213,8 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_audigy2nx_controls_create(mixer);
 		if (err < 0)
 			break;
-		if (!snd_card_proc_new(mixer->chip->card, "audigy2nx", &entry))
-			snd_info_set_text_ops(entry, mixer,
-					      snd_audigy2nx_proc_read);
+		snd_card_ro_proc_new(mixer->chip->card, "audigy2nx",
+				     mixer, snd_audigy2nx_proc_read);
 		break;
 
 	/* EMU0204 */
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 0ac89e294d31..e80c9d0749c9 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -61,11 +61,10 @@ static void proc_audio_usbid_read(struct snd_info_entry *entry, struct snd_info_
 
 void snd_usb_audio_create_proc(struct snd_usb_audio *chip)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(chip->card, "usbbus", &entry))
-		snd_info_set_text_ops(entry, chip, proc_audio_usbbus_read);
-	if (!snd_card_proc_new(chip->card, "usbid", &entry))
-		snd_info_set_text_ops(entry, chip, proc_audio_usbid_read);
+	snd_card_ro_proc_new(chip->card, "usbbus", chip,
+			     proc_audio_usbbus_read);
+	snd_card_ro_proc_new(chip->card, "usbid", chip,
+			     proc_audio_usbid_read);
 }
 
 /*
@@ -167,12 +166,10 @@ static void proc_pcm_format_read(struct snd_info_entry *entry, struct snd_info_b
 
 void snd_usb_proc_pcm_format_add(struct snd_usb_stream *stream)
 {
-	struct snd_info_entry *entry;
 	char name[32];
 	struct snd_card *card = stream->chip->card;
 
 	sprintf(name, "stream%d", stream->pcm_index);
-	if (!snd_card_proc_new(card, name, &entry))
-		snd_info_set_text_ops(entry, stream, proc_pcm_format_read);
+	snd_card_ro_proc_new(card, name, stream, proc_pcm_format_read);
 }
 
-- 
2.16.4
