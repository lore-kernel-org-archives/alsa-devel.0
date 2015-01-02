From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/21] ALSA: ens1370: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:48 +0100
Message-ID: <1420197895-17696-15-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id CD5D2260542
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:17 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

The various PCM and MIDI allocation functions in this driver take a pointer
to a pointer of a PCM/MIDI object where if this parameter is provided the
newly allocated object is stored. All callers pass NULL though, so remove
the parameter. This makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/ens1370.c | 37 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index d94cb3c..bb1f4d2 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1268,14 +1268,11 @@ static const struct snd_pcm_chmap_elem surround_map[] = {
 	{ }
 };
 
-static int snd_ensoniq_pcm(struct ensoniq *ensoniq, int device,
-			   struct snd_pcm **rpcm)
+static int snd_ensoniq_pcm(struct ensoniq *ensoniq, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(ensoniq->card, CHIP_NAME "/1", device, 1, 1, &pcm);
 	if (err < 0)
 		return err;
@@ -1302,22 +1299,14 @@ static int snd_ensoniq_pcm(struct ensoniq *ensoniq, int device,
 	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				     snd_pcm_std_chmaps, 2, 0, NULL);
 #endif
-	if (err < 0)
-		return err;
-
-	if (rpcm)
-		*rpcm = pcm;
-	return 0;
+	return err;
 }
 
-static int snd_ensoniq_pcm2(struct ensoniq *ensoniq, int device,
-			    struct snd_pcm **rpcm)
+static int snd_ensoniq_pcm2(struct ensoniq *ensoniq, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(ensoniq->card, CHIP_NAME "/2", device, 1, 0, &pcm);
 	if (err < 0)
 		return err;
@@ -1342,12 +1331,7 @@ static int snd_ensoniq_pcm2(struct ensoniq *ensoniq, int device,
 	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				     surround_map, 2, 0, NULL);
 #endif
-	if (err < 0)
-		return err;
-
-	if (rpcm)
-		*rpcm = pcm;
-	return 0;
+	return err;
 }
 
 /*
@@ -2362,14 +2346,11 @@ static struct snd_rawmidi_ops snd_ensoniq_midi_input =
 	.trigger =	snd_ensoniq_midi_input_trigger,
 };
 
-static int snd_ensoniq_midi(struct ensoniq *ensoniq, int device,
-			    struct snd_rawmidi **rrawmidi)
+static int snd_ensoniq_midi(struct ensoniq *ensoniq, int device)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	if (rrawmidi)
-		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(ensoniq->card, "ES1370/1", device, 1, 1, &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, CHIP_NAME);
@@ -2379,8 +2360,6 @@ static int snd_ensoniq_midi(struct ensoniq *ensoniq, int device,
 		SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = ensoniq;
 	ensoniq->rmidi = rmidi;
-	if (rrawmidi)
-		*rrawmidi = rmidi;
 	return 0;
 }
 
@@ -2462,15 +2441,15 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 		return err;
 	}
 #endif
-	if ((err = snd_ensoniq_pcm(ensoniq, 0, NULL)) < 0) {
+	if ((err = snd_ensoniq_pcm(ensoniq, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_ensoniq_pcm2(ensoniq, 1, NULL)) < 0) {
+	if ((err = snd_ensoniq_pcm2(ensoniq, 1)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_ensoniq_midi(ensoniq, 0, NULL)) < 0) {
+	if ((err = snd_ensoniq_midi(ensoniq, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
1.8.0
