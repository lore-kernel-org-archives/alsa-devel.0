From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fix typo in algorithm list warning message" to the asoc tree
Date: Fri, 26 May 2017 12:41:57 +0100
Message-ID: <E1dEDcz-0000kl-3U@debutante>
References: <1495792027-2290-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495792027-2290-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fix typo in algorithm list warning message

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 503ada8a6d00c70f5b6fe37249e9a5e2f9c9e202 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Fri, 26 May 2017 10:47:07 +0100
Subject: [PATCH] ASoC: wm_adsp: Fix typo in algorithm list warning message

The list terminator is 0xbedead but the message warning if it
wasn't found was showing that 0xbeadead was expected.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5aff83be375c..65c059b5ffd7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1888,7 +1888,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	}
 
 	if (be32_to_cpu(val) != 0xbedead)
-		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbeadead\n",
+		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbedead\n",
 			  pos + len, be32_to_cpu(val));
 
 	alg = kzalloc(len * 2, GFP_KERNEL | GFP_DMA);
-- 
2.11.0
