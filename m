From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 07/22] ASoC: rt5651: Enable Platform Clock
	during jack-type detect
Date: Sun,  4 Mar 2018 15:35:55 +0100
Message-ID: <20180304143610.21125-8-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A4D742673A6
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:23 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
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

When using RCCLK instead of MCLK / PLL1 the OVCD status often gets stuck
at its last value, which breaks jack-type detection.

This commit fixes this by force-enabling the platform clock when doing
jack-type detection.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 3a439c121b0c..9f522a0364f4 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1563,6 +1563,8 @@ static void rt5651_enable_micbias1_for_ovcd(struct snd_soc_component *component)
 	snd_soc_dapm_mutex_lock(dapm);
 	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
 	snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
+	/* OVCD is unreliable when used with RCCLK as sysclk-source */
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "Platform Clock");
 	snd_soc_dapm_sync_unlocked(dapm);
 	snd_soc_dapm_mutex_unlock(dapm);
 }
@@ -1572,6 +1574,7 @@ static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "Platform Clock");
 	snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
 	snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
 	snd_soc_dapm_sync_unlocked(dapm);
-- 
2.14.3
