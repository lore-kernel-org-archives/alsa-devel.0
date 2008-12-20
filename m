From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: fix incorrect mixer index values for
	92hd83xx
Date: Sat, 20 Dec 2008 17:47:24 -0500
Message-ID: <494D75FC.1030904@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 98B621037EC
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 23:47:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fixed incorrect mixer index values for 92hd83xx codec's audio
input mixer.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 70181d5..efa1fb0 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -1101,21 +1101,21 @@ static struct snd_kcontrol_new stac92hd83xxx_mixer[] = {
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x18, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x18, 0x0, HDA_OUTPUT),
 
-	HDA_CODEC_VOLUME("DAC0 Capture Volume", 0x1b, 0, HDA_INPUT),
-	HDA_CODEC_MUTE("DAC0 Capture Switch", 0x1b, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("DAC0 Capture Volume", 0x1b, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("DAC0 Capture Switch", 0x1b, 0x3, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("DAC1 Capture Volume", 0x1b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("DAC1 Capture Switch", 0x1b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("DAC1 Capture Volume", 0x1b, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("DAC1 Capture Switch", 0x1b, 0x4, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Front Mic Capture Volume", 0x1b, 0x2, HDA_INPUT),
-	HDA_CODEC_MUTE("Front Mic Capture Switch", 0x1b, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Capture Volume", 0x1b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Capture Switch", 0x1b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Line In Capture Volume", 0x1b, 0x3, HDA_INPUT),
-	HDA_CODEC_MUTE("Line In Capture Switch", 0x1b, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Capture Volume", 0x1b, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Line In Capture Switch", 0x1b, 0x2, HDA_INPUT),
 
 	/*
-	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1b, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Capture Switch", 0x1b 0x4, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Capture Switch", 0x1b 0x1, HDA_INPUT),
 	*/
 	{ } /* end */
 };
