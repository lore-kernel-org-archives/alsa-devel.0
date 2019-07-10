From: Joe Perches <joe@perches.com>
Subject: [PATCH 12/12] ASoC: wcd9335: Fix misuse of GENMASK macro
Date: Tue,  9 Jul 2019 22:04:25 -0700
Message-ID: <92e31a9f321fe731d428ec3ec9d4654ea8a16d1b.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/wcd-clsh-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index c397d713f01a..cc5a9c9b918b 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -65,7 +65,7 @@ struct wcd_clsh_ctrl {
 #define WCD9XXX_FLYBACK_EN_PWDN_WITH_DELAY			0
 #define WCD9XXX_RX_BIAS_FLYB_BUFF			WCD9335_REG(0x6, 0xC7)
 #define WCD9XXX_RX_BIAS_FLYB_VNEG_5_UA_MASK		GENMASK(7, 4)
-#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(0, 3)
+#define WCD9XXX_RX_BIAS_FLYB_VPOS_5_UA_MASK		GENMASK(3, 0)
 #define WCD9XXX_HPH_L_EN				WCD9335_REG(0x6, 0xD3)
 #define WCD9XXX_HPH_CONST_SEL_L_MASK			GENMASK(7, 3)
 #define WCD9XXX_HPH_CONST_SEL_BYPASS			0
-- 
2.15.0
