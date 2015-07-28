From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
Subject: [PATCH] ALSA: hda - Fix race between PM ops and HDA
	init/probe
Date: Tue, 28 Jul 2015 13:29:56 -0700
Message-ID: <1438115396-1476-1-git-send-email-ullysses.a.eoff@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BAB026128B
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 22:30:09 +0200 (CEST)
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
Cc: libin.yang@intel.com, zhuo-hao.lee@intel.com, dgreid@chromium.org, "U. Artie Eoff" <ullysses.a.eoff@intel.com>
List-Id: alsa-devel@alsa-project.org

PM ops could be triggered before HDA is done initializing
and cause PM to set HDA controller to D3Hot.  This can result
in "CORB reset timeout#2, CORBRP = 65535" and "no codecs
initialized".  Additionally, PM ops can be triggered before
azx_probe_continue finishes (async probe).  This can result
in a NULL deref kernel crash.

To fix this, avoid PM ops if !chip->running.

Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
---
 sound/pci/hda/hda_intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 735bdcb04ce8..c38c68f57938 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -867,7 +867,7 @@ static int azx_suspend(struct device *dev)
 
 	chip = card->private_data;
 	hda = container_of(chip, struct hda_intel, chip);
-	if (chip->disabled || hda->init_failed)
+	if (chip->disabled || hda->init_failed || !chip->running)
 		return 0;
 
 	bus = azx_bus(chip);
@@ -902,7 +902,7 @@ static int azx_resume(struct device *dev)
 
 	chip = card->private_data;
 	hda = container_of(chip, struct hda_intel, chip);
-	if (chip->disabled || hda->init_failed)
+	if (chip->disabled || hda->init_failed || !chip->running)
 		return 0;
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
@@ -1027,7 +1027,7 @@ static int azx_runtime_idle(struct device *dev)
 		return 0;
 
 	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
-	    azx_bus(chip)->codec_powered)
+	    azx_bus(chip)->codec_powered || !chip->running)
 		return -EBUSY;
 
 	return 0;
-- 
2.1.0
