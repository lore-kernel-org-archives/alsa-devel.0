From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: SOF: nocodec: fix undefined reference
Date: Fri, 10 May 2019 11:38:03 -0500
Message-ID: <20190510163803.8742-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D81C8F89673
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 18:38:19 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, YueHaibing <yuehaibing@huawei.com>, rdunlap@infradead.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The nocodec option can be selected individually, leading to the following
issue:

sound/soc/sof/core.o: In function `snd_sof_device_probe':
core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'

Fix by selecting the SND_SOF_NOCODEC option as needed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Reported-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index b204c65698f9..a9a1d502daae 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -44,7 +44,10 @@ config SND_SOC_SOF_OPTIONS
 if SND_SOC_SOF_OPTIONS
 
 config SND_SOC_SOF_NOCODEC
-	tristate "SOF nocodec mode Support"
+	tristate
+
+config SND_SOC_SOF_NOCODEC_SUPPORT
+	bool "SOF nocodec mode support"
 	help
 	  This adds support for a dummy/nocodec machine driver fallback
 	  option if no known codec is detected. This is typically only
@@ -80,7 +83,7 @@ if SND_SOC_SOF_DEBUG
 
 config SND_SOC_SOF_FORCE_NOCODEC_MODE
 	bool "SOF force nocodec Mode"
-	depends on SND_SOC_SOF_NOCODEC
+	depends on SND_SOC_SOF_NOCODEC_SUPPORT
 	help
 	  This forces SOF to use dummy/nocodec as machine driver, even
 	  though there is a codec detected on the real platform. This is
@@ -135,6 +138,7 @@ endif ## SND_SOC_SOF_OPTIONS
 config SND_SOC_SOF
 	tristate
 	select SND_SOC_TOPOLOGY
+	select SND_SOC_SOF_NOCODEC if SND_SOC_SOF_NOCODEC_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
-- 
2.17.1
