From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 1/3] ASoC: magician: fix PXA SSP clock polarity
Date: Sun, 14 Jun 2009 12:51:30 +0200
Message-ID: <1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 1375E246C4
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 12:51:49 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2959175bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 03:51:47 -0700 (PDT)
In-Reply-To: <1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Follow-up fix needed since "ASoC: pxa-ssp.c fix clock/frame invert".

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/magician.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index a04ddc3..fa0e7e6 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -183,7 +183,7 @@ static int magician_playback_hw_params(struct snd_pcm_substream *substream,
 
 	/* set cpu DAI configuration */
 	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-			SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBS_CFS);
+			SND_SOC_DAIFMT_NB_IF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
-- 
1.6.3.1
