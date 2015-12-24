From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Fix bclk for sample rates that are multiple of 4kHz" to the asoc tree
Date: Thu, 24 Dec 2015 19:18:09 +0000
Message-ID: <E1aCBOr-0008Q5-2R@finisterre>
References: <1450880285-23865-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1450880285-23865-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: stable-owner@vger.kernel.org
To: Nikesh Oswal <Nikesh.Oswal@cirrus.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Fix bclk for sample rates that are multiple of 4kHz

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

>From e73694d871867cae8471d2350ce89acb38bc2b63 Mon Sep 17 00:00:00 2001
From: Nikesh Oswal <Nikesh.Oswal@cirrus.com>
Date: Wed, 23 Dec 2015 14:18:05 +0000
Subject: [PATCH] ASoC: arizona: Fix bclk for sample rates that are multiple of
 4kHz

For a sample rate of 12kHz the bclk was taken from the 44.1kHz table as
we test for a multiple of 8kHz. This patch fixes this issue by testing
for multiples of 4kHz instead.

Signed-off-by: Nikesh Oswal <Nikesh.Oswal@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9929efc..5070a97 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1543,7 +1543,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	bool reconfig;
 	unsigned int aif_tx_state, aif_rx_state;
 
-	if (params_rate(params) % 8000)
+	if (params_rate(params) % 4000)
 		rates = &arizona_44k1_bclk_rates[0];
 	else
 		rates = &arizona_48k_bclk_rates[0];
-- 
2.6.4
