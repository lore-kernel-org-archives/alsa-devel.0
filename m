From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: rme9652: Adjust seven checks for null pointers
Date: Sat, 12 Aug 2017 17:35:41 +0200
Message-ID: <10358741-a748-1e48-7508-2aff911bbee5@users.sourceforge.net>
References: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a3223028-5b12-0efd-ffe0-aa7300334081@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 17:07:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdspm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8d339fb7c24b..25284d8d9758 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1521,7 +1521,7 @@ static void hdspm_silence_playback(struct hdspm *hdspm)
 	int n = hdspm->period_bytes;
 	void *buf = hdspm->playback_buffer;
 
-	if (buf == NULL)
+	if (!buf)
 		return;
 
 	for (i = 0; i < HDSPM_MAX_CHANNELS; i++) {
@@ -4706,7 +4706,7 @@ static int snd_hdspm_create_controls(struct snd_card *card,
 		break;
 	}
 
-	if (NULL != list) {
+	if (list) {
 		for (idx = 0; idx < limit; idx++) {
 			err = snd_ctl_add(card,
 					snd_ctl_new1(&list[idx], hdspm));
@@ -6069,13 +6069,13 @@ static int snd_hdspm_open(struct snd_pcm_substream *substream)
 		snd_hdspm_capture_subinfo;
 
 	if (playback) {
-		if (hdspm->capture_substream == NULL)
+		if (!hdspm->capture_substream)
 			hdspm_stop_audio(hdspm);
 
 		hdspm->playback_pid = current->pid;
 		hdspm->playback_substream = substream;
 	} else {
-		if (hdspm->playback_substream == NULL)
+		if (!hdspm->playback_substream)
 			hdspm_stop_audio(hdspm);
 
 		hdspm->capture_pid = current->pid;
@@ -6775,9 +6775,9 @@ static int snd_hdspm_create(struct snd_card *card,
 				HDSPM_s2_tco_detect) {
 			hdspm->midiPorts++;
 			hdspm->tco = kzalloc(sizeof(*hdspm->tco), GFP_KERNEL);
-			if (NULL != hdspm->tco) {
+			if (hdspm->tco)
 				hdspm_tco_write(hdspm);
-			}
+
 			dev_info(card->dev, "AIO/RayDAT TCO module found\n");
 		} else {
 			hdspm->tco = NULL;
@@ -6789,9 +6789,9 @@ static int snd_hdspm_create(struct snd_card *card,
 		if (hdspm_read(hdspm, HDSPM_statusRegister) & HDSPM_tco_detect) {
 			hdspm->midiPorts++;
 			hdspm->tco = kzalloc(sizeof(*hdspm->tco), GFP_KERNEL);
-			if (NULL != hdspm->tco) {
+			if (hdspm->tco)
 				hdspm_tco_write(hdspm);
-			}
+
 			dev_info(card->dev, "MADI/AES TCO module found\n");
 		} else {
 			hdspm->tco = NULL;
@@ -6868,7 +6868,7 @@ static int snd_hdspm_create(struct snd_card *card,
 		 * this case, we don't set card->id to avoid collisions
 		 * when running with multiple cards.
 		 */
-		if (NULL == id[hdspm->dev] && hdspm->serial != 0xFFFFFF) {
+		if (!id[hdspm->dev] && hdspm->serial != 0xFFFFFF) {
 			snprintf(card->id, sizeof(card->id),
 				 "HDSPMx%06x", hdspm->serial);
 			snd_card_set_id(card, card->id);
-- 
2.14.0
