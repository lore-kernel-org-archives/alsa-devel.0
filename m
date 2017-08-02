From: Naveen M <naveen.m@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Use correct nuvoton
	codec ID
Date: Wed,  2 Aug 2017 11:47:43 +0530
Message-ID: <1501654663-24663-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B3F0266A8A
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 08:17:41 +0200 (CEST)
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, Harsha Priya <harshapriya.n@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Correcting the nau88l25 codec ID to match secondary codec
and load the machine driver.

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 334917e..608c147 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -879,12 +879,12 @@ static void skl_remove(struct pci_dev *pci)
 
 static struct sst_codecs skl_codecs = {
 	.num_codecs = 1,
-	.codecs = {"NAU88L25"}
+	.codecs = {"10508825"}
 };
 
 static struct sst_codecs kbl_codecs = {
 	.num_codecs = 1,
-	.codecs = {"NAU88L25"}
+	.codecs = {"10508825"}
 };
 
 static struct sst_codecs bxt_codecs = {
-- 
1.9.1
