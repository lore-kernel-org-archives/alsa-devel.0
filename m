From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 11/32] ASoC: rt5651: Remove programming of
	PWR regs before force_bias_level() call
Date: Sun, 25 Feb 2018 11:46:52 +0100
Message-ID: <20180225104713.4745-12-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AB952673D6
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:34 +0100 (CET)
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

Remove the setup of the PWR_ANLG1 reg which was done directly before
calling snd_soc_component_force_bias_level(SND_SOC_BIAS_OFF), as the
latter will override any settings done to PWR_ANLG1 immediately anyways.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 4d5d934794da..1f3cd79e90d6 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1662,16 +1662,6 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	rt5651->component = component;
 
-	snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
-		RT5651_PWR_VREF1 | RT5651_PWR_MB |
-		RT5651_PWR_BG | RT5651_PWR_VREF2,
-		RT5651_PWR_VREF1 | RT5651_PWR_MB |
-		RT5651_PWR_BG | RT5651_PWR_VREF2);
-	usleep_range(10000, 15000);
-	snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
-		RT5651_PWR_FV1 | RT5651_PWR_FV2,
-		RT5651_PWR_FV1 | RT5651_PWR_FV2);
-
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	rt5651_apply_properties(component);
-- 
2.14.3
