From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Do not modify jd and PLL power
	bits from set_bias_level()" to the asoc tree
Date: Thu, 01 Mar 2018 19:26:13 +0000
Message-ID: <E1erTqH-0001XJ-PS@debutante>
References: <20180225104713.4745-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A0E3267BA9
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:26:22 +0100 (CET)
In-Reply-To: <20180225104713.4745-11-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Do not modify jd and PLL power bits from set_bias_level()

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

>From 887fcc6f0514380f17d5016dd8cdfc4d9a4437ee Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:51 +0100
Subject: [PATCH] ASoC: rt5651: Do not modify jd and PLL power bits from
 set_bias_level()

rt5651_set_bias_level(BIAS_OFF) used to unconditionally clear the entire
register, including the jack-detect and PLL power bits. When jack-detection
support was introduced a special case for jack-detect was added which
hard-codes a register value to keep both on.

This commit removes the jack-detect special case, instead simply leaving
these bits as is on BIAS_OFF.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index c93539ee2200..d4fb16686889 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1521,8 +1521,6 @@ static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5651_set_bias_level(struct snd_soc_component *component,
 			enum snd_soc_bias_level level)
 {
-	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
-
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == snd_soc_component_get_bias_level(component)) {
@@ -1558,11 +1556,9 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 		/* Do not touch the LDO voltage select bits on bias-off */
 		snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
 			~RT5651_PWR_LDO_DVO_MASK, 0);
-		if (rt5651->jd_src) {
-			snd_soc_component_write(component, RT5651_PWR_ANLG2, 0x0204);
-		} else {
-			snd_soc_component_write(component, RT5651_PWR_ANLG2, 0x0000);
-		}
+		/* Leave PLL1 and jack-detect power as is, all others off */
+		snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
+				    ~(RT5651_PWR_PLL | RT5651_PWR_JD_M), 0);
 		break;
 
 	default:
-- 
2.16.2
