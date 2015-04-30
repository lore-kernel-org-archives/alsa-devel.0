From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - remove check on
	CONFIG_SND_HDA_I915 in azx_probe_continue()
Date: Thu, 30 Apr 2015 15:10:18 +0800
Message-ID: <1430377818-21567-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 79A592659EA
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 08:59:44 +0200 (CEST)
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

This is to avoid a build warning that label 'i915_power_fail' is defined
but not used.

There are already fake hda_i915 functions when CONFIG_SND_HDA_I915 is not
defined, and error message for missing CONFIG_SND_HDA_I915 for the HD-A
controller or codec that depends on i915 power well.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5aa5cfa..87df90d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1907,8 +1907,6 @@ static int azx_probe_continue(struct azx *chip)
 		if (pci->device != 0x0f04 && pci->device != 0x2284)
 			hda->need_i915_power = 1;
 
-
-#ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init(hda);
 		if (err < 0)
 			goto i915_power_fail;
@@ -1919,7 +1917,6 @@ static int azx_probe_continue(struct azx *chip)
 				"Cannot turn on display power on i915\n");
 			goto i915_power_fail;
 		}
-#endif
 	}
 
 	err = azx_first_init(chip);
-- 
1.9.1
