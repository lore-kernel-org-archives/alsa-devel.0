From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ALSA: ASoC: TWL4030 codec - fix 256*Fs clock
Date: Wed,  5 Nov 2008 23:51:05 +0200
Message-ID: <1225921865-27463-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F78D244F8
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 22:51:24 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so104418eyc.56
	for <alsa-devel@alsa-project.org>; Wed, 05 Nov 2008 13:51:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Grazvydas Ignotas <notasas@gmail.com>, steve@sakoman.com
List-Id: alsa-devel@alsa-project.org

According to TRM, 256*Fs clock output should be enabled
when TWL4030 is in slave mode, not master.
This allows sound to work on OMAP3 Pandora, which uses
256*Fs clock.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
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
1.5.4.3
