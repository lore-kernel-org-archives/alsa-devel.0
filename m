From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5631: add Volume to the name of
	volume control" to the asoc tree
Date: Wed, 25 Jul 2018 17:40:47 +0100 (BST)
Message-ID: <20180725164047.F344B1123B08@debutante.sirena.org.uk>
References: <1532051300-11884-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D68A26779F
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:40:49 +0200 (CEST)
In-Reply-To: <1532051300-11884-3-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5631: add Volume to the name of volume control

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

>From d77a760842751eb620a7e74f74e5a5ad6b3d6cef Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 20 Jul 2018 09:48:20 +0800
Subject: [PATCH] ASoC: rt5631: add Volume to the name of volume control

add Volume to the name of volume control.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5631.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index cf6dce69eb2a..e52e4670cf65 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -229,10 +229,10 @@ static SOC_ENUM_SINGLE_DECL(rt5631_spk_ratio_enum, RT5631_GEN_PUR_CTRL_REG,
 static const struct snd_kcontrol_new rt5631_snd_controls[] = {
 	/* MIC */
 	SOC_ENUM("MIC1 Mode Control",  rt5631_mic1_mode_enum),
-	SOC_SINGLE_TLV("MIC1 Boost", RT5631_MIC_CTRL_2,
+	SOC_SINGLE_TLV("MIC1 Boost Volume", RT5631_MIC_CTRL_2,
 		RT5631_MIC1_BOOST_SHIFT, 8, 0, mic_bst_tlv),
 	SOC_ENUM("MIC2 Mode Control", rt5631_mic2_mode_enum),
-	SOC_SINGLE_TLV("MIC2 Boost", RT5631_MIC_CTRL_2,
+	SOC_SINGLE_TLV("MIC2 Boost Volume", RT5631_MIC_CTRL_2,
 		RT5631_MIC2_BOOST_SHIFT, 8, 0, mic_bst_tlv),
 	/* MONO IN */
 	SOC_ENUM("MONOIN Mode Control", rt5631_monoin_mode_enum),
-- 
2.18.0
