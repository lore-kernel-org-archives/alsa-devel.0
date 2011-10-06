From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8990: Remove incorrect comments
Date: Thu, 06 Oct 2011 11:44:56 +0800
Message-ID: <1317872696.8321.5.camel@phoenix>
References: <1317870019.8321.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317870019.8321.4.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8990.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 48e9dd9..ecdb8b2 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -47,10 +47,6 @@ static int wm8990_volatile_register(struct snd_soc_codec *codec,
 	}
 }
 
-/*
- * wm8990 register cache.  Note that register 0 is not included in the
- * cache.
- */
 static const u16 wm8990_reg[] = {
 	0x8990,     /* R0  - Reset */
 	0x0000,     /* R1  - Power Management (1) */
-- 
1.7.4.1
