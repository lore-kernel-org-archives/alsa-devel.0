From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - verify pin:converter connection on
	unsol event for HSW and VLV
Date: Thu, 12 Jun 2014 14:42:25 +0800
Message-ID: <1402555345-16481-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E866265725
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 08:40:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch will verify the pin's coverter selection for an active stream
when an unsol event reports this pin becomes available again after a display
mode change or hot-plug event.

For Haswell+ and Valleyview: display mode change or hot-plug can change the
transcoder:port connection and make all the involved audio pins share the 1st
converter. So the stream using 1st convertor will flow to multiple pins
but active streams using other converters will fail. This workaround
is to assure the pin selects the right conveter and an assigned converter is
not shared by other unused pins.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index be0a9ee..3e4417b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1594,10 +1594,18 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		 * Re-setup pin and infoframe. This is needed e.g. when
 		 * - sink is first plugged-in (infoframe is not set up if !monitor_present)
 		 * - transcoder can change during stream playback on Haswell
+		 *   and this can make HW reset converter selection on a pin.
 		 */
-		if (eld->eld_valid && !old_eld_valid && per_pin->setup)
+		if (eld->eld_valid && !old_eld_valid && per_pin->setup) {
+			if (is_haswell_plus(codec) || is_valleyview(codec)) {
+				intel_verify_pin_cvt_connect(codec, per_pin);
+				intel_not_share_assigned_cvt(codec, pin_nid,
+							per_pin->mux_idx);
+			}
+
 			hdmi_setup_audio_infoframe(codec, per_pin,
 						   per_pin->non_pcm);
+		}
 	}
 
 	if (eld_changed)
-- 
1.8.1.2
