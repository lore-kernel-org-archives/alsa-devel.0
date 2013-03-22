From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/14] ASoC: speaer_pcm: No need to use
	snd_dmaengine_pcm_set_data()
Date: Fri, 22 Mar 2013 14:12:08 +0100
Message-ID: <1363957934-20059-9-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 36CC3266519
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:01 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Rajeev Kumar <rajeev-dlh.kumar@st.com>
List-Id: alsa-devel@alsa-project.org

The driver never uses snd_dmaengine_pcm_get_data(), so there is no need to use
snd_dmaengine_pcm_set_data().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/spear_pcm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 903ac15..bfbcc1f 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -64,13 +64,7 @@ static int spear_pcm_open(struct snd_pcm_substream *substream)
 	if (ret)
 		return ret;
 
-	ret = snd_dmaengine_pcm_open(substream, dma_data->filter, dma_data);
-	if (ret)
-		return ret;
-
-	snd_dmaengine_pcm_set_data(substream, dma_data);
-
-	return 0;
+	return snd_dmaengine_pcm_open(substream, dma_data->filter, dma_data)
 }
 
 static int spear_pcm_mmap(struct snd_pcm_substream *substream,
-- 
1.8.0
