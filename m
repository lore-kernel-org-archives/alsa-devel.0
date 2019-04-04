From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sprd: Fix the smatch warning" to the asoc tree
Date: Thu,  4 Apr 2019 13:04:21 +0700 (+07)
Message-ID: <20190404060421.68A29441D3C@finisterre.ee.mobilebroadband>
References: <811e491489b62624942dabd56f277b08784ef0f9.1554276741.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <811e491489b62624942dabd56f277b08784ef0f9.1554276741.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, baolin.wang@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.comdan.carpenter@oracle.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sprd: Fix the smatch warning

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

>From adcc9f2b064e60f569979fb1de1f158e8bed8a6d Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 3 Apr 2019 00:47:55 -0700
Subject: [PATCH] ASoC: sprd: Fix the smatch warning

Remove the unnecessary validation of the 'cstream' variable to fix
below smatch warning:

sprd_platform_compr_drain_notify() warn: variable dereferenced
before check 'cstream' (see line 105)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-pcm-compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index dc84257cffc2..424e9834d093 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -107,8 +107,7 @@ static void sprd_platform_compr_drain_notify(void *arg)
 
 	memset(stream->info_area, 0, sizeof(struct sprd_compr_playinfo));
 
-	if (cstream)
-		snd_compr_drain_notify(cstream);
+	snd_compr_drain_notify(cstream);
 }
 
 static void sprd_platform_compr_dma_complete(void *data)
-- 
2.20.1
