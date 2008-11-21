From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/10] ASoC: Staticise pxa2xx_pcm_ops
Date: Fri, 21 Nov 2008 14:48:32 +0000
Message-ID: <1227278913-25313-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E594A244E2
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:35 +0100 (CET)
In-Reply-To: <1227278913-25313-8-git-send-email-broonie@opensource.wolfsonmicro.com>
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

It's not exported.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index afcd892..0f6b7bb 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -69,7 +69,7 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-struct snd_pcm_ops pxa2xx_pcm_ops = {
+static struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.open		= __pxa2xx_pcm_open,
 	.close		= __pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.5.6.5
