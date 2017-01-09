From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: set high voltage for capless
	power" to the asoc tree
Date: Mon, 09 Jan 2017 20:01:40 +0000
Message-ID: <E1cQg8S-0006wD-SE@debutante>
References: <1482811506-6447-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1627C266EE9
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:48 +0100 (CET)
In-Reply-To: <1482811506-6447-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: set high voltage for capless power

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

>From da369d0ab58cb21371f84a144084a16df7800783 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 27 Dec 2016 12:05:06 +0800
Subject: [PATCH] ASoC: rt5645: set high voltage for capless power

The default capless power mode is low voltage mode. We should set
it to high voltage mode to get fair headphone performance.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1ac96ef9ee20..37fb2b6c34a5 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3109,7 +3109,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	unsigned int val;
 
 	if (jack_insert) {
-		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0006);
+		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0e06);
 
 		/* for jack type detect */
 		snd_soc_dapm_force_enable_pin(dapm, "LDO2");
-- 
2.11.0
