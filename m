From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 10/32] ASoC: rt5651: Do not modify jd and
	PLL power bits from set_bias_level()
Date: Sun, 25 Feb 2018 11:46:51 +0100
Message-ID: <20180225104713.4745-11-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D901B2673D6
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:32 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

rt5651_set_bias_level(BIAS_OFF) used to unconditionally clear the entire
register, including the jack-detect and PLL power bits. When jack-detection
support was introduced a special case for jack-detect was added which
hard-codes a register value to keep both on.

This commit removes the jack-detect special case, instead simply leaving
these bits as is on BIAS_OFF.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 22f233e00ef9..4d5d934794da 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1516,8 +1516,6 @@ static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5651_set_bias_level(struct snd_soc_component *component,
 			enum snd_soc_bias_level level)
 {
-	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
-
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == snd_soc_component_get_bias_level(component)) {
@@ -1553,11 +1551,9 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
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
2.14.3
