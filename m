From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: tas5720: add TAS5722 TDM slot
	width setting support" to the asoc tree
Date: Fri, 31 Aug 2018 16:40:43 +0100 (BST)
Message-ID: <20180831154043.DCBE011226FE@debutante.sirena.org.uk>
References: <20180831144714.16499-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C24742679F6
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:40:44 +0200 (CEST)
In-Reply-To: <20180831144714.16499-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrew F ., Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: tas5720: add TAS5722 TDM slot width setting support

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

>From db658f40cae33a9fddbd9ca5c35c6bbfbd593a82 Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Fri, 31 Aug 2018 09:47:14 -0500
Subject: [PATCH] ASoC: codecs: tas5720: add TAS5722 TDM slot width setting
 support

Unlike the TAS5720, the TAS5722 can be configured to utilize 16-bit wide
slots in TDM mode. This can help easing audio clocking/frequency
requirements.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5720.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 3c469112477a..6bd0e5d5347f 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -152,6 +152,7 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				    int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
+	struct tas5720_data *tas5720 = snd_soc_component_get_drvdata(component);
 	unsigned int first_slot;
 	int ret;
 
@@ -185,6 +186,20 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		goto error_snd_soc_component_update_bits;
 
+	/* Configure TDM slot width. This is only applicable to TAS5722. */
+	switch (tas5720->devtype) {
+	case TAS5722:
+		ret = snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
+						    TAS5722_TDM_SLOT_16B,
+						    slot_width == 16 ?
+						    TAS5722_TDM_SLOT_16B : 0);
+		if (ret < 0)
+			goto error_snd_soc_component_update_bits;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 
 error_snd_soc_component_update_bits:
-- 
2.19.0.rc1
