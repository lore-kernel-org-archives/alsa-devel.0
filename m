From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: OMAP: Staticise pcm creation function of
	omap-pcm
Date: Wed, 22 Jul 2009 20:45:03 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E59BA9D48@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A4667243F9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 03:45:12 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/omap-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 84a1950..c3c931d 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -330,7 +330,7 @@ static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+static int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 		 struct snd_pcm *pcm)
 {
 	int ret = 0;
-- 
1.5.4.3
