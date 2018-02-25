From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 13/32] ASoC: rt5651: Remove "JD Power" dapm
	supply
Date: Sun, 25 Feb 2018 11:46:54 +0100
Message-ID: <20180225104713.4745-14-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id AC7D32673F4
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:36 +0100 (CET)
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

Remove the "JD power" dapm supply which gets force-enabled once when
using jack-detect and never gets disabled again.

Since the PWR_JD_M bit simply needs to be always on when using jack-detect
there is no need to have it tracked by dapm, instead we can simply set it
to 1 once when initializing the jack-detection.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 249f7b7936e4..bfacf8ea6069 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -864,10 +864,6 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("ADC ASRC", 1, RT5651_PLL_MODE_2,
 			      11, 0, NULL, 0),
 
-	/* Input Side */
-	SND_SOC_DAPM_SUPPLY("JD Power", RT5651_PWR_ANLG2,
-		RT5651_PWM_JD_M_BIT, 0, NULL, 0),
-
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
 			RT5651_PWR_LDO_BIT, 0, NULL, 0),
@@ -1616,7 +1612,10 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	snd_soc_dapm_force_enable_pin(dapm, "JD Power");
+	/* Enable jack detect power */
+	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
+		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
+
 	snd_soc_dapm_force_enable_pin(dapm, "LDO");
 	snd_soc_dapm_sync(dapm);
 
-- 
2.14.3
