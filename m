From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: fix wrong register for bclk
	ratio control" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:52 +0100
Message-ID: <E1dcXye-0008St-HV@debutante>
References: <1501554653-29727-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BC8E267153
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:17:06 +0200 (CEST)
In-Reply-To: <1501554653-29727-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: fix wrong register for bclk ratio control

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

>From 7e5824c93412c7fd6503e7769f8b6eb7199cd3b8 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 1 Aug 2017 10:30:53 +0800
Subject: [PATCH] ASoC: rt5665: fix wrong register for bclk ratio control

The register of setting back ratio should be RT5665_ADDA_CLK_2
instead of RT5665_ADDA_CLK_1.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 370ed54d1e15..e597c893536d 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4368,12 +4368,12 @@ static int rt5665_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 		switch (dai->id) {
 		case RT5665_AIF2_1:
 		case RT5665_AIF2_2:
-			snd_soc_update_bits(codec, RT5665_ADDA_CLK_1,
+			snd_soc_update_bits(codec, RT5665_ADDA_CLK_2,
 				RT5665_I2S_BCLK_MS2_MASK,
 				RT5665_I2S_BCLK_MS2_64);
 			break;
 		case RT5665_AIF3:
-			snd_soc_update_bits(codec, RT5665_ADDA_CLK_1,
+			snd_soc_update_bits(codec, RT5665_ADDA_CLK_2,
 				RT5665_I2S_BCLK_MS3_MASK,
 				RT5665_I2S_BCLK_MS3_64);
 			break;
-- 
2.13.2
