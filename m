From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: samsung idma: Add proper annotation
	for casting iomem pointers
Date: Sun, 17 Aug 2014 16:18:21 +0200
Message-ID: <1408285102-24538-6-git-send-email-lars@metafoo.de>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id AB42B2650F7
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:18:30 +0200 (CEST)
In-Reply-To: <1408285102-24538-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

It is not always possible to interchange iomem pointers with normal pointers,
which why we have annotations for iomem pointers and warn when casting them to a
normal pointer or vice versa. In this case the casting is fine and unfortunately
necessary so add the proper annotations to tell code checkers that it is
intentional. This silences the following warnings from sparse:
	sound/soc/samsung/idma.c:354:20: warning: incorrect type in argument 1
	 (different address spaces) expected void volatile [noderef]
	  <asn:2>*addr got unsigned char *area
	sound/soc/samsung/idma.c:372:22: warning: cast removes address space of
	 expression

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/idma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index db6cefa..0e8dd98 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -351,7 +351,7 @@ static void idma_free(struct snd_pcm *pcm)
 	if (!buf->area)
 		return;
 
-	iounmap(buf->area);
+	iounmap((void __iomem *)buf->area);
 
 	buf->area = NULL;
 	buf->addr = 0;
@@ -369,7 +369,7 @@ static int preallocate_idma_buffer(struct snd_pcm *pcm, int stream)
 	buf->dev.type = SNDRV_DMA_TYPE_CONTINUOUS;
 	buf->addr = idma.lp_tx_addr;
 	buf->bytes = idma_hardware.buffer_bytes_max;
-	buf->area = (unsigned char *)ioremap(buf->addr, buf->bytes);
+	buf->area = (unsigned char * __force)ioremap(buf->addr, buf->bytes);
 
 	return 0;
 }
-- 
1.8.0
