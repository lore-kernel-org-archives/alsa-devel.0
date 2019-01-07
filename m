From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages" to the asoc tree
Date: Mon,  7 Jan 2019 18:57:41 +0000 (GMT)
Message-ID: <20190107185741.DCB5E1127491@debutante.sirena.org.uk>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: 
Sender: stable-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

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

>From 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661 Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 20:29:48 -0600
Subject: [PATCH] ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

snd_pcm_lib_malloc_pages() may fail, so let's check its status and
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index afc559866095..91a2436ce952 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -399,7 +399,13 @@ static int sst_media_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	int ret;
+
+	ret =
+		snd_pcm_lib_malloc_pages(substream,
+				params_buffer_bytes(params));
+	if (ret)
+		return ret;
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	return 0;
 }
-- 
2.20.1
