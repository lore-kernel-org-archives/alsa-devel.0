From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Add Baytrail SST and
	byt-rt5640 machine driver probing
Date: Mon, 24 Feb 2014 17:27:01 +0200
Message-ID: <1393255622-31365-7-git-send-email-jarkko.nikula@linux.intel.com>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 23567265454
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:27:26 +0100 (CET)
In-Reply-To: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add Baytrail SST descriptor with the byt-rt5640 machine driver to sst-acpi
loader.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-acpi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index c7e36c9ee52f..0bb43169e146 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -243,9 +243,26 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 	.dma_size = SST_LPT_DSP_DMA_SIZE,
 };
 
+static struct sst_acpi_mach baytrail_machines[] = {
+	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-i2s_master" },
+	{}
+};
+
+static struct sst_acpi_desc sst_acpi_baytrail_desc = {
+	.drv_name = "baytrail-pcm-audio",
+	.machines = baytrail_machines,
+	.resindex_lpe_base = 0,
+	.resindex_pcicfg_base = 1,
+	.resindex_fw_base = 2,
+	.irqindex_host_ipc = 5,
+	.sst_id = SST_DEV_ID_BYT,
+	.resindex_dma_base = -1,
+};
+
 static struct acpi_device_id sst_acpi_match[] = {
 	{ "INT33C8", (unsigned long)&sst_acpi_haswell_desc },
 	{ "INT3438", (unsigned long)&sst_acpi_broadwell_desc },
+	{ "80860F28", (unsigned long)&sst_acpi_baytrail_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sst_acpi_match);
-- 
1.8.5.3
