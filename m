From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: improve IRQ reaction time for
	HS button" to the asoc tree
Date: Tue, 05 Jan 2016 12:33:11 +0000
Message-ID: <E1aGQnX-0007Uq-OZ@debutante>
References: <1451974931-23864-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D41EF2607F7
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:33:19 +0100 (CET)
In-Reply-To: <1451974931-23864-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: improve IRQ reaction time for HS button

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

>From 15b0f4d4b169dde8ecc4e162bcd6cd145cb09fed Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 5 Jan 2016 14:22:11 +0800
Subject: [PATCH] ASoC: rt5645: improve IRQ reaction time for HS button

IRQ reaction time is not immediate when headset putton is pressed.
This patch shortens the reaction time.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index bd23496a56ff..4b079d189aac 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3062,6 +3062,7 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
 		snd_soc_dapm_sync(dapm);
 
+		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD1, 0x3, 0x3);
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
 		snd_soc_update_bits(codec,
-- 
2.6.2
