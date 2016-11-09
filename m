From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lpass-platform: initialize dma channel number" to the asoc tree
Date: Wed, 09 Nov 2016 15:00:02 +0000
Message-ID: <E1c4UM6-0002jH-7B@finisterre>
References: <20161108133916.1742379-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108133916.1742379-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>Kenneth Westfield <kwestfie@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lpass-platform: initialize dma channel number

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

>From 3b89e4b77ef9c2f985964fab17032db98f074ed0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 8 Nov 2016 14:38:52 +0100
Subject: [PATCH] ASoC: lpass-platform: initialize dma channel number
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A bugfix accidentally removed the implicit initialization of the
dma channel number, causing undefined behavior when
v->alloc_dma_channel is NULL:

sound/soc/qcom/lpass-platform.c: In function ‘lpass_platform_pcmops_open’:
sound/soc/qcom/lpass-platform.c:83:29: error: ‘dma_ch’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

This adds back an explicit initialization to zero, restoring the
previous behavior for that case.

Fixes: 022d00ee0b55 ("ASoC: lpass-platform: Fix broken pcm data usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 07000f53db44..e223bc90b2ef 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -77,6 +77,9 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 
 	if (v->alloc_dma_channel)
 		dma_ch = v->alloc_dma_channel(drvdata, dir);
+	else
+		dma_ch = 0;
+
 	if (dma_ch < 0)
 		return dma_ch;
 
-- 
2.10.2
