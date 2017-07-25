From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/11] ASoC: samsung: s3c2412: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:28 +0530
Message-ID: <1500977674-27960-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/s3c2412-i2s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 0a47182..bcd1cbd 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -71,7 +71,9 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 	/* Set MPLL as the source for IIS CLK */
 
 	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
-	clk_prepare_enable(s3c2412_i2s.iis_cclk);
+	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
+	if (ret)
+		return ret;
 
 	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
 
-- 
1.9.1
