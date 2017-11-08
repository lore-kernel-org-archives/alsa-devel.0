From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tpa6130a2: mark expected switch
	fall-through" to the asoc tree
Date: Wed, 08 Nov 2017 21:31:26 +0000
Message-ID: <E1eCXwU-0005IF-QN@debutante>
References: <e577b0ab7a298e7261f3297f6f7a495aa72e88e3.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BA350267680
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:31:45 +0100 (CET)
In-Reply-To: <e577b0ab7a298e7261f3297f6f7a495aa72e88e3.1510170034.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tpa6130a2: mark expected switch fall-through

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

>From 402954f8e573e4b610da6858b8431d4edfd754c8 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Wed, 8 Nov 2017 14:04:22 -0600
Subject: [PATCH] ASoC: tpa6130a2: mark expected switch fall-through

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115164
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 2e014c80d113..616cd4bebd01 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -274,6 +274,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	default:
 		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
 			 data->id);
+		/* fall through */
 	case TPA6130A2:
 		regulator = "Vdd";
 		break;
-- 
2.15.0
