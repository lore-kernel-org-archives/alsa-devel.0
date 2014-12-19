From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 01/16] ASoC: samsung: i2s: Remove unused gpios field from
 struct i2s
Date: Fri, 19 Dec 2014 14:55:21 +0100
Message-ID: <1418997336-17777-2-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: broonie@kernel.org, kgene@kernel.org, alsa-devel@alsa-project.org
Cc: padma.v@samsung.com, drake@endlessm.com, sbkim73@samsung.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

The 'gpios' field in 'struct i2s' is now unused, this change
seems to be missing in commit 0429ffeff460c4302bd1520e6
("ASoC: samsung: Remove obsolete GPIO based DT pinmuxing").

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index eca17dc..827e4b4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -95,7 +95,6 @@ struct i2s_dai {
 	u32	suspend_i2smod;
 	u32	suspend_i2scon;
 	u32	suspend_i2spsr;
-	unsigned long gpios[7];	/* i2s gpio line numbers */
 	const struct samsung_i2s_variant_regs *variant_regs;
 };
 
-- 
1.7.9.5
