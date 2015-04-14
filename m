From: mengdong.lin@intel.com
Subject: [PATCH v2] ALSA: hda - add Intel get vendor verb 0xf81
	to regmap of the HDMI codec
Date: Tue, 14 Apr 2015 10:15:46 +0800
Message-ID: <1428977746-26461-1-git-send-email-mengdong.lin@intel.com>
References: <2f716e6b90b7416eb34d35ed1954c7761bfd2050.1428918546.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A18C26147E
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 04:05:25 +0200 (CEST)
In-Reply-To: <2f716e6b90b7416eb34d35ed1954c7761bfd2050.1428918546.git.mengdong.lin@intel.com>
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

For HDMI codec on Haswell/Broadwell/Skylake, the SET vendor verb 0x781 is used
enable DP 1.2 mode as a fixup if BIOS has not done this, in function
intel_haswell_fixup_enable_dp12(). Otherwise, the display audio playback will
be silent.

So this patch adds its peer GET vendor verb 0xf81 to the codec's regmap, to
avoid I/O error when sending 0x781 thru remap.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ca0c05e..84ee5ff 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2298,7 +2298,7 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 
 	/* enable DP1.2 mode */
 	vendor_param |= INTEL_EN_DP12;
-	snd_hdac_regmap_add_vendor_verb(&codec->core, INTEL_SET_VENDOR_VERB);
+	snd_hdac_regmap_add_vendor_verb(&codec->core, INTEL_GET_VENDOR_VERB);
 	snd_hda_codec_write_cache(codec, INTEL_VENDOR_NID, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 }
-- 
1.9.1
