From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Disable IDT eapd_switch if there
	are no internal speakers
Date: Thu, 14 Mar 2013 10:42:00 +0100
Message-ID: <1363254120-14508-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 20E09265FC8
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 10:41:56 +0100 (CET)
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
Cc: 1155016@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

If there are no internal speakers, we should not turn the eapd switch
off, because it might be necessary to keep high for Headphone.

BugLink: https://bugs.launchpad.net/bugs/1155016
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_sigmatel.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Hi Takashi,

I encountered the bug when working with a pre-release machine (so no alsa-info, unfortunately).

Feel free to commit if you think this is a good idea. Or can you think of a use case
where this would cause a regression?

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index d57c81e..66200ea8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3524,6 +3524,31 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
+	/* Don't GPIO-mute speakers if there are no internal speakers, because
+	   the GPIO might be necessary for Headphone */
+	if (spec->eapd_switch) {
+		hda_nid_t *nid_pin;
+		int nids, i;
+		bool found = false;
+		if (spec->gen.autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT) {
+			nid_pin = spec->gen.autocfg.line_out_pins;
+			nids = spec->gen.autocfg.line_outs;
+		} else {
+			nid_pin = spec->gen.autocfg.speaker_pins;
+			nids = spec->gen.autocfg.speaker_outs;
+		}
+		for (i = 0; i < nids; i++) {
+			unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid_pin[i]);
+			unsigned int attr = snd_hda_get_input_pin_attr(def_conf);
+			if (attr == INPUT_PIN_ATTR_INT) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			spec->eapd_switch = 0;
+	}
+
 	/* minimum value is actually mute */
 	spec->gen.vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
 
-- 
1.7.9.5
