From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Fix da7219->alc_en state when
	enabling ALC" to the asoc tree
Date: Wed, 21 Oct 2015 13:34:07 +0100
Message-ID: <E1Zosal-0003y6-QF@finisterre>
References: <1445387677.5319.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E35726067D
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 14:34:22 +0200 (CEST)
In-Reply-To: <1445387677.5319.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Fix da7219->alc_en state when enabling ALC

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

>From 638fae17a370a04a02c44c1539b444d94d1a5bf4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 21 Oct 2015 08:34:37 +0800
Subject: [PATCH] ASoC: da7219: Fix da7219->alc_en state when enabling ALC

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index abba4b3..f238c1e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -402,7 +402,7 @@ static int da7219_alc_sw_put(struct snd_kcontrol *kcontrol,
 	/* Force ALC offset calibration if enabling ALC */
 	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
 		da7219_alc_calib(codec);
-		da7219->alc_en = false;
+		da7219->alc_en = true;
 	} else {
 		da7219->alc_en = false;
 	}
-- 
2.6.1
