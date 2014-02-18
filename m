From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Move extended fw base and
	size fields in struct sst_pdata
Date: Tue, 18 Feb 2014 16:42:02 +0200
Message-ID: <1392734523-5109-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 282FE2650CC
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 15:42:48 +0100 (CET)
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

Move fw_base and fw_size fields in struct sst_pdata under ACPI data for
clarifying that these are not related to firmware file but for platform
specific extended firmware area reserved by the BIOS.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index 0ce5c8d91794..d134359fecac 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -147,12 +147,12 @@ struct sst_pdata {
 	u32 lpe_size;
 	u32 pcicfg_base;
 	u32 pcicfg_size;
+	u32 fw_base;
+	u32 fw_size;
 	int irq;
 
 	/* Firmware */
 	const char *fw_filename;
-	u32 fw_base;
-	u32 fw_size;
 
 	/* DMA */
 	u32 dma_base;
-- 
1.8.5.3
