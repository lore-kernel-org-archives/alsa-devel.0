From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC:lm49453: fix build warnings
Date: Thu, 5 Apr 2012 20:54:09 +0530
Message-ID: <1333639449-25254-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BC5B924818
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 17:23:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

From: M R Swami Reddy <mr.swami.reddy@ti.com>

sound/soc/codecs/lm49453.c: In function 'lm49453_set_dai_fmt':
sound/soc/codecs/lm49453.c:1189:4: warning: overflow in implicit
constant conversion [-Woverflow]
sound/soc/codecs/lm49453.c:1193:4: warning: overflow in implicit
constant conversion [-Woverflow]
sound/soc/codecs/lm49453.c:1197:4: warning: overflow in implicit
constant conversion [-Woverflow]


Reported-by: Stephen Rothwell <sfr@canb.auug.org.au> 
Signed-off-by: M R Swami Reddy <mr.swami.reddy@ti.com>
---
 sound/soc/codecs/lm49453.c  |   13 +-
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 744063d..74409ec 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1178,27 +1178,24 @@ static int lm49453_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 
-	int aif_val = 0;
+	u16 aif_val;
 	int mode = 0;
 	int clk_phase = 0;
 	int clk_shift = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		aif_val = ~LM49453_AUDIO_PORT1_BASIC_CLK_MS |
-			~LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+		aif_val = 0;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
-		aif_val = ~LM49453_AUDIO_PORT1_BASIC_CLK_MS |
-			LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+		aif_val = LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		aif_val = LM49453_AUDIO_PORT1_BASIC_CLK_MS |
-			~LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+		aif_val = LM49453_AUDIO_PORT1_BASIC_CLK_MS;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		aif_val = LM49453_AUDIO_PORT1_BASIC_CLK_MS |
-			LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+			  LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
 		break;
 	default:
 		return -EINVAL;
