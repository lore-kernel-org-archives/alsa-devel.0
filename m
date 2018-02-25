From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 15/32] ASoC: rt5651: Only configure OVCD
	once at set_jack time
Date: Sun, 25 Feb 2018 11:46:56 +0100
Message-ID: <20180225104713.4745-16-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EBE7267408
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:39 +0100 (CET)
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

Only configure OVCD once at set_jack time, rather then configuring
it on every jack-insertion event and switch to using bit field defines
instead of hardcoding a magic value.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 2e23e126ff54..4f9f0f99c4b0 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1637,7 +1637,15 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
 		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
 
-	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
+	snd_soc_component_update_bits(component, RT5651_MICBIAS,
+				      RT5651_MIC1_OVCD_MASK |
+				      RT5651_MIC1_OVTH_MASK |
+				      RT5651_PWR_CLK12M_MASK |
+				      RT5651_PWR_MB_MASK,
+				      RT5651_MIC1_OVCD_DIS |
+				      RT5651_MIC1_OVTH_600UA |
+				      RT5651_PWR_MB_PU |
+				      RT5651_PWR_CLK12M_PU);
 
 	rt5651->hp_jack = hp_jack;
 
@@ -1825,14 +1833,8 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 	if (jack_insert) {
 		rt5651_enable_micbias1_for_ovcd(component);
 		snd_soc_component_update_bits(component, RT5651_MICBIAS,
-				    RT5651_MIC1_OVCD_MASK |
-				    RT5651_MIC1_OVTH_MASK |
-				    RT5651_PWR_CLK12M_MASK |
-				    RT5651_PWR_MB_MASK,
-				    RT5651_MIC1_OVCD_EN |
-				    RT5651_MIC1_OVTH_600UA |
-				    RT5651_PWR_MB_PU |
-				    RT5651_PWR_CLK12M_PU);
+				    RT5651_MIC1_OVCD_MASK,
+				    RT5651_MIC1_OVCD_EN);
 		msleep(100);
 		if (snd_soc_component_read32(component, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
 			jack_type = SND_JACK_HEADPHONE;
-- 
2.14.3
