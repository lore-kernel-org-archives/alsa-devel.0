From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/14] ASoC: ux500_pcm: No need to use
	snd_dmaengine_pcm_set_data()
Date: Fri, 22 Mar 2013 14:12:07 +0100
Message-ID: <1363957934-20059-8-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 502F0266548
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:11:02 +0100 (CET)
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The driver never uses snd_dmaengine_pcm_get_data(), so there is no need to use
snd_dmaengine_pcm_set_data().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/ux500/ux500_pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index d000ba2..1ab36fa 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -155,8 +155,6 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 		return ret;
 	}
 
-	snd_dmaengine_pcm_set_data(substream, dma_cfg);
-
 	return 0;
 }
 
-- 
1.8.0
