From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: dapm: Avoid uninitialised variable
	warning
Date: Thu, 6 Sep 2018 17:41:55 +0100
Message-ID: <20180906164155.22876-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 000212673F4
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 18:41:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Commit 4a75aae17b2a ("ASoC: dapm: Add support for multi-CODEC
CODEC to CODEC links") adds loops that iterate over multiple
CODECs in snd_soc_dai_link_event. This also introduced a compiler
warning for a potentially uninitialised variable in the case
no CODECs are present. This should never be the case as the
DAI link must by definition contain at least 1 CODEC however
probably best to avoid the compiler warning by initialising ret
to zero.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9f4edcd19e022..e496bc642c990 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3623,7 +3623,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	struct snd_pcm_hw_params *params = NULL;
 	struct snd_pcm_runtime *runtime = NULL;
 	unsigned int fmt;
-	int ret;
+	int ret = 0;
 
 	config = rtd->dai_link->params + rtd->params_select;
 
-- 
2.11.0
