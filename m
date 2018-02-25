From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 23/32] ASoC: Intel: bytcr_rt5651: Only
	create jack if we have a jack-detect source
Date: Sun, 25 Feb 2018 11:47:04 +0100
Message-ID: <20180225104713.4745-24-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 683DE267441
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:50 +0100 (CET)
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

Only create the jack if we have a valid jack-detect source and properly
check the snd_soc_component_set_jack() return value.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 1cae89e0b843..4a9026a55ce9 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -388,17 +388,21 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 
 	rt5651_apply_properties(codec);
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset",
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
+		ret = snd_soc_card_jack_new(runtime->card, "Headset",
 				    SND_JACK_HEADSET, &priv->jack,
 				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
-	if (ret) {
-		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
-		return ret;
-	}
+		if (ret) {
+			dev_err(runtime->dev, "jack creation failed %d\n", ret);
+			return ret;
+		}
 
-	snd_soc_component_set_jack(codec, &priv->jack, NULL);
+		ret = snd_soc_component_set_jack(codec, &priv->jack, NULL);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static const struct snd_soc_pcm_stream byt_rt5651_dai_params = {
-- 
2.14.3
