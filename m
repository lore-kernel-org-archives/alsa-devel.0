From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add missing 10EC5672 ACPI ID
	matching for Cherry Trail" to the asoc tree
Date: Wed, 30 Nov 2016 17:16:41 +0000
Message-ID: <E1cC8Ur-0005vw-0w@debutante>
References: <20161130135747.22485-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 173E2266AF1
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 18:16:49 +0100 (CET)
In-Reply-To: <20161130135747.22485-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add missing 10EC5672 ACPI ID matching for Cherry Trail

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

>From 6648eb8666af7681e6ff3830ca715e8255f17078 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 30 Nov 2016 14:56:26 +0100
Subject: [PATCH] ASoC: Intel: Add missing 10EC5672 ACPI ID matching for Cherry
 Trail

Add the missing ACPI ID 10EC5672 for Cherry Trail, which bounds with
cht-bsw-rt5672 driver.  This combination was found on Dell Wyse 3040.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index ba5c0d71720a..4461b6521740 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -451,6 +451,8 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 static struct sst_acpi_mach sst_acpi_chv[] = {
 	{"10EC5670", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	{"10EC5672", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+						&chv_platform_data },
 	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
 	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-- 
2.10.2
