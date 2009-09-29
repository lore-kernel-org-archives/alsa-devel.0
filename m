From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/1] Echoaudio: fix broken Mia driver
Date: Tue, 29 Sep 2009 22:21:28 +0200
Message-ID: <20090929222128.06c0ba9a@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by alsa0.perex.cz (Postfix) with ESMTP id B273110380C
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 22:21:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This change:
http://git.alsa-project.org/?p=alsa-kernel.git;a=blobdiff;f=sound/pci/echoaudio/echoaudio.c;h=4b70ea1e4c9fa3dc903dec8cf69235c97c2173ad;hp=8dbc5c4ba421a03dd128050dbd271616efdee3ae;hb=9f5d790d1b0af8e3705df12fd5d49a1df2a45c47;hpb=041b62374c7fedc11a8a1eeda2868612d3d1436c
broke the Mia driver because it removed the line-out control interface from
all vmixer cards. But the Mia has that (undocumented!!) control and after
the change it is impossible to raise the volume. I tested the driver with
my IndigoIOx that was supposed to have the same set of controls... sorry.
I hope it's not too late to merge this patch in linux-2.6.32.

----------

Re-enable the line-out control for the Mia card.

Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -u alsa-driver-1.0.21/alsa-kernel/pci/echoaudio__orig/echoaudio.c alsa-driver-1.0.21/alsa-kernel/pci/echoaudio/echoaudio.c
--- alsa-driver-1.0.21/alsa-kernel/pci/echoaudio__orig/echoaudio.c	2009-08-28 13:41:39.000000000 +0200
+++ alsa-driver-1.0.21/alsa-kernel/pci/echoaudio/echoaudio.c	2009-09-29 21:55:48.000000000 +0200
@@ -950,7 +950,7 @@
 	Control interface
 ******************************************************************************/
 
-#ifndef ECHOCARD_HAS_VMIXER
+#if !defined(ECHOCARD_HAS_VMIXER) || defined(ECHOCARD_HAS_LINE_OUT_GAIN)
 
 /******************* PCM output volume *******************/
 static int snd_echo_output_gain_info(struct snd_kcontrol *kcontrol,
@@ -1003,6 +1003,19 @@
 	return changed;
 }
 
+#ifdef ECHOCARD_HAS_LINE_OUT_GAIN
+/* On the Mia this one controls the line-out volume */
+static struct snd_kcontrol_new snd_echo_line_output_gain __devinitdata = {
+	.name = "Line Playback Volume",
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | 
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	.info = snd_echo_output_gain_info,
+	.get = snd_echo_output_gain_get,
+	.put = snd_echo_output_gain_put,
+	.tlv = {.p = db_scale_output_gain},
+};
+#else
 static struct snd_kcontrol_new snd_echo_pcm_output_gain __devinitdata = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1012,9 +1025,10 @@
 	.put = snd_echo_output_gain_put,
 	.tlv = {.p = db_scale_output_gain},
 };
-
 #endif
 
+#endif /* !ECHOCARD_HAS_VMIXER || ECHOCARD_HAS_LINE_OUT_GAIN */
+
 
 
 #ifdef ECHOCARD_HAS_INPUT_GAIN
@@ -2030,10 +2044,14 @@
 	snd_echo_vmixer.count = num_pipes_out(chip) * num_busses_out(chip);
 	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_vmixer, chip))) < 0)
 		goto ctl_error;
-#else
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_pcm_output_gain, chip))) < 0)
+#ifdef ECHOCARD_HAS_LINE_OUT_GAIN
+	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_line_output_gain, chip))) < 0)
 		goto ctl_error;
 #endif
+#else /* ECHOCARD_HAS_VMIXER */
+	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_pcm_output_gain, chip))) < 0)
+		goto ctl_error;
+#endif /* ECHOCARD_HAS_VMIXER */
 
 #ifdef ECHOCARD_HAS_INPUT_GAIN
 	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_line_input_gain, chip))) < 0)
diff -u alsa-driver-1.0.21/alsa-kernel/pci/echoaudio__orig/mia.c alsa-driver-1.0.21/alsa-kernel/pci/echoaudio/mia.c
--- alsa-driver-1.0.21/alsa-kernel/pci/echoaudio__orig/mia.c	2009-08-28 13:41:39.000000000 +0200
+++ alsa-driver-1.0.21/alsa-kernel/pci/echoaudio/mia.c	2009-09-29 21:55:48.000000000 +0200
@@ -29,6 +29,7 @@
 #define ECHOCARD_HAS_ADAT	FALSE
 #define ECHOCARD_HAS_STEREO_BIG_ENDIAN32
 #define ECHOCARD_HAS_MIDI
+#define ECHOCARD_HAS_LINE_OUT_GAIN
 
 /* Pipe indexes */
 #define PX_ANALOG_OUT	0	/* 8 */



--
Giuliano.
