From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Makefile - fix the top-level
	kernel module names (add snd- prefix)" to the asoc tree
Date: Thu, 25 Jul 2019 18:43:40 +0100 (BST)
Message-ID: <20190725174341.08D862742B5F@ypsilon.sirena.org.uk>
References: <20190725133743.22145-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31BD3F8044A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 19:43:42 +0200 (CEST)
In-Reply-To: <20190725133743.22145-1-perex@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, 0@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Makefile - fix the top-level kernel module names (add snd- prefix)

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 5af9e972ac72b1c9f13cd35ccfb4687741c53f3e Mon Sep 17 00:00:00 2001
From: Jaroslav Kysela <perex@perex.cz>
Date: Thu, 25 Jul 2019 15:37:43 +0200
Subject: [PATCH] ASoC: SOF: Makefile - fix the top-level kernel module names
 (add snd- prefix)

Use the proper module name. The objs assignments are already there.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>0
Link: https://lore.kernel.org/r/20190725133743.22145-1-perex@perex.cz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
index 8f14c9d2950b..585fb6917489 100644
--- a/sound/soc/sof/Makefile
+++ b/sound/soc/sof/Makefile
@@ -11,8 +11,8 @@ obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
 obj-$(CONFIG_SND_SOC_SOF_NOCODEC) += snd-sof-nocodec.o
 
 
-obj-$(CONFIG_SND_SOC_SOF_ACPI) += sof-acpi-dev.o
-obj-$(CONFIG_SND_SOC_SOF_PCI) += sof-pci-dev.o
+obj-$(CONFIG_SND_SOC_SOF_ACPI) += snd-sof-acpi.o
+obj-$(CONFIG_SND_SOC_SOF_PCI) += snd-sof-pci.o
 
 obj-$(CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL) += intel/
 obj-$(CONFIG_SND_SOC_SOF_XTENSA) += xtensa/
-- 
2.20.1
