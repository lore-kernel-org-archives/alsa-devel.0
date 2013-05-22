From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 3/4] ALSA: hda - Fix runtime PM check
Date: Thu, 23 May 2013 01:04:15 +0800
Message-ID: <1369242256-32112-4-git-send-email-xingchao.wang@linux.intel.com>
References: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A4992608E9
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:31:18 +0200 (CEST)
In-Reply-To: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: daniel@ffwll.ch, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

The device can support runtime PM no matter whether
it support signal wakeup or not. For some chips like Haswell
which doesnot support PME by default, this patch let haswell
Display HD-A controller enter runtime suspend, and bring more
power saving whith power-well feature enabled.
Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 54c7c22..f20a88c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3755,7 +3755,7 @@ static int azx_probe(struct pci_dev *pci,
 			goto out_free_power;
 	}
 
-	if (pci_dev_run_wake(pci))
+	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
 		pm_runtime_put_noidle(&pci->dev);
 
 	dev++;
@@ -3834,7 +3834,7 @@ static void azx_remove(struct pci_dev *pci)
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct azx *chip = card->private_data;
 
-	if (pci_dev_run_wake(pci))
+	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
 		pm_runtime_get_noresume(&pci->dev);
 
 	if (card)
-- 
1.8.1.2
