From: mengdong.lin@intel.com
Subject: [PATCH v2] ALSA: hda - only sync BCLK to the display
	clock for Haswell & Broadwell
Date: Mon, 20 Apr 2015 17:33:57 +0800
Message-ID: <1429522437-15023-1-git-send-email-mengdong.lin@intel.com>
References: <6f881935a29f44b895ae6854bcd40ea62a7364a5.1429517003.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 546C02654BA
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 11:23:27 +0200 (CEST)
In-Reply-To: <6f881935a29f44b895ae6854bcd40ea62a7364a5.1429517003.git.mengdong.lin@intel.com>
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

Only Intel Haswell and Broadwell have a separate HD-A controller (PCI device 3)
for display audio, which needs to get 24MHz HD-A link BCLK from the variable
display core clock through vendor specific registers EM4 & EM5. Other platforms
(Baytrail, Braswell and Skylake) don't have this feature.

So this patch checks the PCI device ID of the controller in haswell_set_bclk()
and only sync BCLK for HSW and BDW.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index 52a85d8..3052a2b 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -55,6 +55,12 @@ void haswell_set_bclk(struct hda_intel *hda)
 	int cdclk_freq;
 	unsigned int bclk_m, bclk_n;
 	struct i915_audio_component *acomp = &hda->audio_component;
+	struct pci_dev *pci = hda->chip.pci;
+
+	/* Only Haswell/Broadwell need set BCLK */
+	if (pci->device != 0x0a0c && pci->device != 0x0c0c
+	   && pci->device != 0x0d0c && pci->device != 0x160c)
+		return;
 
 	if (!acomp->ops)
 		return;
-- 
1.9.1
