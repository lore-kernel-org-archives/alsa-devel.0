From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/3] ASoC: omap-mcbsp: fix snd_pcm_hw_rule_add
	arguments
Date: Fri,  9 Mar 2012 01:19:15 +0200
Message-ID: <1331248757-3408-2-git-send-email-notasas@gmail.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 542BB10BB35
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:19:29 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id ed3so778100wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 15:19:29 -0800 (PST)
In-Reply-To: <1331248757-3408-1-git-send-email-notasas@gmail.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

We are setting SNDRV_PCM_HW_PARAM_BUFFER_SIZE based on
SNDRV_PCM_HW_PARAM_CHANNELS, not vice versa. This bug didn't
have much impact because the rules are evaluated multiple times
by the core, and intended value got set eventually.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 10eb645..207365c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -142,10 +142,10 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 		* smaller buffer than the FIFO size to avoid underruns
 		*/
 		snd_pcm_hw_rule_add(substream->runtime, 0,
-				    SNDRV_PCM_HW_PARAM_CHANNELS,
+				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				    omap_mcbsp_hwrule_min_buffersize,
 				    mcbsp,
-				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
+				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
 		/* Make sure, that the period size is always even */
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
-- 
1.7.0.4
