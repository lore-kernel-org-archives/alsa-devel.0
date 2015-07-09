From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add makefile support for SKL
	driver" to the asoc tree
Date: Thu, 09 Jul 2015 12:20:25 +0100
Message-ID: <E1ZD9sP-0005p5-LS@debutante>
References: <1436435411-28028-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81DF5266017
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 13:20:32 +0200 (CEST)
In-Reply-To: <1436435411-28028-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add makefile support for SKL driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eb965e3686f5cea669444d120f3723efa88ed56a Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 9 Jul 2015 15:20:10 +0530
Subject: [PATCH] ASoC: Intel: Add makefile support for SKL driver

This adds makefile and Kconfig to enable Skylake HD audio PCM driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig          | 4 ++++
 sound/soc/intel/Makefile         | 1 +
 sound/soc/intel/skylake/Makefile | 3 +++
 3 files changed, 8 insertions(+)
 create mode 100644 sound/soc/intel/skylake/Makefile

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 32262be80871..d8b99434e699 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -134,3 +134,7 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
       This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
       platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
       If unsure select "N".
+
+config SND_SOC_INTEL_SKYLAKE
+	tristate
+	select SND_HDA_EXT_CORE
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 6de5d5cd3280..2b45435e6245 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SND_SOC_INTEL_SST) += common/
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += atom/
+obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += skylake/
 
 # Machine support
 obj-$(CONFIG_SND_SOC) += boards/
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
new file mode 100644
index 000000000000..734d17cafde7
--- /dev/null
+++ b/sound/soc/intel/skylake/Makefile
@@ -0,0 +1,3 @@
+snd-soc-skl-objs := skl.o skl-pcm.o
+
+obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
-- 
2.1.4
