From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: corrected invalid mixer values
Date: Sat, 11 Oct 2008 13:52:43 -0400
Message-ID: <48F0E7EB.6010300@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 2614E103827
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Oct 2008 19:53:11 +0200 (CEST)
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

Corrected invalid mixer index values on the 92hd71bxxx codec branch.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 1e7b6c1..c590655 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -1114,11 +1114,11 @@ static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	HDA_CODEC_MUTE("PC Beep Switch", 0x17, 0x2, HDA_INPUT),
 	*/

-	HDA_CODEC_MUTE("Import0 Mux Capture Switch", 0x17, 0x3, HDA_INPUT),
-	HDA_CODEC_VOLUME("Import0 Mux Capture Volume", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Import0 Mux Capture Switch", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Import0 Mux Capture Volume", 0x17, 0x0, HDA_INPUT),

-	HDA_CODEC_MUTE("Import1 Mux Capture Switch", 0x17, 0x3, HDA_INPUT),
-	HDA_CODEC_VOLUME("Import1 Mux Capture Volume", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Import1 Mux Capture Switch", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Import1 Mux Capture Volume", 0x17, 0x1, HDA_INPUT),

 	HDA_CODEC_MUTE("DAC0 Capture Switch", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_VOLUME("DAC0 Capture Volume", 0x17, 0x3, HDA_INPUT),
