From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] improved snd-aloop quality when
	using	certain samplerates and kernel HZ
Date: Thu, 6 Mar 2008 21:51:24 +0100
Message-ID: <20080306205124.GC32692@mathematik.uni-freiburg.de>
References: <20080220141906.GA15096@mathematik.uni-freiburg.de>
	<s5h3arnpq4i.wl%tiwai@suse.de>
	<20080221000601.GA4829@mathematik.uni-freiburg.de>
	<s5hmypusssj.wl%tiwai@suse.de>
	<20080222180528.GD6860@mathematik.uni-freiburg.de>
	<s5h7igps3nv.wl%tiwai@suse.de>
	<20080301115506.GA7175@mathematik.uni-freiburg.de>
	<s5hve468o55.wl%tiwai@suse.de>
	<20080301233503.GA6175@mathematik.uni-freiburg.de>
	<s5h7igf3l71.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 72EEF244CF
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 21:51:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7igf3l71.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Also, it'd be appreciated if you follow the standard rule for
thank you for pointing this out. will try my best.
patch is relative to current hg-tree.

ahmet

snd-aloop - more cleanups

moved module parameter pcm_substreams range check code around, to prevent=
 catastrophe.
removed bogus module parameter pcm_devs code - aloop creates only one pai=
r of devices.
allowed float_le, too.
removed obsolete code.

Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-driver-hg-aloop-ainan-patch5.diff"

diff -r 6def4892d3f5 drivers/aloop-kernel.c
--- a/drivers/aloop-kernel.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/drivers/aloop-kernel.c	Thu Mar 06 21:24:24 2008 +0100
@@ -39,9 +39,7 @@ static int index[SNDRV_CARDS] = SNDRV_DE
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
-static int pcm_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};
-/* static int midi_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2}; */
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for loopback soundcard.");
@@ -49,12 +47,8 @@ MODULE_PARM_DESC(id, "ID string for loop
 MODULE_PARM_DESC(id, "ID string for loopback soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable this loopback soundcard.");
-module_param_array(pcm_devs, int, NULL, 0444);
-MODULE_PARM_DESC(pcm_devs, "PCM devices # (0-4) for loopback driver.");
 module_param_array(pcm_substreams, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-8) for loopback driver.");
-/* module_param_array(midi_devs, int, NULL, 0444);
- * MODULE_PARM_DESC(midi_devs, "MIDI devices # (0-2) for loopback driver."); */
 
 typedef struct snd_card_loopback_cable {
 	struct snd_pcm_substream *playback;
@@ -220,7 +214,8 @@ static struct snd_pcm_hardware snd_card_
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE),
+	.formats =		(SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE |
+				 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_FLOAT_LE),
 	.rates =		(SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_192000),
 	.rate_min =		8000,
 	.rate_max =		192000,
@@ -395,17 +390,11 @@ static int __init snd_card_loopback_pcm(
 	struct snd_pcm *pcm;
 	int err;
 
-	if (0 == device) {
-		if ((err = snd_pcm_new(loopback->card, "Loopback PCM", device, substreams, substreams, &pcm)) < 0)
-			return err;
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_loopback_playback_ops);
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_loopback_capture_ops);
-	} else {
-		if ((err = snd_pcm_new(loopback->card, "Loopback PCM", device, substreams, substreams, &pcm)) < 0)
-			return err;
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_loopback_playback_ops);
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_loopback_capture_ops);
-	}
+	if ((err = snd_pcm_new(loopback->card, "Loopback PCM", device, substreams, substreams, &pcm)) < 0)
+		return err;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_card_loopback_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_card_loopback_capture_ops);
+
 	pcm->private_data = loopback;
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "Loopback PCM");
@@ -435,6 +424,11 @@ static int __init snd_card_loopback_prob
 		return -ENOMEM;
 	loopback = (struct snd_card_loopback *)card->private_data;
 
+	if (pcm_substreams[dev] < 1)
+		pcm_substreams[dev] = 1;
+	if (pcm_substreams[dev] > MAX_PCM_SUBSTREAMS)
+		pcm_substreams[dev] = MAX_PCM_SUBSTREAMS;
+
 	for (subdev = 0; subdev < pcm_substreams[dev]; subdev++) {
 		for (half = 0; half < 2; half++) {
 			loopback->cables[subdev][half].playback = NULL;
@@ -450,10 +444,6 @@ static int __init snd_card_loopback_prob
 	}
 	
 	loopback->card = card;
-	if (pcm_substreams[dev] < 1)
-		pcm_substreams[dev] = 1;
-	if (pcm_substreams[dev] > MAX_PCM_SUBSTREAMS)
-		pcm_substreams[dev] = MAX_PCM_SUBSTREAMS;
 	if ((err = snd_card_loopback_pcm(loopback, 0, pcm_substreams[dev])) < 0)
 		goto __nodev;
 	if ((err = snd_card_loopback_pcm(loopback, 1, pcm_substreams[dev])) < 0)

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--EeQfGwPcQSOJBaQU--
