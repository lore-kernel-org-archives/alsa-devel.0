From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/5] ALSA: mts64: fix checkpatch space complains
Date: Thu,  7 Jan 2016 14:02:48 +0530
Message-ID: <1452155569-6763-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452155569-6763-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452155569-6763-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

checkpatch was complaining about space before start of a line and a
required space before opening brace.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/mts64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index f00e938..ee6a87f 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -743,7 +743,7 @@ static void snd_mts64_rawmidi_input_trigger(struct snd_rawmidi_substream *substr
 	if (up)
 		mts->mode[substream->number] |= MTS64_MODE_INPUT_TRIGGERED;
 	else
- 		mts->mode[substream->number] &= ~MTS64_MODE_INPUT_TRIGGERED;
+		mts->mode[substream->number] &= ~MTS64_MODE_INPUT_TRIGGERED;
 
 	spin_unlock_irqrestore(&mts->lock, flags);
 }
@@ -779,8 +779,8 @@ static int snd_mts64_rawmidi_create(struct snd_card *card)
 	rmidi->private_data = mts;
 	strcpy(rmidi->name, CARD_NAME);
 	rmidi->info_flags = SNDRV_RAWMIDI_INFO_OUTPUT |
-		            SNDRV_RAWMIDI_INFO_INPUT |
-                            SNDRV_RAWMIDI_INFO_DUPLEX;
+			    SNDRV_RAWMIDI_INFO_INPUT |
+			    SNDRV_RAWMIDI_INFO_DUPLEX;
 
 	mts->rmidi = rmidi;
 
@@ -803,7 +803,7 @@ static int snd_mts64_rawmidi_create(struct snd_card *card)
 		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams) {
 		substream = list_entry(list, struct snd_rawmidi_substream, list);
 		mts->midi_input_substream[substream->number] = substream;
-		switch(substream->number) {
+		switch (substream->number) {
 		case MTS64_SMPTE_SUBSTREAM:
 			strcpy(substream->name, "Miditerminal SMPTE");
 			break;
-- 
1.9.1
