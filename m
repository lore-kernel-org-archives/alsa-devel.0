From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH V2 3/6] regulator: arizona-micsupp: Add support for WM8280/WM8281
Date: Wed, 26 Nov 2014 15:13:05 +0000
Message-ID: <1417014788-8311-4-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: cw00.choi@samsung.com, linus.walleij@linaro.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-micsupp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index ce9aca5..4ff55e1 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -245,6 +245,7 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	 */
 	switch (arizona->type) {
 	case WM5110:
+	case WM8280:
 		desc = &arizona_micsupp_ext;
 		micsupp->init_data = arizona_micsupp_ext_default;
 		break;
-- 
1.7.2.5
