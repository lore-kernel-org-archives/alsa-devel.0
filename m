From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/4 V7] ALSA: hda - Fix runtime PM check
Date: Thu, 30 May 2013 22:07:08 +0800
Message-ID: <1369922831-727-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1369922831-727-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 07FD02651DB
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 16:34:34 +0200 (CEST)
In-Reply-To: <1369922831-727-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel.vetter@ffwll.ch
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

The device can support runtime PM no matter whether it support
signal wakeup or not. For some chips like Haswell which doesnot
support PME by default, this patch let haswell Display HD-A controller
enter runtime suspend, and bring more power saving whith power-well
feature enabled.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 sound/pci/hda/hda_intel.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 418bfc0..cf3d36c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3091,8 +3091,13 @@ static int register_vga_switcheroo(struct azx *chip)
  */
 static int azx_free(struct azx *chip)
 {
+	struct pci_dev *pci = chip->pci;
 	int i;
 
+	if ((chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
+			&& chip->running)
+		pm_runtime_get_noresume(&pci->dev);
+
 	azx_del_card_list(chip);
 
 	azx_notifier_unregister(chip);
@@ -3726,9 +3731,6 @@ static int azx_probe(struct pci_dev *pci,
 			goto out_free;
 	}
 
-	if (pci_dev_run_wake(pci))
-		pm_runtime_put_noidle(&pci->dev);
-
 	dev++;
 	complete_all(&chip->probe_wait);
 	return 0;
@@ -3741,6 +3743,7 @@ out_free:
 
 static int azx_probe_continue(struct azx *chip)
 {
+	struct pci_dev *pci = chip->pci;
 	int dev = chip->dev_index;
 	int err;
 
@@ -3788,6 +3791,8 @@ static int azx_probe_continue(struct azx *chip)
 	power_down_all_codecs(chip);
 	azx_notifier_register(chip);
 	azx_add_card_list(chip);
+	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
+		pm_runtime_put_noidle(&pci->dev);
 
 	return 0;
 
@@ -3800,9 +3805,6 @@ static void azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 
-	if (pci_dev_run_wake(pci))
-		pm_runtime_get_noresume(&pci->dev);
-
 	if (card)
 		snd_card_free(card);
 	pci_set_drvdata(pci, NULL);
-- 
1.7.9.5
