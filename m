From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/14] ASoC: WM9713 requires symmetric rates on
	the voice DAI
Date: Tue, 14 Apr 2009 13:33:08 +0100
Message-ID: <1239712393-6428-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74FC5103861
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:17 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 523bad0..aa94cc6 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1069,6 +1069,7 @@ struct snd_soc_dai wm9713_dai[] = {
 		.rates = WM9713_PCM_RATES,
 		.formats = WM9713_PCM_FORMATS,},
 	.ops = &wm9713_dai_ops_voice,
+	.symmetric_rates = 1,
 	},
 };
 EXPORT_SYMBOL_GPL(wm9713_dai);
-- 
1.6.2.2
