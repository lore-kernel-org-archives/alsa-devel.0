From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/4] ASoC: SOF: rename SOUNDWIRE to ALH
Date: Thu, 15 Aug 2019 10:50:29 -0500
Message-ID: <20190815155032.29181-2-pierre-louis.bossart@linux.intel.com>
References: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3591FF80273
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 17:55:38 +0200 (CEST)
In-Reply-To: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

Rename SOUNDWIRE to ALH.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 7a84f7fb460a..6b296df242bd 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -49,7 +49,7 @@ enum sof_ipc_dai_type {
 	SOF_DAI_INTEL_SSP,		/**< Intel SSP */
 	SOF_DAI_INTEL_DMIC,		/**< Intel DMIC */
 	SOF_DAI_INTEL_HDA,		/**< Intel HD/A */
-	SOF_DAI_INTEL_SOUNDWIRE,	/**< Intel SoundWire */
+	SOF_DAI_INTEL_ALH,		/**< Intel ALH  */
 	SOF_DAI_IMX_SAI,		/**< i.MX SAI */
 	SOF_DAI_IMX_ESAI,		/**< i.MX ESAI */
 };
-- 
2.20.1
