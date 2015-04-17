From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 3/9] ASoC: hda: Add config option for SKL ipc
	library
Date: Fri, 17 Apr 2015 18:46:01 +0530
Message-ID: <1429276567-29007-4-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DA1C32605A6
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:20 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/Kconfig  |    7 +++++++
 sound/soc/hda/Makefile |    3 +++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/hda/Kconfig b/sound/soc/hda/Kconfig
index 8781f63abcf6..841ea5276fe3 100644
--- a/sound/soc/hda/Kconfig
+++ b/sound/soc/hda/Kconfig
@@ -40,4 +40,11 @@ config SND_SOC_I2S_SKL_MACH
         Say Y if you have such a device
         If unsure select "N".
 
+
+config SND_SOC_HDA_SST_DSP
+	tristate "Enable SST DSP Library"
+	depends on (X86 || COMPILE_TEST)
+	help
+	  Say Y here to enable the HD-audio SST dsp library.
+
 endmenu
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
index d9bd33259233..d318d4acb8a7 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -4,3 +4,6 @@ obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
 
 # Machine support
 obj-$(CONFIG_SND_SOC_HDA_SKL) += boards/
+
+# DSP library
+obj-$(CONFIG_SND_SOC_HDA_SST_DSP) += intel/
-- 
1.7.9.5
