From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH v2] regulator: arizona-ldo1: remove bypass functionality
Date: Fri,  4 Jul 2014 09:55:16 +0100
Message-ID: <1404464116-21038-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

WM5110/8280 devices do not support bypass mode for LDO1 so remove
the bypass callbacks registered with regulator core.

Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-ldo1.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 04f262a..4c9db58 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -143,8 +143,6 @@ static struct regulator_ops arizona_ldo1_ops = {
 	.map_voltage = regulator_map_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_bypass = regulator_get_bypass_regmap,
-	.set_bypass = regulator_set_bypass_regmap,
 };
 
 static const struct regulator_desc arizona_ldo1 = {
-- 
1.7.9.5
