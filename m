From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: change micbias widget type to
	supply." to the asoc tree
Date: Thu, 04 Jan 2018 12:37:24 +0000
Message-ID: <E1eX4lw-00061F-2b@debutante>
References: <1514461296-16236-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DC7AA26785A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 13:37:33 +0100 (CET)
In-Reply-To: <1514461296-16236-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, hdegoede@redhat.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: change micbias widget type to supply.

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

>From bd70b19e9e7e87ad330d820386774f304e74d112 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 3 Jan 2018 13:39:01 +0100
Subject: [PATCH] ASoC: rt5645: change micbias widget type to supply.

Register "micbias1" and "micbias2" to supply widgets as modern drivers do.

This should not cause any (new) issues for existing users of the codec,
since micbias support is broken anyways. Micbias support needs the
RT5645_MICBIAS?_POW_CTRL_SEL bits in the RT5645_GEN_CTRL2 register to be
updated when enabled/disabled which we currently do not do.

The updating of these bits will be fixed in a follow-up commit.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index daf7b73ba415..6f6da0abe220 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1980,10 +1980,10 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 
 	/* Input Side */
 	/* micbias */
-	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB1_BIT, 0),
-	SND_SOC_DAPM_MICBIAS("micbias2", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB2_BIT, 0),
+	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
+			RT5645_PWR_MB1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
+			RT5645_PWR_MB2_BIT, 0, NULL, 0),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC L1"),
 	SND_SOC_DAPM_INPUT("DMIC R1"),
-- 
2.15.1
