From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: Fix cht_bsw_nau8824 machine
	driver build error
Date: Fri,  2 Mar 2018 11:22:58 +0100
Message-ID: <20180302102258.10081-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 424EB267261
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:23:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

The cht_bsw_nau8824 machine driver is passing snd_soc_codec to
nau8824_enable_jack_detect(), but that expects a snd_soc_component
as argument, causing a compile error.

This commit fixes this.

Fixes: 5b00ce63e07f ("ASoC: Intel: add nau8824 sound card")
Cc: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 08d0b8128fab..5913ad159cc1 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -103,7 +103,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 	struct snd_soc_jack *jack = &ctx->jack;
-	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	int ret, jack_type;
 
@@ -134,7 +133,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	nau8824_enable_jack_detect(codec, jack);
+	nau8824_enable_jack_detect(codec_dai->component, jack);
 
 	return ret;
 }
-- 
2.14.3
