From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: avoid limiting
	params->msbits in hw_params()" to the asoc tree
Date: Mon,  4 Mar 2019 14:28:28 +0000 (GMT)
Message-ID: <20190304142828.D80421128814@debutante.sirena.org.uk>
References: <E1gzNdw-00059M-54@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE70BF896EB
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 15:28:35 +0100 (CET)
In-Reply-To: <E1gzNdw-00059M-54@rmk-PC.armlinux.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: avoid limiting params->msbits in hw_params()

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

>From bbf62563d8622434c761cb96569c132467f88597 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Thu, 28 Feb 2019 15:30:40 +0000
Subject: [PATCH] ASoC: hdmi-codec: avoid limiting params->msbits in
 hw_params()

Limiting the value of the passed in params->msbits in the hw_params()
callback is redundant on three counts:

1. We already specify in the DAI driver that we can only handle up to
   24 bits.  This means msbits will be limited to 24 via the ALSA
   constraints imposed by the ASoC core, unless we have multiple codecs
   that can handle more bits.

2. Nothing in our hw_params() implementation uses this value.

3. The copy of the params that we are passed by the ASoC core never
   reads back the msbits value.

Consequently, this code is unnecessary and does nothing useful.  Remove
it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d5f73c837281..35df73e42cbc 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -484,9 +484,6 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 		params_width(params), params_rate(params),
 		params_channels(params));
 
-	if (params_width(params) > 24)
-		params->msbits = 24;
-
 	ret = snd_pcm_create_iec958_consumer_hw_params(params, hp.iec.status,
 						       sizeof(hp.iec.status));
 	if (ret < 0) {
-- 
2.20.1
