From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Add AMD HDMI verbs
Date: Tue,  5 Nov 2013 05:12:16 +0100
Message-ID: <1383624736-4195-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 067C3261A3B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 05:12:18 +0100 (CET)
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

Source of information: http://www.x.org/docs/AMD/AMD_HDA_verbs_v2.pdf

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hda-spec.c b/hda-spec.c
index e4bb547..d70e54b 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -213,6 +213,49 @@ static struct xhda_verb_table vt2002p_verbs[] = {
 	{ } /* terminator */
 };
 
+static struct xhda_verb_table amdhdmi_verbs[] = {
+	/* Refer to AMD HDA Verbs specification */
+	{ 0x776, set_cached_verb, "amdhdmi_set_descriptor" },
+	{ 0xf76, get_cached_verb, "amdhdmi_get_descriptor" },
+	{ 0x770, set_cached_verb, "amdhdmi_set_ddm_cvt_sync" },
+	{ 0xf70, get_cached_verb, "amdhdmi_get_speaker_alloc/cvt_sync" },
+	{ 0xf93, get_cached_verb, "amdhdmi_get_ddm_audio_assoc" },
+
+	{ 0x777, set_cached_verb, "amdhdmi_set_multich_en_01" },
+	{ 0xf77, get_cached_verb, "amdhdmi_get_multich_en_01" },
+	{ 0x778, set_cached_verb, "amdhdmi_set_multich_en_23" },
+	{ 0xf78, get_cached_verb, "amdhdmi_get_multich_en_23" },
+	{ 0x779, set_cached_verb, "amdhdmi_set_multich_en_45" },
+	{ 0xf79, get_cached_verb, "amdhdmi_get_multich_en_45" },
+	{ 0x77a, set_cached_verb, "amdhdmi_set_multich_en_67" },
+	{ 0xf7a, get_cached_verb, "amdhdmi_get_multich_en_67" },
+
+	{ 0x771, set_cached_verb, "amdhdmi_set_channel_alloc" },
+	{ 0xf71, get_cached_verb, "amdhdmi_get_channel_alloc" },
+	{ 0x772, set_cached_verb, "amdhdmi_set_downmix_info" },
+	{ 0xf72, get_cached_verb, "amdhdmi_get_downmix_info" },
+	{ 0x789, set_cached_verb, "amdhdmi_set_multich_mode" },
+	{ 0xf89, get_cached_verb, "amdhdmi_get_multich_mode" },
+
+	{ 0x785, set_cached_verb, "amdhdmi_set_multich_en_1" },
+	{ 0xf85, get_cached_verb, "amdhdmi_get_multich_en_1" },
+	{ 0x786, set_cached_verb, "amdhdmi_set_multich_en_3" },
+	{ 0xf86, get_cached_verb, "amdhdmi_get_multich_en_3" },
+	{ 0x787, set_cached_verb, "amdhdmi_set_multich_en_5" },
+	{ 0xf87, get_cached_verb, "amdhdmi_get_multich_en_5" },
+	{ 0x788, set_cached_verb, "amdhdmi_set_multich_en_7" },
+	{ 0xf88, get_cached_verb, "amdhdmi_get_multich_en_7" },
+
+	{ 0x77c, set_cached_verb, "amdhdmi_set_hbr_control" },
+	{ 0xf7c, get_cached_verb, "amdhdmi_get_hbr_control" },
+	{ 0xf7b, get_cached_verb, "amdhdmi_get_lipsync" },
+	{ 0x780, set_cached_verb, "amdhdmi_set_sinkinfo_index" },
+	{ 0xf80, get_cached_verb, "amdhdmi_get_sinkinfo_index" },
+	{ 0xf81, get_cached_verb, "amdhdmi_get_sinkinfo_data" },
+
+	{ } /* terminator */
+};
+
 /*
  */
 
@@ -351,6 +394,8 @@ static struct verb_ext_list extensions[] = {
 	{ .id = 0x11060446, .verbs = vt2002p_verbs },
 	{ .id = 0x11068446, .verbs = vt2002p_verbs },
 
+	{ .id = 0x1002aa01, .verbs = amdhdmi_verbs },
+
 	{ }
 };
 
-- 
1.7.9.5
