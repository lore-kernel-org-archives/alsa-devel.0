From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa2xx-pcm-lib: fix indenting" to the
	asoc tree
Date: Fri, 29 Jun 2018 12:07:16 +0100
Message-ID: <E1fYrFE-0002cL-Eh@debutante>
References: <20180627193359.26631-5-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BC30267A3C
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 13:07:18 +0200 (CEST)
In-Reply-To: <20180627193359.26631-5-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa2xx-pcm-lib: fix indenting

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 456ec80876564edb74a0fff78499beb7ca286302 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 27 Jun 2018 21:33:56 +0200
Subject: [PATCH] ASoC: pxa2xx-pcm-lib: fix indenting

While at it, also fix some indenting.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0.rc2
