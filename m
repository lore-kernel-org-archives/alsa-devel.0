From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: Add support sample rate to
	192KHz" to the asoc tree
Date: Fri, 29 Jan 2016 12:40:45 +0100
Message-ID: <E1aP7Px-0006xf-FE@finisterre>
References: <1454064278-5791-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A4D265D7A
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 12:40:59 +0100 (CET)
In-Reply-To: <1454064278-5791-1-git-send-email-zhengxing@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xing Zheng <zhengxing@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: Add support sample rate to 192KHz

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

>From 4e26ad80cbd3a6b0d606201892e81a9a9c6864ce Mon Sep 17 00:00:00 2001
From: Xing Zheng <zhengxing@rock-chips.com>
Date: Fri, 29 Jan 2016 01:47:12 +0000
Subject: [PATCH] ASoC: rt5616: Add support sample rate to 192KHz

Reference the TRM, the ALC5616 support one 24bit/8KHz ~ 192KHz
I2S/PCM Interface for stereo DAC and stereo ADC.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index fdca636..3704d07 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1261,7 +1261,7 @@ static int rt5616_resume(struct snd_soc_codec *codec)
 #define rt5616_resume NULL
 #endif
 
-#define RT5616_STEREO_RATES SNDRV_PCM_RATE_8000_96000
+#define RT5616_STEREO_RATES SNDRV_PCM_RATE_8000_192000
 #define RT5616_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-- 
2.6.4
