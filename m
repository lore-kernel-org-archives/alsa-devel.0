From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
Subject: [PATCH 1/2] ALSA: hda - skip runtime PM if async probe
	is not finished
Date: Mon, 27 Jul 2015 14:34:53 -0700
Message-ID: <1438032894-8472-1-git-send-email-ullysses.a.eoff@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DAAC42604CA
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 23:38:35 +0200 (CEST)
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
Cc: libin.yang@intel.com, zhuo-hao.lee@intel.com, "U. Artie Eoff" <ullysses.a.eoff@intel.com>
List-Id: alsa-devel@alsa-project.org

Crash can occur if runtime PM is triggered before the async probe
finishes via the azx_firmware_cb when CONFIG_SND_HDA_PATCH_LOADER
is defined.

Don't execute PM ops if the async probe has not completed yet.

The probe is finished when chip->running is true.

Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 735bdcb04ce8..b729b25a6ad6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1023,7 +1023,7 @@ static int azx_runtime_idle(struct device *dev)
 
 	chip = card->private_data;
 	hda = container_of(chip, struct hda_intel, chip);
-	if (chip->disabled || hda->init_failed)
+	if (chip->disabled || hda->init_failed || !chip->running)
 		return 0;
 
 	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
-- 
1.9.3
