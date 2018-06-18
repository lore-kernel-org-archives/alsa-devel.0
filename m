From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/8] ASoC: Intel: Skylake: cleanup before
	moving ACPI tables
Date: Mon, 18 Jun 2018 13:29:36 -0500
Message-ID: <20180618182942.4925-3-pierre-louis.bossart@linux.intel.com>
References: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 99B02266E91
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:29:49 +0200 (CEST)
In-Reply-To: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There is no need to deal with DMICs if the DSP is not present and
there is no ACPI machine ID found.

Simplify before moving these ACPI tables to sound/soc/intel/common

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0a8f0768e987..6dec748e8949 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -500,10 +500,12 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
 
 	skl->mach = mach;
 	skl->fw_name = mach->fw_filename;
-	pdata = skl->mach->pdata;
+	pdata = mach->pdata;
 
-	if (mach->pdata)
+	if (pdata) {
 		skl->use_tplg_pcm = pdata->use_tplg_pcm;
+		pdata->dmic_num = skl_get_dmic_geo(skl);
+	}
 
 	return 0;
 }
@@ -930,8 +932,6 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, ebus);
 
-	skl_dmic_data.dmic_num = skl_get_dmic_geo(skl);
-
 	/* check if dsp is there */
 	if (bus->ppcap) {
 		/* create device for dsp clk */
-- 
2.14.1
