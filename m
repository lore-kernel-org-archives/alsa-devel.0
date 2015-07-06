From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: cht_bsw_max98090_ti: Use card DAPM
	context to access widgets
Date: Mon,  6 Jul 2015 15:38:09 +0200
Message-ID: <1436189891-15343-4-git-send-email-lars@metafoo.de>
References: <1436189891-15343-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-092.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 73D8A26067D
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 15:38:22 +0200 (CEST)
In-Reply-To: <1436189891-15343-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Yang A Fang <yang.a.fang@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Kevin Cernekee <cernekee@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

While we are at it also remove some extra newlines.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index d604ee8..afcd6ba 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -104,21 +104,17 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 static int cht_ti_jack_event(struct notifier_block *nb,
 		unsigned long event, void *data)
 {
-
 	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
-	struct snd_soc_dai *codec_dai = jack->card->rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
 
 	if (event & SND_JACK_MICROPHONE) {
-
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "SHDN");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "MICBIAS");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "SHDN");
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_sync(dapm);
 	} else {
-
-		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
-		snd_soc_dapm_disable_pin(&codec->dapm, "SHDN");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_disable_pin(dapm, "SHDN");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return 0;
-- 
2.1.4
