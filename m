From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 2/4] ASoC: Intel: Skylake: Disable async
	suspend
Date: Wed, 22 Jun 2016 19:44:19 +0530
Message-ID: <1466604861-24288-3-git-send-email-vinod.koul@intel.com>
References: <1466604861-24288-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B394265938
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 16:11:14 +0200 (CEST)
In-Reply-To: <1466604861-24288-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

We do not support async suspend due to dependency with rest of
card and require suspend/resume be executed synchronously, mark
the device accordingly.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 734072c79205..720efb9fd995 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -668,6 +668,8 @@ static int skl_probe(struct pci_dev *pci,
 
 	skl->pci_id = pci->device;
 
+	device_disable_async_suspend(bus->dev);
+
 	skl->nhlt = skl_nhlt_init(bus->dev);
 
 	if (skl->nhlt == NULL)
-- 
1.9.1
