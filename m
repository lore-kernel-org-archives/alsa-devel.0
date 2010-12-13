From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: Update LDO2 for WM8958
Date: Mon, 13 Dec 2010 15:52:07 +0000
Message-ID: <1292255527-10016-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC48124642
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 16:52:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

LDO2 has a slightly different range of supported voltages on WM8958
so update the selector<->voltage mappings to match.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

As the WM8958 support is currently sitting in the ASoC tree for the next
merge window this should get merged that way.  I've done some test
merges here and git seems to be able to figure out the overlaps with the
code in your tree so are you OK with applying to ASoC?

 drivers/regulator/wm8994-regulator.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 03713bc..21fefef 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -131,10 +131,19 @@ static struct regulator_ops wm8994_ldo1_ops = {
 static int wm8994_ldo2_list_voltage(struct regulator_dev *rdev,
 				    unsigned int selector)
 {
+	struct wm8994_ldo *ldo = rdev_get_drvdata(rdev);
+
 	if (selector > WM8994_LDO2_MAX_SELECTOR)
 		return -EINVAL;
 
-	return (selector * 100000) + 900000;
+	switch (ldo->wm8994->type) {
+	case WM8994:
+		return (selector * 100000) + 900000;
+	case WM8958:
+		return (selector * 100000) + 1000000;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int wm8994_ldo2_get_voltage(struct regulator_dev *rdev)
@@ -157,7 +166,17 @@ static int wm8994_ldo2_set_voltage(struct regulator_dev *rdev,
 	struct wm8994_ldo *ldo = rdev_get_drvdata(rdev);
 	int selector, v;
 
-	selector = (min_uV - 900000) / 100000;
+	switch (ldo->wm8994->type) {
+	case WM8994:
+		selector = (min_uV - 900000) / 100000;
+		break;
+	case WM8958:
+		selector = (min_uV - 1000000) / 100000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	v = wm8994_ldo2_list_voltage(rdev, selector);
 	if (v < 0 || v > max_uV)
 		return -EINVAL;
-- 
1.7.1
