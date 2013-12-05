From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - skip depop delay before D3 for
	Haswell and Valleyview2 display codec
Date: Thu,  5 Dec 2013 18:35:48 -0500
Message-ID: <8a2f108353c44aae236c0c273c2d63f101f17418.1386286480.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 907062608ED
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 07:31:58 +0100 (CET)
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

This patch skips the default depop delay before D3 for Haswell (10 ms) and
Valleyview2 (100 ms) display codec, to reduce codec suspend time.

The analog part of display audio is implemented in the external display. Some
displays have weak pop noise while others not when suspending, no matter there
is the default delay or not.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 2306645..e14359a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2022,6 +2022,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		intel_haswell_fixup_enable_dp12(codec);
 	}
 
+	if (is_haswell(codec) || is_valleyview(codec)) {
+		codec->depop_delay = 0;
+	}
+
 	if (hdmi_parse_codec(codec) < 0) {
 		codec->spec = NULL;
 		kfree(spec);
-- 
1.8.1.2
