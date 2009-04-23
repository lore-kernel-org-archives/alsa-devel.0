From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 20/21] ASoC: OMAP: Add 4 channel support to
	mcbsp
Date: Thu, 23 Apr 2009 20:55:54 +0100
Message-ID: <1240516555-22249-20-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B79D910388A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:03 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Add 4 channel support to omap-mcbsp.
This mode is going to be used by the twl4030 codec, when it
is configured in Option1 mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 495192a..a5d46a7 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -259,6 +259,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 			regs->xcr2	|= XFRLEN2(wpf - 1);
 		}
 	case 1:
+	case 4:
 		/* Set word per (McBSP) frame for phase1 */
 		regs->rcr1	|= RFRLEN1(wpf - 1);
 		regs->xcr1	|= XFRLEN1(wpf - 1);
@@ -506,13 +507,13 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
 	.id = (link_id),					\
 	.playback = {						\
 		.channels_min = 1,				\
-		.channels_max = 2,				\
+		.channels_max = 4,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
 	.capture = {						\
 		.channels_min = 1,				\
-		.channels_max = 2,				\
+		.channels_max = 4,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
-- 
1.5.6.3
