From: Nenghua Cao <nhcao@marvell.com>
Subject: [PATCH] ASoC: dpcm: don't do hw_param when BE has done
	hw_param
Date: Fri, 10 Jan 2014 13:36:35 +0800
Message-ID: <1389332195-15900-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 5332F265455
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 06:33:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Nenghua Cao <nhcao@marvell.com>
List-Id: alsa-devel@alsa-project.org

From: Nenghua Cao <nhcao@marvell.com>

    It fixes the following case:
    Two FEs connects the same BE; FE1 & BE path has been opened and hw_paramed.
At this momment, FE2 & BE path is being opened and hw_paramed. The BE
dai will do hw_param again even if it has done hw_param. It is not
reasonable.
FE1------------>BE
FE2-------------^

Signed-off-by: Nenghua Cao <nhcao@marvell.com>
---
 sound/soc/soc-pcm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 891b9a9..ec07e37 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1339,7 +1339,6 @@ static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE))
 			continue;
 
-- 
1.7.0.4
