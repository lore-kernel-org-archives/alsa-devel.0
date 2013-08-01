From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5640: remove unused mux
Date: Thu, 1 Aug 2013 19:29:22 +0800
Message-ID: <1375356562-28151-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D63012655FD
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 13:29:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Remove unused "INL Mux" and "INR Mux".

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
I meet a kernel panic issue if I don't remove the unused widget and modify something in rt5640_dapm_widgets[] and/or rt5640_dapm_routes[].
The message is "Unable to handle kernel paging request at virtual address 6b6b6bd3".
PC is at dapm_clear_walk_output+0x18/0x7c
LR is at dapm_clear_walk_output+0x18/0x7c
If I remove those unused widget, ie. not appear in rt5640_dapm_routes[], everything is fine.
So I think they should be removed.
---
 sound/soc/codecs/rt5640.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index ce585e3..4db7314 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -737,29 +737,6 @@ static const struct snd_kcontrol_new rt5640_mono_mix[] = {
 			RT5640_M_BST1_MM_SFT, 1, 1),
 };
 
-/* INL/R source */
-static const char * const rt5640_inl_src[] = {
-	"IN2P", "MONOP"
-};
-
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_inl_enum, RT5640_INL_INR_VOL,
-	RT5640_INL_SEL_SFT, rt5640_inl_src);
-
-static const struct snd_kcontrol_new rt5640_inl_mux =
-	SOC_DAPM_ENUM("INL source", rt5640_inl_enum);
-
-static const char * const rt5640_inr_src[] = {
-	"IN2N", "MONON"
-};
-
-static const SOC_ENUM_SINGLE_DECL(
-	rt5640_inr_enum, RT5640_INL_INR_VOL,
-	RT5640_INR_SEL_SFT, rt5640_inr_src);
-
-static const struct snd_kcontrol_new rt5640_inr_mux =
-	SOC_DAPM_ENUM("INR source", rt5640_inr_enum);
-
 /* Stereo ADC source */
 static const char * const rt5640_stereo_adc1_src[] = {
 	"DIG MIX", "ADC"
@@ -1005,9 +982,6 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		RT5640_PWR_IN_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("INR VOL", RT5640_PWR_VOL,
 		RT5640_PWR_IN_R_BIT, 0, NULL, 0),
-	/* IN Mux */
-	SND_SOC_DAPM_MUX("INL Mux", SND_SOC_NOPM, 0, 0, &rt5640_inl_mux),
-	SND_SOC_DAPM_MUX("INR Mux", SND_SOC_NOPM, 0, 0, &rt5640_inr_mux),
 	/* REC Mixer */
 	SND_SOC_DAPM_MIXER("RECMIXL", RT5640_PWR_MIXER, RT5640_PWR_RM_L_BIT, 0,
 			rt5640_rec_l_mix, ARRAY_SIZE(rt5640_rec_l_mix)),
-- 
1.8.1.1.439.g50a6b54
