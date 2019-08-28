From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 2/2] ALSA: hda: Allow HDA to be runtime suspended when dGPU is not bound
Date: Thu, 29 Aug 2019 02:01:28 +0800
Message-ID: <20190828180128.1732-1-kai.heng.feng@canonical.com>
References: <20190827134756.10807-2-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827134756.10807-2-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, tiwai@suse.com
Cc: linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

It's a common practice to let dGPU unbound and use PCI platform power
management to disable its power through _OFF method of power resource,
which is listed by _PR3.
When the dGPU comes with an HDA function, the HDA won't be suspended if
the dGPU is unbound, so the power resource can't be turned off.

Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
discrete GPU") only allows HDA to be runtime-suspended once GPU is
bound, to keep APU's HDA working.

However, HDA on dGPU isn't that useful if dGPU is unbound. So let's
relax the runtime suspend requirement for dGPU's HDA function, to save
lots of power.

BugLink: https://bugs.launchpad.net/bugs/1840835
Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”)
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Change wording.
- Rebase to Tiwai's branch.

 sound/pci/hda/hda_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 91e71be42fa4..c3654d22795a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1284,7 +1284,11 @@ static void init_vga_switcheroo(struct azx *chip)
 		dev_info(chip->card->dev,
 			 "Handle vga_switcheroo audio client\n");
 		hda->use_vga_switcheroo = 1;
-		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
+
+		/* cleared in either gpu_bound op or codec probe, or when its
+		 * root port has _PR3 (i.e. dGPU).
+		 */
+		chip->bus.keep_power = !pci_pr3_present(p);
 		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
 		pci_dev_put(p);
 	}
-- 
2.17.1
