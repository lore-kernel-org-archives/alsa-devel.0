From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: HDA: Fix automute for Cirrus Logic
	421x
Date: Mon,  2 Jan 2012 12:40:16 +0100
Message-ID: <1325504417-7283-2-git-send-email-david.henningsson@canonical.com>
References: <1325504417-7283-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id F361C246C0
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 12:40:28 +0100 (CET)
In-Reply-To: <1325504417-7283-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

There was a bug in the automute logic causing speakers not to
mute when headphones were plugged in.

Cc: stable@kernel.org
Tested-by: Hsin-Yi Chen <hychen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_cirrus.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 9139558..bde3a94 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -922,16 +922,14 @@ static void cs_automute(struct hda_codec *codec)
 
 	/* mute speakers if spdif or hp jack is plugged in */
 	for (i = 0; i < cfg->speaker_outs; i++) {
+		int pin_ctl = hp_present ? 0 : PIN_OUT;
+		/* detect on spdif is specific to CS421x */
+		if (spdif_present && (spec->vendor_nid == CS421X_VENDOR_NID))
+			pin_ctl = 0;
+
 		nid = cfg->speaker_pins[i];
 		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    hp_present ? 0 : PIN_OUT);
-		/* detect on spdif is specific to CS421x */
-		if (spec->vendor_nid == CS421X_VENDOR_NID) {
-			snd_hda_codec_write(codec, nid, 0,
-					AC_VERB_SET_PIN_WIDGET_CONTROL,
-					spdif_present ? 0 : PIN_OUT);
-		}
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, pin_ctl);
 	}
 	if (spec->gpio_eapd_hp) {
 		unsigned int gpio = hp_present ?
-- 
1.7.5.4
