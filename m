From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92hd71bxx PC Beep
Date: Wed, 09 Jul 2008 21:41:44 -0400
Message-ID: <487568D8.7060700@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id E338024527
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 03:41:57 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Added volume controls for the analog PC Beep on 92hd71bxx codecs.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index c4f3489..42908e6 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -825,6 +825,9 @@ static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),

+	HDA_CODEC_VOLUME("PC Beep Volume", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Beep Switch", 0x17, 0x2, HDA_INPUT),
+
 	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
 	{ } /* end */
