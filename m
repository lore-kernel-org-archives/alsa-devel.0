From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: hda/intel: Properly free the display
	power at error path
Date: Sun,  9 Dec 2018 10:33:15 +0100
Message-ID: <20181209093318.27829-5-tiwai@suse.de>
References: <20181209093318.27829-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B3031267AB2
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 10:33:28 +0100 (CET)
In-Reply-To: <20181209093318.27829-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When an error occurs in azx_probe_continue(), we should release the
display power.  However, the current code ignores it and releases the
display power only for HSW/BDW cases.  Fix it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cacee33a74a8..48b29f02f72d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2275,7 +2275,7 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_autosuspend(&pci->dev);
 
 out_free:
-	if (!hda->need_i915_power)
+	if (err < 0 || !hda->need_i915_power)
 		display_power(chip, false);
 
 i915_power_fail:
-- 
2.19.2
