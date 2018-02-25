From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 16/32] ASoC: rt5651: Always keep OVCD enabled
Date: Sun, 25 Feb 2018 11:46:57 +0100
Message-ID: <20180225104713.4745-17-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7AB267408
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:40 +0100 (CET)
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

OVCD is not only useful for jack-type detection, but is also useful
to protect against over-current faults in general, so always keep
OVCD enabled, instead of only enabling it for jack-type detection.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 4f9f0f99c4b0..dfdc8244d308 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1642,7 +1642,7 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 				      RT5651_MIC1_OVTH_MASK |
 				      RT5651_PWR_CLK12M_MASK |
 				      RT5651_PWR_MB_MASK,
-				      RT5651_MIC1_OVCD_DIS |
+				      RT5651_MIC1_OVCD_EN |
 				      RT5651_MIC1_OVTH_600UA |
 				      RT5651_PWR_MB_PU |
 				      RT5651_PWR_CLK12M_PU);
@@ -1832,9 +1832,6 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 
 	if (jack_insert) {
 		rt5651_enable_micbias1_for_ovcd(component);
-		snd_soc_component_update_bits(component, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK,
-				    RT5651_MIC1_OVCD_EN);
 		msleep(100);
 		if (snd_soc_component_read32(component, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
 			jack_type = SND_JACK_HEADPHONE;
@@ -1845,10 +1842,6 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 		rt5651_disable_micbias1_for_ovcd(component);
 	} else { /* jack out */
 		jack_type = 0;
-
-		snd_soc_component_update_bits(component, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK,
-				    RT5651_MIC1_OVCD_DIS);
 	}
 
 	return jack_type;
-- 
2.14.3
