From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [RFC][PATCH] ASoC: rt5659: Fix incorrect register addresses
Date: Wed, 24 Aug 2016 11:00:27 -0700
Message-ID: <1472061627-821-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, bardliao@realtek.com, oder_chiou@realtek.com
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to the datasheets of Realtek ALC5658 (Rev. 0.9)
and ALC5659 (Rev. 0.13), the "IRQ Control 4" register is
located at MX-00BAh while the "IRQ control 5" register is
at MX-00BBh.

There is no "IRQ Control 6" register in the datasheets but
it is supposed to be behind the "IRQ Control 5" register.

So this patch corrects these addresses.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Hi Mark,

This patch needs the confirmation from Realtek side (hoping that
at least Bard or Oder would give an Ack) as the datasheets that I
have might not reflect the latest register map. And the datasheets
don't seem to be directly downloadable from Realtek website.

 sound/soc/codecs/rt5659.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index d69b0eb..8f1aeef 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -180,9 +180,9 @@
 #define RT5659_IRQ_CTRL_1			0x00b6
 #define RT5659_IRQ_CTRL_2			0x00b7
 #define RT5659_IRQ_CTRL_3			0x00b8
-#define RT5659_IRQ_CTRL_4			0x00b9
-#define RT5659_IRQ_CTRL_5			0x00ba
-#define RT5659_IRQ_CTRL_6			0x00bb
+#define RT5659_IRQ_CTRL_4			0x00ba
+#define RT5659_IRQ_CTRL_5			0x00bb
+#define RT5659_IRQ_CTRL_6			0x00bc
 #define RT5659_INT_ST_1				0x00be
 #define RT5659_INT_ST_2				0x00bf
 #define RT5659_GPIO_CTRL_1			0x00c0
-- 
2.1.4
