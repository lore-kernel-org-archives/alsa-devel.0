From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Less grumbling about lack of
	i915 binding
Date: Wed,  9 Dec 2015 07:40:23 +0100
Message-ID: <1449643224-10215-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 441682605D8
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 07:40:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 158AAAAB2
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 06:40:27 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The recent commit [6603249dcdbb: ALSA: hda - Enable audio component
for old Intel PCH devices] enabled the i915 binding for HDMI/DP on old
Intel PCHs.  But many boards are without HDMI/DP, and they actually
don't need i915 binding, and yet the driver has a check of i915
binding and complains like
	Haswell must be built with CONFIG_SND_HDA_I915
This error is false-positive, and it should be put only for HSW/BDW,
instead of all devices that may be bound with i915.

This patch fixes the condition to check, as well as rephrasing the
message specific to HSW/BDW HDMI/DP.

Fixes: 6603249dcdbb ('ALSA: hda - Enable audio component for old Intel PCH devices')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ee0e316401f9..b49547f3c2e9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1954,8 +1954,8 @@ static int azx_probe(struct pci_dev *pci,
 #endif /* CONFIG_SND_HDA_PATCH_LOADER */
 
 #ifndef CONFIG_SND_HDA_I915
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		dev_err(card->dev, "Haswell must build in CONFIG_SND_HDA_I915\n");
+	if (CONTROLLER_IN_GPU(pci))
+		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
 #endif
 
 	if (schedule_probe)
-- 
2.6.3
