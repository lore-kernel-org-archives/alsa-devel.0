From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Use correct shift
	definition for DATALEN bits" to the asoc tree
Date: Wed, 13 Dec 2017 15:45:31 +0000
Message-ID: <E1eP9Dv-0002KN-Vi@debutante>
References: <20171212224311.24045-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B36CF267901
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 16:45:34 +0100 (CET)
In-Reply-To: <20171212224311.24045-5-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Use correct shift definition for DATALEN bits

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

>From 77bdb58795d86262e96ba37524489ba0969de253 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 12 Dec 2017 16:43:06 -0600
Subject: [PATCH] ASoC: tlv320aic32x4: Use correct shift definition for DATALEN
 bits

Setting the DATALEN bit field requires shifting our value by 4. Setting
the OSR value of the PLL divider also requires a shift by 4. Currently
the code abuses this fact and uses the shift for the divider register to
set the data-length register. Fix this here by using the definition meant
for this register.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 8f9719e6cdfd..9f643199e1ba 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -738,15 +738,20 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	data = data & ~(3 << 4);
 	switch (params_width(params)) {
 	case 16:
+		data |= (AIC32X4_WORD_LEN_16BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 20:
-		data |= (AIC32X4_WORD_LEN_20BITS << AIC32X4_DOSRMSB_SHIFT);
+		data |= (AIC32X4_WORD_LEN_20BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 24:
-		data |= (AIC32X4_WORD_LEN_24BITS << AIC32X4_DOSRMSB_SHIFT);
+		data |= (AIC32X4_WORD_LEN_24BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 32:
-		data |= (AIC32X4_WORD_LEN_32BITS << AIC32X4_DOSRMSB_SHIFT);
+		data |= (AIC32X4_WORD_LEN_32BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	}
 	snd_soc_write(codec, AIC32X4_IFACE1, data);
-- 
2.15.1
