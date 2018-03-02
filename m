From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: Intel: fix argument error in nau8824
	machine
Date: Fri, 2 Mar 2018 10:45:14 +0800
Message-ID: <1519958714-30352-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A33826733D
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 03:45:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, John Hsu <KCHSU0@nuvoton.com>, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Fix the error: passing argument 1 of 'nau8824_enable_jack_detect'
from incompatible pointer type
  nau8824_enable_jack_detect(codec, jack);
                             ^~~~~
Which expects 'struct snd_soc_component *' but argument is of type
'struct snd_soc_codec *'

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 08d0b81..680f2b3 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -103,8 +103,8 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 	struct snd_soc_jack *jack = &ctx->jack;
-	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
+	struct snd_soc_component *component = codec_dai->component;
 	int ret, jack_type;
 
 	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
@@ -134,7 +134,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	nau8824_enable_jack_detect(codec, jack);
+	nau8824_enable_jack_detect(component, jack);
 
 	return ret;
 }
-- 
2.6.4
