From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] regulator: arizona: add support for WM8998 and WM1814
Date: Mon, 28 Sep 2015 13:26:36 +0100
Message-ID: <1443443198-29710-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1443443198-29710-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443443198-29710-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/arizona-ldo1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 5e947a8..e3c5982 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -245,6 +245,8 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	switch (arizona->type) {
 	case WM5102:
 	case WM8997:
+	case WM8998:
+	case WM1814:
 		desc = &arizona_ldo1_hc;
 		ldo1->init_data = arizona_ldo1_dvfs;
 		break;
-- 
1.9.1
