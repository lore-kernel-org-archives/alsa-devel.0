From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: Staticise alchemy_pcm_soc_platform
Date: Tue, 13 Dec 2011 10:15:40 +0800
Message-ID: <1323742540.2544.3.camel@phoenix>
References: <1323742393.2544.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EFE82103A73
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 03:15:46 +0100 (CET)
Received: by vcbfl15 with SMTP id fl15so4509024vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 18:15:46 -0800 (PST)
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
 sound/soc/au1x/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index dc4dae4..c4017bd 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -316,7 +316,7 @@ static int alchemy_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-struct snd_soc_platform_driver alchemy_pcm_soc_platform = {
+static struct snd_soc_platform_driver alchemy_pcm_soc_platform = {
 	.ops		= &alchemy_pcm_ops,
 	.pcm_new	= alchemy_pcm_new,
 	.pcm_free	= alchemy_pcm_free_dma_buffers,
-- 
1.7.5.4
