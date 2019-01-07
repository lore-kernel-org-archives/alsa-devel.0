From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: store eq kcontrol byte in __be"
	to the asoc tree
Date: Mon,  7 Jan 2019 18:58:00 +0000 (GMT)
Message-ID: <20190107185800.2D1431127491@debutante.sirena.org.uk>
References: <20190105020249.8639-21-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E958226732F
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:58:00 +0100 (CET)
In-Reply-To: <20190105020249.8639-21-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: store eq kcontrol byte in __be

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

>From 60b52ed627213d1782e70b9810f5668f61bba3a8 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:48 -0600
Subject: [PATCH] ASoC: rt5645: store eq kcontrol byte in __be

The eq parameters binary is stored in __be. However, it is unsigned short
in rt5645_eq_param_s{} which will cause incorrect type assignment. So add
struct rt5645_eq_param_s_be16{} to store the eq binary and convert it to
unsigned short in rt5645->eq_param.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 52ce380c8f3a..9a0751978090 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -401,6 +401,11 @@ struct rt5645_eq_param_s {
 	unsigned short val;
 };
 
+struct rt5645_eq_param_s_be16 {
+	__be16 reg;
+	__be16 val;
+};
+
 static const char *const rt5645_supply_names[] = {
 	"avdd",
 	"cpvdd",
@@ -672,8 +677,8 @@ static int rt5645_hweq_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
-	struct rt5645_eq_param_s *eq_param =
-		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	struct rt5645_eq_param_s_be16 *eq_param =
+		(struct rt5645_eq_param_s_be16 *)ucontrol->value.bytes.data;
 	int i;
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
@@ -698,36 +703,33 @@ static int rt5645_hweq_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
-	struct rt5645_eq_param_s *eq_param =
-		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	struct rt5645_eq_param_s_be16 *eq_param =
+		(struct rt5645_eq_param_s_be16 *)ucontrol->value.bytes.data;
 	int i;
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
-		eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
-		eq_param[i].val = be16_to_cpu(eq_param[i].val);
+		rt5645->eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
+		rt5645->eq_param[i].val = be16_to_cpu(eq_param[i].val);
 	}
 
 	/* The final setting of the table should be RT5645_EQ_CTRL2 */
 	for (i = RT5645_HWEQ_NUM - 1; i >= 0; i--) {
-		if (eq_param[i].reg == 0)
+		if (rt5645->eq_param[i].reg == 0)
 			continue;
-		else if (eq_param[i].reg != RT5645_EQ_CTRL2)
+		else if (rt5645->eq_param[i].reg != RT5645_EQ_CTRL2)
 			return 0;
 		else
 			break;
 	}
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
-		if (!rt5645_validate_hweq(eq_param[i].reg) &&
-			eq_param[i].reg != 0)
+		if (!rt5645_validate_hweq(rt5645->eq_param[i].reg) &&
+		    rt5645->eq_param[i].reg != 0)
 			return 0;
-		else if (eq_param[i].reg == 0)
+		else if (rt5645->eq_param[i].reg == 0)
 			break;
 	}
 
-	memcpy(rt5645->eq_param, eq_param,
-		RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
-
 	return 0;
 }
 
-- 
2.20.1
