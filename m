From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: uda134x: Explicitly handle in-data
	addresses
Date: Mon, 13 Jul 2015 12:26:46 +0200
Message-ID: <1436783208-1529-3-git-send-email-lars@metafoo.de>
References: <1436783208-1529-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id D4C052605B2
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 12:26:57 +0200 (CEST)
In-Reply-To: <1436783208-1529-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The UDA134X family extends the rather limited L3 register set by using part
of the register value as additional address bits.

These extra address bits are currently stored in the default register cache
and rely on them remaining constant. While this works it is rather
idiomatic and slightly confusing. Change it so that the additional address
bits are explicitly added when writing a register.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda134x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index a89f98a..d47da0e 100644
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
