From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/21] ALSA: gus: Remove always NULL parameters
Date: Fri,  2 Jan 2015 12:24:39 +0100
Message-ID: <1420197895-17696-6-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 805512604BD
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:04 +0100 (CET)
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

snd_gf1_pcm_new() and snd_gf1_rawmidi_new() take a pointer to a pointer of a
PCM/MIDI where if this parameter is provided the newly allocated object is
stored. All callers pass NULL though, so remove the parameter. This makes
the code a bit cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/gus.h        | 4 ++--
 sound/isa/gus/gus_pcm.c    | 6 +-----
 sound/isa/gus/gus_uart.c   | 6 +-----
 sound/isa/gus/gusclassic.c | 4 ++--
 sound/isa/gus/gusextreme.c | 2 +-
 sound/isa/gus/gusmax.c     | 4 ++--
 sound/isa/gus/interwave.c  | 4 ++--
 7 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/include/sound/gus.h b/include/sound/gus.h
index 42905d8..06bbdc2 100644
--- a/include/sound/gus.h
+++ b/include/sound/gus.h
@@ -591,7 +591,7 @@ int snd_gf1_new_mixer(struct snd_gus_card * gus);
 
 /* gus_pcm.c */
 
-int snd_gf1_pcm_new(struct snd_gus_card * gus, int pcm_dev, int control_index, struct snd_pcm ** rpcm);
+int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index);
 
 #ifdef CONFIG_SND_DEBUG
 extern void snd_gf1_print_voice_registers(struct snd_gus_card * gus);
@@ -620,7 +620,7 @@ void snd_gus_irq_profile_init(struct snd_gus_card *gus);
 
 /* gus_uart.c */
 
-int snd_gf1_rawmidi_new(struct snd_gus_card * gus, int device, struct snd_rawmidi **rrawmidi);
+int snd_gf1_rawmidi_new(struct snd_gus_card *gus, int device);
 
 /* gus_dram.c */
 int snd_gus_dram_write(struct snd_gus_card *gus, char __user *ptr,
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 2dcf45b..25f6788 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -849,7 +849,7 @@ static struct snd_pcm_ops snd_gf1_pcm_capture_ops = {
 	.pointer =	snd_gf1_pcm_capture_pointer,
 };
 
-int snd_gf1_pcm_new(struct snd_gus_card * gus, int pcm_dev, int control_index, struct snd_pcm ** rpcm)
+int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 {
 	struct snd_card *card;
 	struct snd_kcontrol *kctl;
@@ -857,8 +857,6 @@ int snd_gf1_pcm_new(struct snd_gus_card * gus, int pcm_dev, int control_index, s
 	struct snd_pcm_substream *substream;
 	int capture, err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	card = gus->card;
 	capture = !gus->interwave && !gus->ess_flag && !gus->ace_flag ? 1 : 0;
 	err = snd_pcm_new(card,
@@ -903,8 +901,6 @@ int snd_gf1_pcm_new(struct snd_gus_card * gus, int pcm_dev, int control_index, s
 		return err;
 	kctl->id.index = control_index;
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
diff --git a/sound/isa/gus/gus_uart.c b/sound/isa/gus/gus_uart.c
index 21cc42e..3992912 100644
--- a/sound/isa/gus/gus_uart.c
+++ b/sound/isa/gus/gus_uart.c
@@ -241,13 +241,11 @@ static struct snd_rawmidi_ops snd_gf1_uart_input =
 	.trigger =	snd_gf1_uart_input_trigger,
 };
 
-int snd_gf1_rawmidi_new(struct snd_gus_card * gus, int device, struct snd_rawmidi ** rrawmidi)
+int snd_gf1_rawmidi_new(struct snd_gus_card *gus, int device)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	if (rrawmidi)
-		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(gus->card, "GF1", device, 1, 1, &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, gus->interwave ? "AMD InterWave" : "GF1");
@@ -256,7 +254,5 @@ int snd_gf1_rawmidi_new(struct snd_gus_card * gus, int device, struct snd_rawmid
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT | SNDRV_RAWMIDI_INFO_INPUT | SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = gus;
 	gus->midi_uart = rmidi;
-	if (rrawmidi)
-		*rrawmidi = rmidi;
 	return err;
 }
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index 7ce29ff..f001971 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -181,12 +181,12 @@ static int snd_gusclassic_probe(struct device *dev, unsigned int n)
 	if (error < 0)
 		goto out;
 
-	error = snd_gf1_pcm_new(gus, 0, 0, NULL);
+	error = snd_gf1_pcm_new(gus, 0, 0);
 	if (error < 0)
 		goto out;
 
 	if (!gus->ace_flag) {
-		error = snd_gf1_rawmidi_new(gus, 0, NULL);
+		error = snd_gf1_rawmidi_new(gus, 0);
 		if (error < 0)
 			goto out;
 	}
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index acc6552..693d95f 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -295,7 +295,7 @@ static int snd_gusextreme_probe(struct device *dev, unsigned int n)
 	snd_component_add(card, "ES1688");
 
 	if (pcm_channels[n] > 0) {
-		error = snd_gf1_pcm_new(gus, 1, 1, NULL);
+		error = snd_gf1_pcm_new(gus, 1, 1);
 		if (error < 0)
 			goto out;
 	}
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 39df36c..b2b3734 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -322,14 +322,14 @@ static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 		goto _err;
 
 	if (pcm_channels[dev] > 0) {
-		if ((err = snd_gf1_pcm_new(gus, 1, 1, NULL)) < 0)
+		if ((err = snd_gf1_pcm_new(gus, 1, 1)) < 0)
 			goto _err;
 	}
 	err = snd_gusmax_mixer(wss);
 	if (err < 0)
 		goto _err;
 
-	err = snd_gf1_rawmidi_new(gus, 0, NULL);
+	err = snd_gf1_rawmidi_new(gus, 0);
 	if (err < 0)
 		goto _err;
 
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index ad55e5c..8ea54a7 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -711,7 +711,7 @@ static int snd_interwave_probe(struct snd_card *card, int dev)
 		return err;
 
 	if (pcm_channels[dev] > 0) {
-		err = snd_gf1_pcm_new(gus, 1, 1, NULL);
+		err = snd_gf1_pcm_new(gus, 1, 1);
 		if (err < 0)
 			return err;
 	}
@@ -740,7 +740,7 @@ static int snd_interwave_probe(struct snd_card *card, int dev)
 #endif
 
 	gus->uart_enable = midi[dev];
-	if ((err = snd_gf1_rawmidi_new(gus, 0, NULL)) < 0)
+	if ((err = snd_gf1_rawmidi_new(gus, 0)) < 0)
 		return err;
 
 #ifndef SNDRV_STB
-- 
1.8.0
