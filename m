From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: add workaround for silence of
	rk3288 ACODEC" to the asoc tree
Date: Fri, 21 Dec 2018 18:14:58 +0000 (GMT)
Message-ID: <20181221181458.EB54D1121B93@debutante.sirena.org.uk>
References: <20181220153636.5213-2-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9169B267944
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 19:15:01 +0100 (CET)
In-Reply-To: <20181220153636.5213-2-katsuhiro@katsuster.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: add workaround for silence of rk3288 ACODEC

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

>From 25af20ae05b95b63cfe655ca248b9dcbf904104c Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Fri, 21 Dec 2018 00:36:36 +0900
Subject: [PATCH] ASoC: rockchip: add workaround for silence of rk3288 ACODEC

This patch adds reset and precharge in shutdown of PCM device.

ACODEC goes to silence if we change Fs to 44.1kHz from 48kHz. This
workaround seems to work but I don't know this workaround is correct
sequence or not for ACODEC.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 71f3fc2d970c..f3442a2283ea 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -261,9 +261,12 @@ static int rk3328_codec_close_playback(struct rk3328_codec_priv *rk3328)
 		mdelay(1);
 	}
 
+	/* Workaround for silence when changed Fs 48 -> 44.1kHz */
+	rk3328_codec_reset(rk3328);
+
 	regmap_update_bits(rk3328->regmap, DAC_PRECHARGE_CTRL,
 			   DAC_CHARGE_CURRENT_ALL_MASK,
-			   DAC_CHARGE_CURRENT_I);
+			   DAC_CHARGE_CURRENT_ALL_ON);
 
 	return 0;
 }
-- 
2.20.1
