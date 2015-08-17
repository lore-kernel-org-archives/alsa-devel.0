From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 8/9] ASoC: Intel: Skylake: Initialize NHLT
	table
Date: Mon, 17 Aug 2015 22:56:43 +0530
Message-ID: <1439832404-12424-9-git-send-email-vinod.koul@intel.com>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 00BAC2602AD
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 19:24:59 +0200 (CEST)
In-Reply-To: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Load and Initialize Non HDA Link Table in Skylake driver
to get platform configuration.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2f1890e703c6..ca135b8ab5c0 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -458,6 +458,11 @@ static int skl_probe(struct pci_dev *pci,
 	if (err < 0)
 		goto out_free;
 
+	skl->nhlt = skl_nhlt_init(bus->dev);
+
+	if (skl->nhlt == NULL)
+		goto out_free;
+
 	pci_set_drvdata(skl->pci, ebus);
 
 	/* check if dsp is there */
-- 
1.9.1
