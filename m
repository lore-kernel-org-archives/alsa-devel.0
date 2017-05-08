From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 6/6] ASoC: Intel: Add Kabylake RT5663+MAX98927
	machine driver entry
Date: Mon,  8 May 2017 14:49:00 +0530
Message-ID: <1494235140-29369-7-git-send-email-naveen.m@intel.com>
References: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EC30D266CD9
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 11:19:39 +0200 (CEST)
In-Reply-To: <1494235140-29369-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Adds kbl_rt5663_max98927_i2s machine driver entry into machine table

Signed-off-by: Naveen M <naveen.m@intel.com>
---
 sound/soc/intel/skylake/skl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b9faa20..6040352 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -865,6 +865,7 @@ static void skl_remove(struct pci_dev *pci)
 static struct sst_codecs skl_codecs = { 1, {"NAU88L25"} };
 static struct sst_codecs kbl_codecs = { 1, {"NAU88L25"} };
 static struct sst_codecs bxt_codecs = { 1, {"MX98357A"} };
+static struct sst_codecs kbl_poppy_codecs = { 1, {"10EC5663"} };
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL,
@@ -894,6 +895,9 @@ static void skl_remove(struct pci_dev *pci)
 	{ "MX98357A", "kbl_n88l25_m98357a", "intel/dsp_fw_kbl.bin", NULL,
 				sst_acpi_codec_list, &kbl_codecs,
 				&skl_dmic_data },
+	{ "MX98927", "kbl_rt5663_m98927", "intel/dsp_fw_kbl.bin", NULL,
+				sst_acpi_codec_list, &kbl_poppy_codecs,
+				&skl_dmic_data },
 	{}
 };
 
-- 
1.9.1
