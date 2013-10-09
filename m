From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dapm: Run clock and regulator events
	separately to other supplies
Date: Wed,  9 Oct 2013 14:01:19 +0100
Message-ID: <1381323679-11390-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B742610D4
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 15:01:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

In order to avoid trying to use an external clock or supply for an
on-chip supply prior to it being enabled move the clock and regulator
supply events to a separate step in DAPM sequencing from normal supply
events.

This should have minimal practical impact since these widgets are sorted
using SND_SOC_NOPM which is a negative value and hence sorted
separately to any real register writes, though it may be relevant if
supplies have event callbacks only.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-dapm.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 905e4c5..eb26d5a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -59,31 +59,31 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
-	[snd_soc_dapm_supply] = 1,
 	[snd_soc_dapm_regulator_supply] = 1,
 	[snd_soc_dapm_clock_supply] = 1,
-	[snd_soc_dapm_micbias] = 2,
+	[snd_soc_dapm_supply] = 2,
+	[snd_soc_dapm_micbias] = 3,
 	[snd_soc_dapm_dai_link] = 2,
-	[snd_soc_dapm_dai_in] = 3,
-	[snd_soc_dapm_dai_out] = 3,
-	[snd_soc_dapm_aif_in] = 3,
-	[snd_soc_dapm_aif_out] = 3,
-	[snd_soc_dapm_mic] = 4,
-	[snd_soc_dapm_mux] = 5,
-	[snd_soc_dapm_virt_mux] = 5,
-	[snd_soc_dapm_value_mux] = 5,
-	[snd_soc_dapm_dac] = 6,
-	[snd_soc_dapm_switch] = 7,
-	[snd_soc_dapm_mixer] = 7,
-	[snd_soc_dapm_mixer_named_ctl] = 7,
-	[snd_soc_dapm_pga] = 8,
-	[snd_soc_dapm_adc] = 9,
-	[snd_soc_dapm_out_drv] = 10,
-	[snd_soc_dapm_hp] = 10,
-	[snd_soc_dapm_spk] = 10,
-	[snd_soc_dapm_line] = 10,
-	[snd_soc_dapm_kcontrol] = 11,
-	[snd_soc_dapm_post] = 12,
+	[snd_soc_dapm_dai_in] = 4,
+	[snd_soc_dapm_dai_out] = 4,
+	[snd_soc_dapm_aif_in] = 4,
+	[snd_soc_dapm_aif_out] = 4,
+	[snd_soc_dapm_mic] = 5,
+	[snd_soc_dapm_mux] = 6,
+	[snd_soc_dapm_virt_mux] = 6,
+	[snd_soc_dapm_value_mux] = 6,
+	[snd_soc_dapm_dac] = 7,
+	[snd_soc_dapm_switch] = 8,
+	[snd_soc_dapm_mixer] = 8,
+	[snd_soc_dapm_mixer_named_ctl] = 8,
+	[snd_soc_dapm_pga] = 9,
+	[snd_soc_dapm_adc] = 10,
+	[snd_soc_dapm_out_drv] = 11,
+	[snd_soc_dapm_hp] = 11,
+	[snd_soc_dapm_spk] = 11,
+	[snd_soc_dapm_line] = 11,
+	[snd_soc_dapm_kcontrol] = 12,
+	[snd_soc_dapm_post] = 13,
 };
 
 static int dapm_down_seq[] = {
@@ -109,10 +109,10 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_dai_in] = 10,
 	[snd_soc_dapm_dai_out] = 10,
 	[snd_soc_dapm_dai_link] = 11,
-	[snd_soc_dapm_clock_supply] = 12,
-	[snd_soc_dapm_regulator_supply] = 12,
 	[snd_soc_dapm_supply] = 12,
-	[snd_soc_dapm_post] = 13,
+	[snd_soc_dapm_clock_supply] = 13,
+	[snd_soc_dapm_regulator_supply] = 13,
+	[snd_soc_dapm_post] = 14,
 };
 
 static void pop_wait(u32 pop_time)
-- 
1.8.4.rc3
