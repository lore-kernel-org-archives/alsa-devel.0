From: sathyanarayana.nujella@intel.com
Subject: [REPOST PATCH 2/2] ASoC: Intel: Add Broxton-P
	Dialog+Maxim machine driver entry
Date: Tue, 31 May 2016 23:33:16 -0700
Message-ID: <20160601063316.30042-3-sathyanarayana.nujella@intel.com>
References: <20160601063316.30042-1-sathyanarayana.nujella@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EC3DA2656F0
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 08:33:55 +0200 (CEST)
In-Reply-To: <20160601063316.30042-1-sathyanarayana.nujella@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, yang.a.fang@intel.com, liam.r.girdwood@linux.intel.com, harshapriya.n@intel.com, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

This patch adds bxt_da7219_max98357a_i2s machine driver
entry into machine table

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/intel/skylake/skl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b0f7226..55c301b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -803,6 +803,7 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 
 static struct sst_acpi_mach sst_bxtp_devdata[] = {
 	{ "INT343A", "bxt_alc298s_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
+	{ "DLGS7219", "bxt_da7219_max98357a_i2s", "intel/dsp_fw_bxtn.bin", NULL, NULL, NULL },
 };
 
 /* PCI IDs */
-- 
2.8.3
