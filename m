From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/9] ASoC: SOF: soundwire: add initial
	soundwire support
Date: Mon,  3 Jun 2019 11:18:14 -0500
Message-ID: <20190603161821.7486-3-pierre-louis.bossart@linux.intel.com>
References: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F714F896DB
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:18:31 +0200 (CEST)
In-Reply-To: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

Add soundwire dai type and update ABI version.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai.h      | 1 +
 include/uapi/sound/sof/abi.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 3b67c93ff101..3d174e20aa53 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -49,6 +49,7 @@ enum sof_ipc_dai_type {
 	SOF_DAI_INTEL_SSP,		/**< Intel SSP */
 	SOF_DAI_INTEL_DMIC,		/**< Intel DMIC */
 	SOF_DAI_INTEL_HDA,		/**< Intel HD/A */
+	SOF_DAI_INTEL_SOUNDWIRE,	/**< Intel SoundWire */
 };
 
 /* general purpose DAI configuration */
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 37e0a90dc9e6..13a4eca04577 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -26,7 +26,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 4
+#define SOF_ABI_MINOR 5
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
-- 
2.20.1
