From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 4/7] ASoC: pxa2xx-pcm-lib: fix indenting
Date: Wed, 27 Jun 2018 21:33:56 +0200
Message-ID: <20180627193359.26631-5-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id C50302679A7
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:11 +0200 (CEST)
In-Reply-To: <20180627193359.26631-1-daniel@zonque.org>
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
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

While at it, also fix some indenting.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/arm/pxa2xx-pcm-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index add23d9b4ef6..7931789d4a9f 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -23,8 +23,8 @@ static const struct snd_pcm_hardware pxa2xx_pcm_hardware = {
 				  SNDRV_PCM_INFO_PAUSE |
 				  SNDRV_PCM_INFO_RESUME,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-					SNDRV_PCM_FMTBIT_S24_LE |
-					SNDRV_PCM_FMTBIT_S32_LE,
+				  SNDRV_PCM_FMTBIT_S24_LE |
+				  SNDRV_PCM_FMTBIT_S32_LE,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192 - 32,
 	.periods_min		= 1,
-- 
2.17.1
