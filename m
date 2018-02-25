From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 12/32] ASoC: rt5651: Only configure LDO
	voltage once at boot
Date: Sun, 25 Feb 2018 11:46:53 +0100
Message-ID: <20180225104713.4745-13-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 620482673F2
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:35 +0100 (CET)
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

Now that rt5651_set_bias_level(BIAS_OFF) no longer modifies the LDO
voltage selection bits, there is no need to set them each time we move
to standby. Instead configure them once at component-probe() time.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 1f3cd79e90d6..249f7b7936e4 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1535,9 +1535,6 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 			snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
 				RT5651_PWR_FV1 | RT5651_PWR_FV2,
 				RT5651_PWR_FV1 | RT5651_PWR_FV2);
-			snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
-				RT5651_PWR_LDO_DVO_MASK,
-				RT5651_PWR_LDO_DVO_1_2V);
 			snd_soc_component_update_bits(component, RT5651_D_MISC, 0x1, 0x1);
 		}
 		break;
@@ -1662,6 +1659,9 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	rt5651->component = component;
 
+	snd_soc_component_update_bits(component, RT5651_PWR_ANLG1,
+		RT5651_PWR_LDO_DVO_MASK, RT5651_PWR_LDO_DVO_1_2V);
+
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	rt5651_apply_properties(component);
-- 
2.14.3
