From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: increase button detection
	accuracy" to the asoc tree
Date: Wed, 08 Mar 2017 14:23:00 +0100
Message-ID: <E1clbYS-0000Hn-9r@finisterre>
References: <1488971136-19100-5-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BCD8267197
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:23:16 +0100 (CET)
In-Reply-To: <1488971136-19100-5-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: increase button detection accuracy

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

>From 246126b0a4f24f8e88f148c9d0d6d72e6fafe6cc Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 8 Mar 2017 19:05:33 +0800
Subject: [PATCH] ASoC: rt5665: increase button detection accuracy

Use sar adc for button detection to increase accuracy.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 61137160c116..de2c104bbaf3 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1139,7 +1139,8 @@ static void rt5665_enable_push_button_irq(struct snd_soc_codec *codec,
 	bool enable)
 {
 	if (enable) {
-		snd_soc_write(codec, RT5665_4BTN_IL_CMD_1, 0x000b);
+		snd_soc_write(codec, RT5665_4BTN_IL_CMD_1, 0x0003);
+		snd_soc_update_bits(codec, RT5665_SAR_IL_CMD_9, 0x1, 0x1);
 		snd_soc_write(codec, RT5665_IL_CMD_1, 0x0048);
 		snd_soc_update_bits(codec, RT5665_4BTN_IL_CMD_2,
 				RT5665_4BTN_IL_MASK | RT5665_4BTN_IL_RST_MASK,
-- 
2.11.0
