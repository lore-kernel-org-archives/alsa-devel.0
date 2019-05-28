From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: sof-rt5682: fix undefined
	references with Baytrail-only support
Date: Tue, 28 May 2019 11:28:22 -0500
Message-ID: <20190528162822.9178-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6719F8065A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 18:28:41 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

The sof-rt5682 machine driver supports both legacy Baytrail devices
and more recent ApolloLake/CometLake platforms. When only Baytrail is
selected, the compilation fails with the following errors:

ERROR: "hdac_hdmi_jack_port_init"
[sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!

ERROR: "hdac_hdmi_jack_init"
[sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!

Fix by selecting SND_SOC_HDAC_HDMI unconditionally. The code for HDMI
support is not reachable on Baytrail so this change has no functional
impact.

Fixes: f70abd75b7c6 ("ASoC: Intel: add sof-rt5682 machine driver")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 59e366edc16b..317ee1e8c8c6 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -402,7 +402,7 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 		   (SND_SOC_SOF_BAYTRAIL && X86_INTEL_LPSS)
 	select SND_SOC_RT5682
 	select SND_SOC_DMIC
-	select SND_SOC_HDAC_HDMI if SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_HDAC_HDMI
 	help
 	   This adds support for ASoC machine driver for SOF platforms
 	   with rt5682 codec.
-- 
2.20.1
