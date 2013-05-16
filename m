From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH] ALSA: hda - Enable runtime pm for Haswell
Date: Thu, 16 May 2013 16:29:05 +0800
Message-ID: <1368692945-2122-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id F1B8426535C
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 10:31:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, mengdong.lin@intel.com, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Haswell doesnot support runtime pm by default.
This patch let haswell Display HD-A controller enter
runtime suspend, and bring more power saving whith power-well.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bf27693..eb25888 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3755,6 +3755,12 @@ static int azx_probe(struct pci_dev *pci,
 
 	if (pci_dev_run_wake(pci))
 		pm_runtime_put_noidle(&pci->dev);
+	else if (chip->driver_caps
+			& AZX_DCAPS_I915_POWERWELL) {
+		/* Haswell doesnot support runtime pm by default */
+		pm_runtime_put_noidle(&pci->dev);
+		pm_runtime_allow(&pci->dev);
+	}
 
 	dev++;
 	complete_all(&chip->probe_wait);
-- 
1.7.9.5
