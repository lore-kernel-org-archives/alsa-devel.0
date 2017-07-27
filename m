From: Kevin Cheng <kevin.cheng@intel.com>
Subject: [PATCH v2 2/2] ASoC: Intel: Add Kabylake RT5663
	machine driver entry
Date: Thu, 27 Jul 2017 10:54:00 +0800
Message-ID: <20170727025400.6426-3-kevin.cheng@intel.com>
References: <20170727025400.6426-1-kevin.cheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 15EAC266AF9
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 04:53:15 +0200 (CEST)
In-Reply-To: <20170727025400.6426-1-kevin.cheng@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vinod.koul@intel.com
Cc: kevin.cheng@intel.com
List-Id: alsa-devel@alsa-project.org

Adds Kabylake rt5663 machine driver entry into machine table

Signed-off-by: Kevin Cheng <kevin.cheng@intel.com>
---
 sound/soc/intel/skylake/skl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 334917ee41cf..01a2dd6518a4 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -981,6 +981,11 @@ static struct sst_acpi_mach sst_kbl_devdata[] = {
 		.quirk_data = &kbl_poppy_codecs,
 		.pdata = &skl_dmic_data
 	},
+	{
+		.id = "10EC5663",
+		.drv_name = "kbl_rt5663",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
 
 	{}
 };
-- 
2.12.2
