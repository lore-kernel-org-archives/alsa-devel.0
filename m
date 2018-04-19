From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Disable SND_SOC_INTEL_BAYTRAIL
	when SND_SST_ATOM_HIFI2_PLATFORM is enabled" to the asoc tree
Date: Thu, 19 Apr 2018 13:12:57 +0100
Message-ID: <E1f98Qr-000156-AV@debutante>
References: <20180413124537.6765-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C05BB266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 14:13:08 +0200 (CEST)
In-Reply-To: <20180413124537.6765-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Disable SND_SOC_INTEL_BAYTRAIL when SND_SST_ATOM_HIFI2_PLATFORM is enabled

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ed55fe24d7cb6fdc391ab808f22f163bd28928be Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 13 Apr 2018 14:45:37 +0200
Subject: [PATCH] ASoC: Intel: Disable SND_SOC_INTEL_BAYTRAIL when
 SND_SST_ATOM_HIFI2_PLATFORM is enabled

The sound/soc/intel/common/sst-acpi.c code only tries to load the
"baytrail-pcm-audio" driver (and supporting board drivers) when
SND_SST_ATOM_HIFI2_PLATFORM is not enabled, since otherwise these
are handled by snd-soc-sst-atom-hifi2-platform.ko.

Since these thus will never be used when SND_SST_ATOM_HIFI2_PLATFORM is
enabled, building these drivers when it is enabled is useless.

Add a Kconfig dependency to reflect this, so that SND_SOC_INTEL_BAYTRAIL
cannot be enabled when SND_SST_ATOM_HIFI2_PLATFORM is also enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index addac2a8e52a..0caa1f4eb94d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -61,7 +61,7 @@ config SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Baytrail (legacy) Platforms"
-	depends on DMADEVICES && ACPI
+	depends on DMADEVICES && ACPI && SND_SST_ATOM_HIFI2_PLATFORM=n
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
-- 
2.17.0
