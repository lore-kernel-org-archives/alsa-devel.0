From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cros_ec_codec: Make symbol
	'cros_ec_dai' static" to the asoc tree
Date: Wed, 13 Feb 2019 11:53:29 +0000 (GMT)
Message-ID: <20190213115329.9F9DE1128158@debutante.sirena.org.uk>
References: <20190213062956.146536-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C4B2678A2
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 12:53:36 +0100 (CET)
In-Reply-To: <20190213062956.146536-1-weiyongjun1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Girdwood <lgirdwood@gmail.com>, Liam@sirena.org.uk, Guenter Roeck <groeck@chromium.org>, Jaroslav@sirena.org.uk, Mark Brown <broonie@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static

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

>From a4cbb465bcc98f1c5740c887d4be3a68f1a47279 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 13 Feb 2019 06:29:56 +0000
Subject: [PATCH] ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static

Fixes the following sparse warning:

sound/soc/codecs/cros_ec_codec.c:209:27: warning:
 symbol 'cros_ec_dai' was not declared. Should it be static?

Fixes: b291f42a3718 ("ASoC: cros_ec_codec: Add codec driver for Cros EC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index b14100b6a939..99a3af8a15ff 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -206,7 +206,7 @@ static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
 	.set_fmt = cros_ec_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver cros_ec_dai[] = {
+static struct snd_soc_dai_driver cros_ec_dai[] = {
 	{
 		.name = "cros_ec_codec I2S",
 		.id = 0,
-- 
2.20.1
