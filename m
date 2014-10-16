From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being used
	on one DAC when there are two DACs
Date: Thu, 16 Oct 2014 15:33:45 +0200
Message-ID: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF3E2605C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 15:33:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In the scenario where there is one "Line Out", one "Speaker" and one
"Headphone", and there are only two DACs, two outputs will share a DAC.
Currently any mixer on such a DAC will get the "PCM" name, which is
misleading. Instead use "Headphone+LO" or "Speaker+LO" to better
specify what the volume actually controls.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_generic.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 64220c0..1d742ea 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1038,6 +1038,19 @@ static const char *get_line_out_pfx(struct hda_codec *codec, int ch,
 			break;
 		*index = ch;
 		return "Headphone";
+	case AUTO_PIN_LINE_OUT:
+		/* This deals with the case where we have two DACs and 
+		 * one LO, one HP and one Speaker */
+		if (!ch && cfg->speaker_outs && cfg->hp_outs) {
+			bool hp_lo_shared = !path_has_mixer(codec, spec->hp_paths[0], ctl_type);
+			bool spk_lo_shared = !path_has_mixer(codec, spec->speaker_paths[0], ctl_type);
+			if (hp_lo_shared && spk_lo_shared) 
+				return spec->vmaster_mute.hook ? "PCM" : "Master";
+			if (hp_lo_shared)
+				return "Headphone+LO";
+			if (spk_lo_shared)
+				return "Speaker+LO";
+		}
 	}
 
 	/* for a single channel output, we don't have to name the channel */
-- 
1.9.1
