From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: rt5645: make rt5645_platform_data const
Date: Wed, 23 Aug 2017 20:05:22 +0530
Message-ID: <1503498922-6023-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/rt5645.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index f14f648..efec452 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3559,7 +3559,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
 #endif
 
-static struct rt5645_platform_data general_platform_data = {
+static const struct rt5645_platform_data general_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
@@ -3593,7 +3593,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 	{ }
 };
 
-static struct rt5645_platform_data buddy_platform_data = {
+static const struct rt5645_platform_data buddy_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
@@ -3610,7 +3610,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 	{ }
 };
 
-static struct rt5645_platform_data gpd_win_platform_data = {
+static const struct rt5645_platform_data gpd_win_platform_data = {
 	.jd_mode = 3,
 	.inv_jd1_1 = true,
 };
-- 
1.9.1
