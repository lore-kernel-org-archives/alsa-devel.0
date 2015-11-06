From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip-max98090: Allow more sample
	rates" to the asoc tree
Date: Fri, 06 Nov 2015 12:09:37 +0000
Message-ID: <E1Zufpp-00057K-Fc@finisterre>
References: <1446809896-11254-3-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 394A9260421
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 13:09:44 +0100 (CET)
In-Reply-To: <1446809896-11254-3-git-send-email-wxt@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip-max98090: Allow more sample rates

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

>From dfc15c9e42819c5bb7586751b3d03534362287aa Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt@rock-chips.com>
Date: Fri, 6 Nov 2015 19:38:15 +0800
Subject: [PATCH] ASoC: rockchip-max98090: Allow more sample rates

The MAX98090 audio codec support sample rates from 8 to 96 kHz
as the dai claim.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 26567b1..5436102 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -80,11 +80,17 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
+	case 24000:
+	case 32000:
 	case 48000:
+	case 64000:
 	case 96000:
 		mclk = 12288000;
 		break;
+	case 11025:
+	case 22050:
 	case 44100:
+	case 88200:
 		mclk = 11289600;
 		break;
 	default:
-- 
2.6.1
