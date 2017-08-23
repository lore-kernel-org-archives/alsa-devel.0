From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: make rt5645_platform_data const" to the asoc tree
Date: Wed, 23 Aug 2017 16:54:22 +0100
Message-ID: <E1dkXz4-0005RK-74@debutante>
References: <1503498922-6023-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503498922-6023-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: make rt5645_platform_data const

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

>From cd6d6477f130c861c42e6eddc060e7c880e94bf3 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 23 Aug 2017 20:05:22 +0530
Subject: [PATCH] ASoC: rt5645: make rt5645_platform_data const

Make these const as they are only used during a copy operation.
Done using Coccinelle.

@match disable optional_qualifier@
identifier s;
@@
static struct rt5645_platform_data s = {...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
position ref.p;
identifier match.s,f,c;
expression e;
@@
(
e = s@p
|
e = s@p.f
|
c(...,s@p.f,...)
|
c(...,s@p,...)
)

@bad depends on  !good1@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct rt5645_platform_data s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 500bb42d0804..d2f038001908 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3559,7 +3559,7 @@ static const struct acpi_device_id rt5645_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
 #endif
 
-static struct rt5645_platform_data general_platform_data = {
+static const struct rt5645_platform_data general_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
@@ -3593,7 +3593,7 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{ }
 };
 
-static struct rt5645_platform_data buddy_platform_data = {
+static const struct rt5645_platform_data buddy_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
@@ -3610,7 +3610,7 @@ static struct dmi_system_id dmi_platform_intel_broadwell[] = {
 	{ }
 };
 
-static struct rt5645_platform_data gpd_win_platform_data = {
+static const struct rt5645_platform_data gpd_win_platform_data = {
 	.jd_mode = 3,
 	.inv_jd1_1 = true,
 };
-- 
2.14.1
