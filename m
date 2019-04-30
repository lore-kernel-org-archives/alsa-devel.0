From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 01/19] ASoC: SOF: add Kconfig option for strict
	ABI checks
Date: Tue, 30 Apr 2019 18:09:16 -0500
Message-ID: <20190430230934.4321-2-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AA30F8065C
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:55 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When the kernel is more recent than firmware files, it will always
behave in backwards-compatible ways.

Add optional behavior to check if the kernel is older than the
firmware files, so that the kernel fails early instead of attempting
to use new functionality it does not support.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index eaa380092c3b..a1a9ffe605dc 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -53,6 +53,21 @@ config SND_SOC_SOF_NOCODEC
 	  Say Y if you need this nocodec fallback option
 	  If unsure select "N".
 
+config SND_SOC_SOF_STRICT_ABI_CHECKS
+	bool "SOF strict ABI checks"
+	help
+	  This option enables strict ABI checks for firmware and topology
+	  files.
+	  When these files are more recent than the kernel, the kernel
+	  will handle the functionality it supports and may report errors
+	  during topology creation or run-time usage if new functionality
+	  is invoked.
+	  This option will stop topology creation and firmware load upfront.
+	  It is intended for SOF CI/releases and not for users or distros.
+	  Say Y if you want strict ABI checks for an SOF release
+	  If you are not involved in SOF releases and CI development
+	  select "N".
+
 config SND_SOC_SOF_DEBUG
 	bool "SOF debugging features"
 	help
-- 
2.17.1
