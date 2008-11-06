From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ALSA: ASoC: TWL4030 codec - fix 256*Fs
	clock
Date: Thu,  6 Nov 2008 11:40:59 +0000
Message-ID: <1225971659-26887-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081106113832.GA26733@rakim.wolfsonmicro.main>
	<1225971659-26887-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225971659-26887-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225971659-26887-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B7AF2450C
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 12:41:01 +0100 (CET)
In-Reply-To: <1225971659-26887-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Grazvydas Ignotas <notasas@gmail.com>

According to TRM, 256*Fs clock output should be enabled
when TWL4030 is in slave mode, not master.
This allows sound to work on OMAP3 Pandora, which uses
256*Fs clock.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Acked-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ee2f0d3..90f3b4d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -469,11 +469,11 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 		format &= ~(TWL4030_AIF_SLAVE_EN);
-		format |= TWL4030_CLK256FS_EN;
+		format &= ~(TWL4030_CLK256FS_EN);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		format &= ~(TWL4030_CLK256FS_EN);
 		format |= TWL4030_AIF_SLAVE_EN;
+		format |= TWL4030_CLK256FS_EN;
 		break;
 	default:
 		return -EINVAL;
-- 
1.5.6.5
