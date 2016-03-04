From: libin.yang@linux.intel.com
Subject: [PATCH 2/2] ALSA: hda - hdmi defer to register acomp
	eld notifier
Date: Fri,  4 Mar 2016 14:33:43 +0800
Message-ID: <1457073223-73728-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A77E92657B3
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 07:38:12 +0100 (CET)
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Defer to register acomp eld notifier until hdmi audio driver
is fully ready.

After registering eld notifier, gfx driver can use this
callback function to notify audio driver the monitor
connection event. However this action may happen when
audio driver is adding the pins or doing other initialization.
This is not always safe, however. For example, using
per_pin->lock before the lock is initialized.

Let's register the eld notifier after the initialization is done.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b5190e0..9bdb301 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2936,18 +2936,6 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 			is_broxton(codec))
 		codec->core.link_power_control = 1;
 
-	if (codec_has_acomp(codec)) {
-		codec->depop_delay = 0;
-		spec->i915_audio_ops.audio_ptr = codec;
-		/* intel_audio_codec_enable() or intel_audio_codec_disable()
-		 * will call pin_eld_notify with using audio_ptr pointer
-		 * We need make sure audio_ptr is really setup
-		 */
-		wmb();
-		spec->i915_audio_ops.pin_eld_notify = intel_pin_eld_notify;
-		snd_hdac_i915_register_notifier(&spec->i915_audio_ops);
-	}
-
 	if (hdmi_parse_codec(codec) < 0) {
 		if (spec->i915_bound)
 			snd_hdac_i915_exit(&codec->bus->core);
@@ -2969,6 +2957,18 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 
 	init_channel_allocations();
 
+	if (codec_has_acomp(codec)) {
+		codec->depop_delay = 0;
+		spec->i915_audio_ops.audio_ptr = codec;
+		/* intel_audio_codec_enable() or intel_audio_codec_disable()
+		 * will call pin_eld_notify with using audio_ptr pointer
+		 * We need make sure audio_ptr is really setup
+		 */
+		wmb();
+		spec->i915_audio_ops.pin_eld_notify = intel_pin_eld_notify;
+		snd_hdac_i915_register_notifier(&spec->i915_audio_ops);
+	}
+
 	WARN_ON(spec->dyn_pcm_assign && !codec_has_acomp(codec));
 	return 0;
 }
-- 
1.9.1
