From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2.6.28] ALSA: Ensure PXA runtime data is
	initialised
Date: Wed, 22 Oct 2008 13:27:49 +0100
Message-ID: <1224678469-26243-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 235F51037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 14:28:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The rest of the code relies on the runtime data being zero initialised
so we need to use kzalloc() to allocate it.

Reported-by: Oliver Ford <ipaqlinux@oliford.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/arm/pxa2xx-pcm-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 1c93eb7..75a0d74 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -194,7 +194,7 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 		goto out;
 
 	ret = -ENOMEM;
-	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
+	rtd = kzalloc(sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
 		goto out;
 	rtd->dma_desc_array =
-- 
1.5.6.5
