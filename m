From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 5/5] ALSA: usb-audio: Tidy up logic for
	Processing Unit min/max values
Date: Wed, 11 Jul 2018 13:37:55 +0100
Message-ID: <20180711123755.27182-6-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8DD267712
 for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2018 14:38:03 +0200 (CEST)
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch refactors the processing units min/max calculation logic
for the mixer controls and fixes an issue where the Mode Select
checking of the Up/Down mixers doesn't differentiate between the
UAC1 and UAC2 Control Selector (0x02) and the UAC3 one which is
different (0x01).

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 58 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 87f18cb74ca3..73e811f86a95 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2376,25 +2376,49 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 			cval->master_readonly = 1;
 
 		/* get min/max values */
-		if (type == UAC_PROCESS_UP_DOWNMIX && cval->control == UAC_UD_MODE_SELECT) {
-			__u8 *control_spec = uac_processing_unit_specific(desc, state->mixer->protocol);
-			/* FIXME: hard-coded */
-			cval->min = 1;
-			cval->max = control_spec[0];
-			cval->res = 1;
-			cval->initialized = 1;
-		} else {
-			if (type == USB_XU_CLOCK_RATE) {
-				/*
-				 * E-Mu USB 0404/0202/TrackerPre/0204
-				 * samplerate control quirk
-				 */
-				cval->min = 0;
-				cval->max = 5;
+		switch (type) {
+		case UAC_PROCESS_UP_DOWNMIX: {
+			bool mode_sel = false;
+
+			switch (state->mixer->protocol) {
+			case UAC_VERSION_1:
+			case UAC_VERSION_2:
+			default:
+				if (cval->control == UAC_UD_MODE_SELECT)
+					mode_sel = true;
+				break;
+			case UAC_VERSION_3:
+				if (cval->control == UAC3_UD_MODE_SELECT)
+					mode_sel = true;
+				break;
+			}
+
+			if (mode_sel) {
+				__u8 *control_spec = uac_processing_unit_specific(desc,
+								state->mixer->protocol);
+				cval->min = 1;
+				cval->max = control_spec[0];
 				cval->res = 1;
 				cval->initialized = 1;
-			} else
-				get_min_max(cval, valinfo->min_value);
+				break;
+			}
+
+			get_min_max(cval, valinfo->min_value);
+			break;
+		}
+		case USB_XU_CLOCK_RATE:
+			/*
+			 * E-Mu USB 0404/0202/TrackerPre/0204
+			 * samplerate control quirk
+			 */
+			cval->min = 0;
+			cval->max = 5;
+			cval->res = 1;
+			cval->initialized = 1;
+			break;
+		default:
+			get_min_max(cval, valinfo->min_value);
+			break;
 		}
 
 		kctl = snd_ctl_new1(&mixer_procunit_ctl, cval);
-- 
2.11.0
