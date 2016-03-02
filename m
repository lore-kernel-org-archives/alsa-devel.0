From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - hdmi defer to register acomp eld
	notifier
Date: Wed,  2 Mar 2016 13:19:43 +0800
Message-ID: <1456895983-46529-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id ABAE92606F5
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 06:24:08 +0100 (CET)
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

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index aa2d6a2..a3de50b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2936,13 +2936,6 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 			is_broxton(codec))
 		codec->core.link_power_control = 1;
 
-	if (codec_has_acomp(codec)) {
-		codec->depop_delay = 0;
-		spec->i915_audio_ops.audio_ptr = codec;
-		spec->i915_audio_ops.pin_eld_notify = intel_pin_eld_notify;
-		snd_hdac_i915_register_notifier(&spec->i915_audio_ops);
-	}
-
 	if (hdmi_parse_codec(codec) < 0) {
 		if (spec->i915_bound)
 			snd_hdac_i915_exit(&codec->bus->core);
@@ -2964,6 +2957,13 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 
 	init_channel_allocations();
 
+	if (codec_has_acomp(codec)) {
+		codec->depop_delay = 0;
+		spec->i915_audio_ops.audio_ptr = codec;
+		spec->i915_audio_ops.pin_eld_notify = intel_pin_eld_notify;
+		snd_hdac_i915_register_notifier(&spec->i915_audio_ops);
+	}
+
 	WARN_ON(spec->dyn_pcm_assign && !codec_has_acomp(codec));
 	return 0;
 }
-- 
1.9.1
