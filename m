From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: Staticise au1xpsc_soc_platform
Date: Tue, 13 Dec 2011 10:14:30 +0800
Message-ID: <1323742470.2544.2.camel@phoenix>
References: <1323742393.2544.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA40D103A61
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 03:15:14 +0100 (CET)
Received: by ggnv5 with SMTP id v5so6348791ggn.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 18:15:14 -0800 (PST)
In-Reply-To: <1323742393.2544.1.camel@phoenix>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/au1x/dbdma2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 09699de..92bc1b0 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -341,7 +341,7 @@ static int au1xpsc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* au1xpsc audio platform */
-struct snd_soc_platform_driver au1xpsc_soc_platform = {
+static struct snd_soc_platform_driver au1xpsc_soc_platform = {
 	.ops		= &au1xpsc_pcm_ops,
 	.pcm_new	= au1xpsc_pcm_new,
 	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
-- 
1.7.5.4
