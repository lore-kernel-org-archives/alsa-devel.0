From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: constify acpi_device_id." to the asoc tree
Date: Wed, 26 Jul 2017 15:17:33 +0100
Message-ID: <E1daN81-0003hF-A1@debutante>
References: <1500830607-17268-2-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500830607-17268-2-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: constify acpi_device_id.

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

>From 8a43c2240c862bbf3fc612d0533b891bd75ec771 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sun, 23 Jul 2017 22:53:24 +0530
Subject: [PATCH] ASoC: rt5514: constify acpi_device_id.

acpi_device_id are not supposed to change at runtime. All functions
working with acpi_device_id provided by <acpi/acpi_bus.h> work with
const acpi_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 882fdc4a6fd4..3d0aea8f3801 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1134,7 +1134,7 @@ MODULE_DEVICE_TABLE(of, rt5514_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5514_acpi_match[] = {
+static const struct acpi_device_id rt5514_acpi_match[] = {
 	{ "10EC5514", 0},
 	{},
 };
-- 
2.13.2
