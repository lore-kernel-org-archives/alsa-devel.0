From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 4/4] ASoC: Intel: Skylake: Update comment
	style
Date: Wed, 22 Jun 2016 19:44:21 +0530
Message-ID: <1466604861-24288-5-git-send-email-vinod.koul@intel.com>
References: <1466604861-24288-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 885F9265960
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 16:11:17 +0200 (CEST)
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

Noticed a style inconsistency in a comment, so update that

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 720efb9fd995..d5d7c53e07bc 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -728,7 +728,7 @@ static int skl_probe(struct pci_dev *pci,
 	list_for_each_entry(hlink, &ebus->hlink_list, list)
 		snd_hdac_ext_bus_link_put(ebus, hlink);
 
-	/*configure PM */
+	/* configure PM */
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
 
-- 
1.9.1
