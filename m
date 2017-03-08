From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: CLKDET is also a power of ASRC"
	to the asoc tree
Date: Wed, 08 Mar 2017 14:23:04 +0100
Message-ID: <E1clbYW-0000JV-2l@finisterre>
References: <1488971136-19100-4-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D629267190
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:23:20 +0100 (CET)
In-Reply-To: <1488971136-19100-4-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: CLKDET is also a power of ASRC

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

>From 09b50c3703cc354100fe36202ef5e52ee128b904 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 8 Mar 2017 19:05:32 +0800
Subject: [PATCH] ASoC: rt5665: CLKDET is also a power of ASRC

We need to power on CLKDET to use ASRC function.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7a0244e5e321..61137160c116 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -3178,6 +3178,9 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 	{"DAC Mono Right Filter", NULL, "DAC Mono R ASRC", is_using_asrc},
 	{"DAC Stereo1 Filter", NULL, "DAC STO1 ASRC", is_using_asrc},
 	{"DAC Stereo2 Filter", NULL, "DAC STO2 ASRC", is_using_asrc},
+	{"I2S1 ASRC", NULL, "CLKDET"},
+	{"I2S2 ASRC", NULL, "CLKDET"},
+	{"I2S3 ASRC", NULL, "CLKDET"},
 
 	/*Vref*/
 	{"Mic Det Power", NULL, "Vref2"},
-- 
2.11.0
