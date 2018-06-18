From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TSCS42xx: Add mic bias boost control"
	to the asoc tree
Date: Mon, 18 Jun 2018 12:59:56 +0100
Message-ID: <E1fUspA-0008T3-QW@debutante>
References: <91e206cbabd7c7a7c8d7715b5e51ffef384ac6ec.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EBDE2676DA
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:00 +0200 (CEST)
In-Reply-To: <91e206cbabd7c7a7c8d7715b5e51ffef384ac6ec.1528143829.git.steven.eckhoff.opensource@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TSCS42xx: Add mic bias boost control

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

>From 58f7d470c85801f55bbae2d3c93fe1a3d34aa143 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Mon, 4 Jun 2018 15:45:40 -0500
Subject: [PATCH] ASoC: TSCS42xx: Add mic bias boost control

Add mic bias boost control

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index d18ff17719cc..743194052fc4 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -644,6 +644,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Input Channel Map */
 	SOC_ENUM("Input Channel Map", ch_map_select_enum),
 
+	/* Mic Bias */
+	SOC_SINGLE("Mic Bias Boost Switch", 0x71, 0x07, 1, 0),
+
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
 	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
-- 
2.17.1
