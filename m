From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT v2 2/3] ASoC: samsung: Add missing prepare for iis clock of s3c24xx
Date: Thu, 27 Jul 2017 19:13:37 +0200
Message-ID: <20170727171338.13300-3-krzk@kernel.org>
References: <20170727171338.13300-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727171338.13300-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: alsa-devel@alsa-project.org

The s3c_i2sv2_probe() only enabled iis clock.  Missing prepare isn't
probably fatal, because for SoC clocks this is usually no-op, but for
correctness this clock should be prepared.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 9b28046eea8e..3894bda06ebb 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -637,7 +637,7 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 		return -ENOENT;
 	}
 
-	clk_enable(i2s->iis_pclk);
+	clk_prepare_enable(i2s->iis_pclk);
 
 	/* Mark ourselves as in TXRX mode so we can run through our cleanup
 	 * process without warnings. */
-- 
2.11.0
