From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320dac31xx: Fix mistype in
	tlv320dac31xx codec" to the asoc tree
Date: Mon, 15 May 2017 17:02:23 +0900
Message-ID: <E1dAAxT-0002O6-Tf@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2001267276
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:32 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Vilda <tomas.vilda@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320dac31xx: Fix mistype in tlv320dac31xx codec

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

>From 51827c41c9ce07293b094691673e6ec23dfdc5e8 Mon Sep 17 00:00:00 2001
From: Tomas Vilda <tomas.vilda@gmail.com>
Date: Sat, 13 May 2017 00:29:37 +0300
Subject: [PATCH] ASoC: tlv320dac31xx: Fix mistype in tlv320dac31xx codec

Signed-off-by: Tomas Vilda <tomas.vilda@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index f8a90ba8cd71..d7d03c92cb8a 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1210,7 +1210,7 @@ static const struct snd_soc_dai_ops aic31xx_dai_ops = {
 
 static struct snd_soc_dai_driver dac31xx_dai_driver[] = {
 	{
-		.name = "tlv32dac31xx-hifi",
+		.name = "tlv320dac31xx-hifi",
 		.playback = {
 			.stream_name	 = "Playback",
 			.channels_min	 = 2,
-- 
2.11.0
