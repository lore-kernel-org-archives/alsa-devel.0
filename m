From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 1/6] sound/pci/hda: Fix Amp-In count for widgets with
 implied selector
Date: Thu, 05 Apr 2012 15:29:56 +0200
Message-ID: <1333632596.4159.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

A selector widget with AC_WCAP_IN_AMP has multiple input amplifiers (if
the selector widget would have only one common amp, it would be labeled
as "output amplifier" instead). This is just like mixer widgets.

If a non-mixer/selector widget has an input amplifier, it is only one
input amplifier, even if it has a connection list with more than one
entry. The implied selector is placed before the single input amplifier.

At least that is how I read the HDA specs, and what Conexant implements in
their CX20549 codec.

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 254ab52..9b942f0 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -653,7 +653,7 @@ static void print_codec_info(struct snd_info_entry *entry,
 			snd_iprintf(buffer, "  Amp-In vals: ");
 			print_amp_vals(buffer, codec, nid, HDA_INPUT,
 				       wid_caps & AC_WCAP_STEREO,
-				       wid_type == AC_WID_PIN ? 1 : conn_len);
+				       (wid_type == AC_WID_AUD_SEL || wid_type == AC_WID_AUD_MIX) ? conn_len : 1);
 		}
 		if (wid_caps & AC_WCAP_OUT_AMP) {
 			snd_iprintf(buffer, "  Amp-Out caps: ");
-- 
1.7.9.1
