From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: nocodec: fix undefined reference"
	to the asoc tree
Date: Mon, 13 May 2019 13:30:31 +0100 (BST)
Message-ID: <20190513123031.08BB71129234@debutante.sirena.org.uk>
References: <20190510163803.8742-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33898F89739
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:43 +0200 (CEST)
In-Reply-To: <20190510163803.8742-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, rdunlap@infradead.org, YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: nocodec: fix undefined reference

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 8d01c3c73cefbb5bacffe804427daed3e6051435 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 10 May 2019 11:38:03 -0500
Subject: [PATCH] ASoC: SOF: nocodec: fix undefined reference

The nocodec option can be selected individually, leading to the following
issue:

sound/soc/sof/core.o: In function `snd_sof_device_probe':
core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'

Fix by selecting the SND_SOF_NOCODEC option as needed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Reported-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
