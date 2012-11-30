From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: hda - Disable auto-mic as default
	for non-laptop machines
Date: Fri, 30 Nov 2012 09:16:01 +0100
Message-ID: <1354263363-25398-4-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354263363-25398-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 97393265B8D
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:16:22 +0100 (CET)
In-Reply-To: <1354263363-25398-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

To be conservative, turn off the auto-mic as default for non-laptop
machines in order to be compatible with the older kernel.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa32dd9..fc70c0c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1238,6 +1238,10 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 		    spec->am_entry[2].pin);
 
 	alc_kcontrol_new(spec, "Auto-Mic Mode", &alc_automic_mode_enum);
+
+	/* enable auto mic only on machines with an internal mic as default */
+	if (spec->am_entry[0].attr != INPUT_PIN_ATTR_INT)
+		spec->auto_mic = 0;
 }
 
 /* check the availabilities of auto-mute and auto-mic switches */
@@ -2401,7 +2405,7 @@ static int alc_build_pcms(struct hda_codec *codec)
 	 * model, configure a second analog capture-only PCM.
 	 */
 	have_multi_adcs = (spec->num_adc_nids > 1) &&
-		!spec->dyn_adc_switch && !spec->auto_mic &&
+		!spec->dyn_adc_switch && !spec->auto_mic_valid_imux &&
 		(!spec->input_mux || spec->input_mux->num_items > 1);
 	/* Additional Analaog capture for index #2 */
 	if (spec->alt_dac_nid || have_multi_adcs) {
@@ -4114,6 +4118,7 @@ static void alc_remove_invalid_adc_nids(struct hda_codec *codec)
 			       codec->chip_name, spec->private_adc_nids[0]);
 			spec->num_adc_nids = 1;
 			spec->auto_mic = 0;
+			spec->auto_mic_valid_imux = 0;
 			return;
 		}
 	} else if (nums != spec->num_adc_nids) {
@@ -4281,7 +4286,7 @@ static void set_capture_mixer(struct hda_codec *codec)
 
 		if (spec->input_mux && spec->input_mux->num_items > 1)
 			mux = 1;
-		if (spec->auto_mic || spec->dyn_adc_switch) {
+		if (spec->auto_mic_valid_imux || spec->dyn_adc_switch) {
 			num_adcs = 1;
 			mux = 1;
 		}
-- 
1.8.0.1
