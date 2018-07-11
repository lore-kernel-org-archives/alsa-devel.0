From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 2/5] ALSA: usb-audio: Processing Unit controls
	parsing in UAC2
Date: Wed, 11 Jul 2018 13:37:52 +0100
Message-ID: <20180711123755.27182-3-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 254AB26770A
 for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2018 14:38:02 +0200 (CEST)
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

Current support for UAC2 Processing Units does the parsing
as one control per bit in the bitmap. However, the UAC2 spec
defines the controls as bit pairs where b01 means read-only
and b11 means read/write control.

This patch fixes that and uses the helper functions for checking
controls readability/writability when the control is defined as
bit pairs (UAC2 and UAC3).

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a51f2320a3dd..bfb3484096a6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2300,8 +2300,16 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 	for (valinfo = info->values; valinfo->control; valinfo++) {
 		__u8 *controls = uac_processing_unit_bmControls(desc, state->mixer->protocol);
 
-		if (!(controls[valinfo->control / 8] & (1 << ((valinfo->control % 8) - 1))))
-			continue;
+		if (state->mixer->protocol == UAC_VERSION_1) {
+			if (!(controls[valinfo->control / 8] &
+					(1 << ((valinfo->control % 8) - 1))))
+				continue;
+		} else { /* UAC_VERSION_2/3 */
+			if (!uac_v2v3_control_is_readable(controls[valinfo->control / 8],
+							  valinfo->control))
+				continue;
+		}
+
 		map = find_map(state->map, unitid, valinfo->control);
 		if (check_ignored_ctl(map))
 			continue;
@@ -2313,6 +2321,11 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 		cval->val_type = valinfo->val_type;
 		cval->channels = 1;
 
+		if (state->mixer->protocol > UAC_VERSION_1 &&
+		    !uac_v2v3_control_is_writeable(controls[valinfo->control / 8],
+						   valinfo->control))
+			cval->master_readonly = 1;
+
 		/* get min/max values */
 		if (type == UAC_PROCESS_UP_DOWNMIX && cval->control == UAC_UD_MODE_SELECT) {
 			__u8 *control_spec = uac_processing_unit_specific(desc, state->mixer->protocol);
-- 
2.11.0
