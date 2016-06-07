From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: fix HP Playback Volume control"
	to the asoc tree
Date: Tue, 07 Jun 2016 14:28:00 +0100
Message-ID: <E1bAH32-0001mG-NX@debutante>
References: <1465268588-25478-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E31832665ED
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 15:28:09 +0200 (CEST)
In-Reply-To: <1465268588-25478-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: fix HP Playback Volume control

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

>From e1f42a2f255f30c270500f1e6a69970ab45b0b6f Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 7 Jun 2016 11:03:08 +0800
Subject: [PATCH] ASoC: rt5670: fix HP Playback Volume control

The register setting for HP Playback Volume is inverted. So, set
the invert flag in SOC_DOUBLE_TLV.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 49a9e7049e2b..0af5ddbef1da 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -619,7 +619,7 @@ static const struct snd_kcontrol_new rt5670_snd_controls[] = {
 		RT5670_L_MUTE_SFT, RT5670_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("HP Playback Volume", RT5670_HP_VOL,
 		RT5670_L_VOL_SFT, RT5670_R_VOL_SFT,
-		39, 0, out_vol_tlv),
+		39, 1, out_vol_tlv),
 	/* OUTPUT Control */
 	SOC_DOUBLE("OUT Channel Switch", RT5670_LOUT1,
 		RT5670_VOL_L_SFT, RT5670_VOL_R_SFT, 1, 1),
-- 
2.8.1
