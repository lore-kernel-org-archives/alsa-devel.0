From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add IN3 Boost volume control"
	to the asoc tree
Date: Thu, 19 Jul 2018 17:57:12 +0100
Message-ID: <E1fgCEq-0005Ss-LY@debutante>
References: <20180718205542.12364-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E114F26776A
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:57:17 +0200 (CEST)
In-Reply-To: <20180718205542.12364-2-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Add IN3 Boost volume control

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

>From eea1662525bd4a158a67ac836b2a1fd9cf77cc81 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Jul 2018 22:55:37 +0200
Subject: [PATCH] ASoC: rt5651: Add IN3 Boost volume control

Add a mixer control for the IN3 Boost volume, IN3 is used for the headset
mic on most devices, so this is necessary to control the headset mic
volume.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 0462049e739c..985852fd9723 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -331,11 +331,13 @@ static const struct snd_kcontrol_new rt5651_snd_controls[] = {
 	SOC_DOUBLE_TLV("Mono DAC Playback Volume", RT5651_DAC2_DIG_VOL,
 			RT5651_L_VOL_SFT, RT5651_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
-	/* IN1/IN2 Control */
+	/* IN1/IN2/IN3 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5651_IN1_IN2,
 		RT5651_BST_SFT1, 8, 0, bst_tlv),
 	SOC_SINGLE_TLV("IN2 Boost", RT5651_IN1_IN2,
 		RT5651_BST_SFT2, 8, 0, bst_tlv),
+	SOC_SINGLE_TLV("IN3 Boost", RT5651_IN3,
+		RT5651_BST_SFT1, 8, 0, bst_tlv),
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5651_INL1_INR1_VOL,
 			RT5651_INL_VOL_SFT, RT5651_INR_VOL_SFT,
-- 
2.18.0
