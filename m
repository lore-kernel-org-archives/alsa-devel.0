From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/19] ASoC: SOF: Intel: hda: add the SSP Host
	Device memory space
Date: Tue, 30 Apr 2019 18:09:20 -0500
Message-ID: <20190430230934.4321-6-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52549F896E3
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:59 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

The DSP SSP device memory can be conditionally accessed by
the host(depending on access policy).

Add the SSP base memory offset of APL and CNL.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 4efcf85af6b5..c4550f2e493d 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -338,6 +338,13 @@
 #define HDA_ADSP_FW_STATUS_SKL		HDA_ADSP_SRAM0_BASE_SKL
 #define HDA_ADSP_ERROR_CODE_SKL		(HDA_ADSP_FW_STATUS_SKL + 0x4)
 
+/* Host Device Memory Space */
+#define APL_SSP_BASE_OFFSET	0x2000
+#define CNL_SSP_BASE_OFFSET	0x10000
+
+/* Host Device Memory Size of a Single SSP */
+#define SSP_DEV_MEM_SIZE	0x1000
+
 #define HDA_IDISP_CODEC(x) ((x) & BIT(2))
 
 struct sof_intel_dsp_bdl {
-- 
2.17.1
