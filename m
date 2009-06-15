From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: magician: fix PXA SSP clock polarity
Date: Mon, 15 Jun 2009 10:33:02 +0100
Message-ID: <1245058382-30813-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090615093223.GA30743@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9A4210380E
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:33:03 +0200 (CEST)
In-Reply-To: <20090615093223.GA30743@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Philipp Zabel <philipp.zabel@gmail.com>

Follow-up fix needed since "ASoC: pxa-ssp.c fix clock/frame invert".

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/magician.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index c89a3cd..326955d 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -184,7 +184,7 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-			SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBS_CFS);
+			SND_SOC_DAIFMT_NB_IF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.3.1
