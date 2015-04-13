From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - not use regmap for vendor verb
	0x781 of Intel HDMI codec
Date: Mon, 13 Apr 2015 17:50:43 +0800
Message-ID: <2f716e6b90b7416eb34d35ed1954c7761bfd2050.1428918546.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9905F261A5E
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 11:40:21 +0200 (CEST)
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

For HDMI codec on Haswell/Broadwell/Skylake platforms, the vendor verb 0x781
is used enable DP 1.2 mode as a fixup if BIOS has not done this, in function
intel_haswell_fixup_enable_dp12(). Otherwise, the display audio playback will
be silent.

Although the verb 0x781 is added to vendor verbs array, but snd_hdac_regmap_
encode_verb() will translate it to verb 0xf81 and cause regmap_write IO failure
because 0xf81 is not in the vendor verb array and so will not be taken as a
writable register.

So this patch no longer uses regmap for verb 0x781 but directly send this
command to enable DP1.2 mode.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ca0c05e..1849c94 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2298,8 +2298,7 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 
 	/* enable DP1.2 mode */
 	vendor_param |= INTEL_EN_DP12;
-	snd_hdac_regmap_add_vendor_verb(&codec->core, INTEL_SET_VENDOR_VERB);
-	snd_hda_codec_write_cache(codec, INTEL_VENDOR_NID, 0,
+	snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 }
 
-- 
1.9.1
