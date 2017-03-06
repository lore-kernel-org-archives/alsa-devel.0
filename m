From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Simplify rates definition" to
	the asoc tree
Date: Mon, 06 Mar 2017 11:46:48 +0100
Message-ID: <E1ckqAC-0002V0-7M@finisterre>
References: <20170224160104.29354-2-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 39454266E25
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:47:32 +0100 (CET)
In-Reply-To: <20170224160104.29354-2-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Romain Perier <romain.perier@collabora.com>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Simplify rates definition

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

>From c7ad841eaef66114d404c8fc02a67f5ef507b1bb Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@collabora.com>
Date: Wed, 1 Mar 2017 10:11:04 +0100
Subject: [PATCH] ASoC: es8328: Simplify rates definition

Currently most of the standard rates are supported by this driver.
Instead of defining each supported rate one by one, we use the SND macro
SNDRV_PCM_RATE_8000_48000. Also adds support for 88.2khz as the codec
supports it and the sys clocks are already supported.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 51dca8662942..1363a68155a9 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -70,13 +70,8 @@ static const char * const supply_names[ES8328_SUPPLY_NUM] = {
 };
 
 #define ES8328_RATES (SNDRV_PCM_RATE_96000 | \
-		SNDRV_PCM_RATE_48000 | \
-		SNDRV_PCM_RATE_44100 | \
-		SNDRV_PCM_RATE_32000 | \
-		SNDRV_PCM_RATE_22050 | \
-		SNDRV_PCM_RATE_16000 | \
-		SNDRV_PCM_RATE_11025 | \
-		SNDRV_PCM_RATE_8000)
+		SNDRV_PCM_RATE_88200 | \
+		SNDRV_PCM_RATE_8000_48000)
 #define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S18_3LE | \
 		SNDRV_PCM_FMTBIT_S20_3LE | \
-- 
2.11.0
