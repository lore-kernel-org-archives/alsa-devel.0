From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: constify acpi_device_id." to the asoc tree
Date: Wed, 26 Jul 2017 15:17:27 +0100
Message-ID: <E1daN7v-0003ew-9C@debutante>
References: <1500830607-17268-4-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500830607-17268-4-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: constify acpi_device_id.

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

>From f36544a425d3b75281a1601fe663086aec5b36c7 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sun, 23 Jul 2017 22:53:26 +0530
Subject: [PATCH] ASoC: rt5659: constify acpi_device_id.

acpi_device_id are not supposed to change at runtime. All functions
working with acpi_device_id provided by <acpi/acpi_bus.h> work with
const acpi_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 1b7060850340..0a99fad48392 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4222,7 +4222,7 @@ MODULE_DEVICE_TABLE(of, rt5659_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5659_acpi_match[] = {
+static const struct acpi_device_id rt5659_acpi_match[] = {
 	{ "10EC5658", 0, },
 	{ "10EC5659", 0, },
 	{ },
-- 
2.13.2
