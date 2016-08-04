From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 4/8] ASoC: s3c24xx_uda134x: Remove unused power() callback
Date: Thu, 04 Aug 2016 15:38:44 +0200
Message-ID: <1470317928-25365-5-git-send-email-s.nawrocki@samsung.com>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: krzk@kernel.org, alsa-devel@alsa-project.org, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

The power() callback has always been empty so just remove it.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 include/sound/s3c24xx_uda134x.h     | 1 -
 sound/soc/samsung/s3c24xx_uda134x.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/sound/s3c24xx_uda134x.h b/include/sound/s3c24xx_uda134x.h
index 33df4cb..ffaf1f0 100644
--- a/include/sound/s3c24xx_uda134x.h
+++ b/include/sound/s3c24xx_uda134x.h
@@ -7,7 +7,6 @@ struct s3c24xx_uda134x_platform_data {
 	int l3_clk;
 	int l3_mode;
 	int l3_data;
-	void (*power) (int);
 	int model;
 };
 
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 92e88bc..c145eb2 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -282,7 +282,6 @@ static int s3c24xx_uda134x_probe(struct platform_device *pdev)
 		       "unable to find platform data\n");
 		return -ENODEV;
 	}
-	s3c24xx_uda134x.power = s3c24xx_uda134x_l3_pins->power;
 	s3c24xx_uda134x.model = s3c24xx_uda134x_l3_pins->model;
 
 	if (s3c24xx_uda134x_setup_pin(s3c24xx_uda134x_l3_pins->l3_data,
-- 
1.9.1
