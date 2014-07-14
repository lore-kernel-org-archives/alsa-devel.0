From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 4/4] ASoC: Intel: Start with all memory
	banks disabled
Date: Mon, 14 Jul 2014 17:11:12 +0800
Message-ID: <1405329072-28679-5-git-send-email-yang.jie@intel.com>
References: <1405329072-28679-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 680352619D9
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 11:12:19 +0200 (CEST)
In-Reply-To: <1405329072-28679-1-git-send-email-yang.jie@intel.com>
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

All required banks are enabled during boot procedure.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-dsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
index 61dbf91..1819327 100644
--- a/sound/soc/intel/sst-haswell-dsp.c
+++ b/sound/soc/intel/sst-haswell-dsp.c
@@ -518,8 +518,9 @@ static int hsw_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 		}
 	}
 
-	/* set default power gating mask */
-	writel(0x0, sst->addr.pci_cfg + SST_VDRTCTL0);
+	/* set default power gating control, enable power gating control for all blocks. that is,
+	can't be accessed, please enable each block before accessing. */
+	writel(0xffffffff, sst->addr.pci_cfg + SST_VDRTCTL0);
 
 	return 0;
 }
-- 
1.8.3.2
