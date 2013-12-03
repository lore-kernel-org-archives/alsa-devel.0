From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - fixup ALC262 to skip depop delay
	before D3 on Intel BayleyBay
Date: Mon,  2 Dec 2013 22:26:03 -0500
Message-ID: <b68db73f280c79fe67eb102a4b9fb0b145c3c149.1386040680.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D8E62265151
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 11:22:20 +0100 (CET)
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

This patch sets a 0ms depop delay in fixup funtion 'alc_fixup_no_depop_delay'.
And Realteck ALC262 applies this on Intel Baytrail BayleyBay platform to reduce
codec suspend time.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Reviewed-by: Kailang Yang <kailang@realtek.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 21dcb7b..69f11e2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -374,8 +374,10 @@ static void alc_fixup_no_depop_delay(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (action == HDA_FIXUP_ACT_PROBE)
+	if (action == HDA_FIXUP_ACT_PROBE) {
 		spec->no_depop_delay = 1;
+		codec->depop_delay = 0;
+	}
 }
 
 static int alc_auto_parse_customize_define(struct hda_codec *codec)
-- 
1.8.1.2
