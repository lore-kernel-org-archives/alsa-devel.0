From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] regulator: Add WM1811 support
Date: Tue, 27 Sep 2011 19:50:06 +0100
Message-ID: <1317149407-27635-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1317149407-27635-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12900103846
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 20:50:11 +0200 (CEST)
In-Reply-To: <1317149407-27635-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM1811 has a slightly different range on LDO2 to other WM8994 class
devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

As with the ASoC patch this depends on the MFD changes - Liam, given
that ASoC is the thing most likely to run into cross-tree issues are you
OK with merging this via ASoC?

 drivers/regulator/wm8994-regulator.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 1a6a690..b87bf5c 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -140,6 +140,14 @@ static int wm8994_ldo2_list_voltage(struct regulator_dev *rdev,
 		return (selector * 100000) + 900000;
 	case WM8958:
 		return (selector * 100000) + 1000000;
+	case WM1811:
+		switch (selector) {
+		case 0:
+			return -EINVAL;
+		default:
+			return (selector * 100000) + 950000;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -170,6 +178,11 @@ static int wm8994_ldo2_set_voltage(struct regulator_dev *rdev,
 	case WM8958:
 		selector = (min_uV - 1000000) / 100000;
 		break;
+	case WM1811:
+		selector = (min_uV - 950000) / 100000;
+		if (selector == 0)
+			selector = 1;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.6.3
