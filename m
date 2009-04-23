From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Fix offset of freqmode in WM8580 PLL
	configuration
Date: Thu, 23 Apr 2009 19:49:16 +0100
Message-ID: <1240512558-8030-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423184829.GA7807@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 13CA32438D
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 20:49:25 +0200 (CEST)
In-Reply-To: <20090423184829.GA7807@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: stable@kernel.org
---
 sound/soc/codecs/wm8580.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 442ea6f..41aab4a 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -522,7 +522,7 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai,
 	reg = wm8580_read(codec, WM8580_PLLA4 + offset);
 	reg &= ~0x3f;
 	reg |= pll_div.prescale | pll_div.postscale << 1 |
-		pll_div.freqmode << 4;
+		pll_div.freqmode << 3;
 
 	wm8580_write(codec, WM8580_PLLA4 + offset, reg);
 
-- 
1.5.6.3
