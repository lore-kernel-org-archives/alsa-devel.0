From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: Fix NULL pointer dereference in
	__pxa2xx_pcm_hw_free
Date: Wed,  8 Jul 2009 19:24:26 +0200
Message-ID: <1247073866-14074-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 47561243C6
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 19:24:38 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Check for rtd->params->drcmr != NULL before accessing it.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/arm/pxa2xx-pcm-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 108b643..6205f37 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -75,7 +75,7 @@ int __pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
 
-	if (rtd && rtd->params)
+	if (rtd && rtd->params && rtd->params->drcmr)
 		*rtd->params->drcmr = 0;
 
 	snd_pcm_set_runtime_buffer(substream, NULL);
-- 
1.6.3.1
