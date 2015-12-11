From: yang.a.fang@intel.com
Subject: [PATCH 2/8] ASoC: Intel: Add Nuvoton+Maxim machine
	driver entry
Date: Fri, 11 Dec 2015 11:29:07 -0800
Message-ID: <1449862153-68738-2-git-send-email-yang.a.fang@intel.com>
References: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 773CA26568F
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:31:01 +0100 (CET)
In-Reply-To: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, rohit.m.ainapure@intel.com, james.ausmus@intel.com, vinod.koul@intel.com, joe.konno@intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rohit Ainapure <rohit.m.ainapure@intel.com>

Add the NAU88L25 + MAX98357A machine driver entry into
the machine table

Signed-off-by: Rohit Ainapure <rohit.m.ainapure@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2c16325..c38bf99 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -600,6 +600,8 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
 	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
 				NULL, NULL, NULL },
+	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
+				NULL, NULL, NULL },
 	{}
 };
 
-- 
1.7.9.5
