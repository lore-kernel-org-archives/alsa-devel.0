From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] extcon: arizona: Add support for WM8280/WM8281
Date: Thu, 13 Nov 2014 17:50:45 +0000
Message-ID: <1415901046-3391-6-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1415901046-3391-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415901046-3391-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, lgirdwood@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tiwai@suse.de
Cc: perex@perex.cz, sameo@linux.intel.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/extcon/extcon-arizona.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index ba51588..3abe866 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1149,6 +1149,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 		}
 		break;
 	case WM5110:
+	case WM8280:
 		switch (arizona->rev) {
 		case 0 ... 2:
 			break;
-- 
1.7.2.5
