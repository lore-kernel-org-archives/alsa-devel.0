From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RESEND PATCH 3/6] regulator: arizona-micsupp: Add support for WM8280/WM8281
Date: Tue, 10 Feb 2015 11:18:27 +0000
Message-ID: <1423567110-4414-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1423567110-4414-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1423567110-4414-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, linux.walleij@linaro.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, broonie@kernel.org, rf@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/regulator/arizona-micsupp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 2007900..bfe5dac 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -246,6 +246,7 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	 */
 	switch (arizona->type) {
 	case WM5110:
+	case WM8280:
 		desc = &arizona_micsupp_ext;
 		micsupp->init_data = arizona_micsupp_ext_default;
 		break;
-- 
1.7.2.5

