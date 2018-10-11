From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Sort Digital Volume in
	reverse order" to the asoc tree
Date: Thu, 11 Oct 2018 15:46:21 +0100 (BST)
Message-ID: <20181011144621.6F77C11223ED@debutante.sirena.org.uk>
References: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C579E267948
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 16:46:22 +0200 (CEST)
In-Reply-To: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, Ryan Lee <ryans.lee@maximintegrated.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Sort Digital Volume in reverse order

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

>From 4cbbc91609846c09a8350080cd7e6f7764fb2ec1 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Wed, 10 Oct 2018 23:26:06 +0000
Subject: [PATCH] ASoC: max98373: Sort Digital Volume in reverse order

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index d6868c9a9ce6..9b7ccd351cae 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -455,7 +455,7 @@ SND_SOC_DAPM_SIGGEN("IMON"),
 SND_SOC_DAPM_SIGGEN("FBMON"),
 };
 
-static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, 0, -50, 0);
+static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, -6350, 50, 1);
 static const DECLARE_TLV_DB_RANGE(max98373_spk_tlv,
 	0, 8, TLV_DB_SCALE_ITEM(0, 50, 0),
 	9, 10, TLV_DB_SCALE_ITEM(500, 100, 0),
@@ -605,7 +605,7 @@ SOC_SINGLE("Dither Switch", MAX98373_R203F_AMP_DSP_CFG,
 SOC_SINGLE("DC Blocker Switch", MAX98373_R203F_AMP_DSP_CFG,
 	MAX98373_AMP_DSP_CFG_DCBLK_SHIFT, 1, 0),
 SOC_SINGLE_TLV("Digital Volume", MAX98373_R203D_AMP_DIG_VOL_CTRL,
-	0, 0x7F, 0, max98373_digital_tlv),
+	0, 0x7F, 1, max98373_digital_tlv),
 SOC_SINGLE_TLV("Speaker Volume", MAX98373_R203E_AMP_PATH_GAIN,
 	MAX98373_SPK_DIGI_GAIN_SHIFT, 10, 0, max98373_spk_tlv),
 SOC_SINGLE_TLV("FS Max Volume", MAX98373_R203E_AMP_PATH_GAIN,
-- 
2.19.0.rc2
