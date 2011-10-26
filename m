From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8940: Fix mask for setting BCLKDIV
Date: Wed, 26 Oct 2011 09:55:39 +0800
Message-ID: <1319594139.2517.2.camel@phoenix>
References: <1319594021.2517.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319594021.2517.0.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Paulson-Ellis <chris@edesix.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to the datasheet:
BCLK is controlled by BIT[4:2] of WM8940_CLOCK(06h) register.

Signed-off-by: Chris Paulson-Ellis <chris@edesix.com>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the patch from Chris, thus add his signed-off-by here.

 sound/soc/codecs/wm8940.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index e8a4ca3..1b5856b 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -621,7 +621,7 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8940_BCLKDIV:
-		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFEF3;
+		reg = snd_soc_read(codec, WM8940_CLOCK) & 0xFFE3;
 		ret = snd_soc_write(codec, WM8940_CLOCK, reg | (div << 2));
 		break;
 	case WM8940_MCLKDIV:
-- 
1.7.5.4
