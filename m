From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/2] Echoaudio: remove line-out volume from
	vmixer cards
Date: Sun, 15 Mar 2009 21:33:34 +0100
Message-ID: <20090315213334.e6bc8928.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DC771037EA
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 21:33:25 +0100 (CET)
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

There is a long standing bug in the drivers for cards with a vmixer because
I overlooked a detail in the c++ generic driver by echoaudio. Those cards
do not have a line-out volume control. It is a virtual control provided by
the generic driver. The bug is harmless because the DSP just ignores the
command to change the volume.
*NB:* It breaks alsa-tools/echomixer. A patch for it will follow.


This patch removes the line-out volume control from vmixer-equipped cards.

Signed-off-by Giuliano Pochini <pochini@shiny.it>

diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/echoaudio.c alsa-driver-1.0.19/sound/pci/echoaudio/echoaudio.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/echoaudio.c	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/echoaudio.c	2009-03-15 16:51:17.000000000 +0100
@@ -950,6 +950,8 @@ static int __devinit snd_echo_new_pcm(st
 	Control interface
 ******************************************************************************/
 
+#ifndef ECHOCARD_HAS_VMIXER
+
 /******************* PCM output volume *******************/
 static int snd_echo_output_gain_info(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
@@ -1001,18 +1003,6 @@ static int snd_echo_output_gain_put(stru
 	return changed;
 }
 
-#ifdef ECHOCARD_HAS_VMIXER
-/* On Vmixer cards this one controls the line-out volume */
-static struct snd_kcontrol_new snd_echo_line_output_gain __devinitdata = {
-	.name = "Line Playback Volume",
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-	.info = snd_echo_output_gain_info,
-	.get = snd_echo_output_gain_get,
-	.put = snd_echo_output_gain_put,
-	.tlv = {.p = db_scale_output_gain},
-};
-#else
 static struct snd_kcontrol_new snd_echo_pcm_output_gain __devinitdata = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1022,6 +1012,7 @@ static struct snd_kcontrol_new snd_echo_
 	.put = snd_echo_output_gain_put,
 	.tlv = {.p = db_scale_output_gain},
 };
+
 #endif
 
 
@@ -2037,8 +2028,6 @@ static int __devinit snd_echo_probe(stru
 
 #ifdef ECHOCARD_HAS_VMIXER
 	snd_echo_vmixer.count = num_pipes_out(chip) * num_busses_out(chip);
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_line_output_gain, chip))) < 0)
-		goto ctl_error;
 	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_vmixer, chip))) < 0)
 		goto ctl_error;
 #else




--
Giuliano.
