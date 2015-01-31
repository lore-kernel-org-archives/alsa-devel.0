From: yang.a.fang@intel.com
Subject: [PATCH 2/2] ASoC: Intel:Add support rt5645 in sst
	driver
Date: Sat, 31 Jan 2015 15:22:40 -0800
Message-ID: <1422746560-91398-2-git-send-email-yang.a.fang@intel.com>
References: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 50873260531
 for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2015 00:23:03 +0100 (CET)
In-Reply-To: <1422746560-91398-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, denny.iriawan@intel.com, harshapriya.n@intel.com, praveen.k.jain@intel.com, kevin.strasser@intel.com, vinod.koul@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

Added entry in sst driver to support rt5645 codec
for intel Braswell platform.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/sst/sst_acpi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index df2b5cc..21b22e6 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -352,6 +352,8 @@ static struct sst_machines sst_acpi_bytcr[] = {
 static struct sst_machines sst_acpi_chv[] = {
 	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "fw_sst_22a8.bin",
 						&chv_platform_data },
+	{"10EC5645", "cht-bsw", "cht-bsw-rt5645", NULL, "fw_sst_22a8.bin",
+						&chv_platform_data },
 	{},
 };
 
-- 
1.7.9.5
