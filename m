From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Fix argument ordering for
	snd_soc_update_bits() in WM8580
Date: Mon, 16 Aug 2010 19:28:33 +0100
Message-ID: <1281983313-4636-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281983313-4636-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAF7310381E
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 20:28:40 +0200 (CEST)
In-Reply-To: <1281983313-4636-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Seungwhan Youn <claude.youn@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 42a6699..910c62a 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -741,7 +741,7 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	/* We really should validate PLL settings but not yet */
 	wm8580->sysclk[dai->id] = freq;
 
-	return snd_soc_update_bits(codec, WM8580_CLKSEL, sel, sel_mask);
+	return snd_soc_update_bits(codec, WM8580_CLKSEL, sel_mask, sel);
 }
 
 static int wm8580_digital_mute(struct snd_soc_dai *codec_dai, int mute)
-- 
1.7.1
