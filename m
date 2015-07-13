From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uda134x: Explicitly handle in-data
	addresses" to the asoc tree
Date: Mon, 13 Jul 2015 12:16:58 +0100
Message-ID: <E1ZEbjG-0006eR-ST@debutante>
References: <1436783208-1529-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 268292617A5
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:17:05 +0200 (CEST)
In-Reply-To: <1436783208-1529-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uda134x: Explicitly handle in-data addresses

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

>From 82c7b531f3328dbbb7a53d0f1dc53b92846c411c Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 13 Jul 2015 12:26:46 +0200
Subject: [PATCH] ASoC: uda134x: Explicitly handle in-data addresses

The UDA134X family extends the rather limited L3 register set by using part
of the register value as additional address bits.

These extra address bits are currently stored in the default register cache
and rely on them remaining constant. While this works it is rather
idiomatic and slightly confusing. Change it so that the additional address
bits are explicitly added when writing a register.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda134x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index a89f98a773d6..d47da0ec8f47 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -39,12 +39,11 @@ struct uda134x_priv {
 	struct snd_pcm_substream *slave_substream;
 };
 
-/* In-data addresses are hard-coded into the reg-cache values */
 static const char uda134x_reg[UDA134X_REGS_NUM] = {
 	/* Extended address registers */
 	0x04, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
 	/* Status, data regs */
-	0x00, 0x83, 0x00, 0x40, 0x80, 0xC0, 0x00,
+	0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
 /*
@@ -99,12 +98,14 @@ static int uda134x_write(struct snd_soc_codec *codec, unsigned int reg,
 	case UDA134X_STATUS0:
 	case UDA134X_STATUS1:
 		addr = UDA134X_STATUS_ADDR;
+		data |= (reg - UDA134X_STATUS0) << 7;
 		break;
 	case UDA134X_DATA000:
 	case UDA134X_DATA001:
 	case UDA134X_DATA010:
 	case UDA134X_DATA011:
 		addr = UDA134X_DATA0_ADDR;
+		data |= (reg - UDA134X_DATA000) << 6;
 		break;
 	case UDA134X_DATA1:
 		addr = UDA134X_DATA1_ADDR;
-- 
2.1.4
