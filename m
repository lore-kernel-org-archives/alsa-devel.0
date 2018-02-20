From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 04/11] ASoC: rt5651: Simplify set_bias_level()
Date: Tue, 20 Feb 2018 23:15:04 +0100
Message-ID: <20180220221511.22861-4-hdegoede@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3509326751B
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 23:15:24 +0100 (CET)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

There is no need to set the LDO voltage to 1.2 volt each time we enter
standby, instead always leave it 1.2 volt on BIAS_OFF. Note we do a
snd_soc_codec_force_bias_level(BIAS_OFF) on probe, so this will configure
it correctly right from the start.

For PWR_ANLG2 leave the RT5651_PWR_JD_M and PLL bits as is instead of
having different code-paths for when we've jack-detect vs when we don't.

Note that this also stops enabling the PLL bit when we've a jd_src and we
are running of the RCCLK, this is intentional.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 52fb835ea584..4b0509f7e001 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1513,8 +1513,6 @@ static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
-	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
-
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
@@ -1527,9 +1525,6 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
 				RT5651_PWR_FV1 | RT5651_PWR_FV2,
 				RT5651_PWR_FV1 | RT5651_PWR_FV2);
-			snd_soc_update_bits(codec, RT5651_PWR_ANLG1,
-				RT5651_PWR_LDO_DVO_MASK,
-				RT5651_PWR_LDO_DVO_1_2V);
 			snd_soc_update_bits(codec, RT5651_D_MISC, 0x1, 0x1);
 			if (snd_soc_read(codec, RT5651_PLL_MODE_1) & 0x9200)
 				snd_soc_update_bits(codec, RT5651_D_MISC,
@@ -1543,13 +1538,11 @@ static int rt5651_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, RT5651_PWR_DIG2, 0x0000);
 		snd_soc_write(codec, RT5651_PWR_VOL, 0x0000);
 		snd_soc_write(codec, RT5651_PWR_MIXER, 0x0000);
-		if (rt5651->pdata.jd_src) {
-			snd_soc_write(codec, RT5651_PWR_ANLG2, 0x0204);
-			snd_soc_write(codec, RT5651_PWR_ANLG1, 0x0002);
-		} else {
-			snd_soc_write(codec, RT5651_PWR_ANLG1, 0x0000);
-			snd_soc_write(codec, RT5651_PWR_ANLG2, 0x0000);
-		}
+		snd_soc_write(codec, RT5651_PWR_ANLG1, RT5651_PWR_LDO_DVO_1_2V);
+		/* Leave PLL1 and jack-detect power as is, all others off */
+		snd_soc_update_bits(codec, RT5651_PWR_ANLG2,
+				    ~(RT5651_PWR_PLL | RT5651_PWR_JD_M),
+				    0x0000);
 		break;
 
 	default:
-- 
2.14.3
