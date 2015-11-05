From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: add adi + nau8825
	machine driver entry
Date: Thu,  5 Nov 2015 22:53:08 +0530
Message-ID: <1446744188-1274-4-git-send-email-vinod.koul@intel.com>
References: <1446744188-1274-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 50853260575
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 18:19:49 +0100 (CET)
In-Reply-To: <1446744188-1274-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Fang, Yang A" <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch adds skl_nau8825_ssn4567_i2s machine driver into
machine table

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 390f839d6168..8ead864f354a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -587,6 +587,8 @@ static void skl_remove(struct pci_dev *pci)
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
+	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
+				NULL, NULL, NULL },
 	{}
 };
 
-- 
1.9.1
