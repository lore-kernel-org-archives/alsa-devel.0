From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm1133-ev1: Use card DAPM context to
	access widgets
Date: Sat, 11 Apr 2015 12:52:01 +0200
Message-ID: <1428749521-7426-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 296C4260867
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 12:52:03 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/wm1133-ev1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/wm1133-ev1.c b/sound/soc/fsl/wm1133-ev1.c
index 0653aa8..b454972 100644
--- a/sound/soc/fsl/wm1133-ev1.c
+++ b/sound/soc/fsl/wm1133-ev1.c
@@ -202,7 +202,6 @@ static struct snd_soc_jack_pin mic_jack_pins[] = {
 static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
 	/* Headphone jack detection */
 	snd_soc_card_jack_new(rtd->card, "Headphone", SND_JACK_HEADPHONE,
@@ -216,7 +215,7 @@ static int wm1133_ev1_init(struct snd_soc_pcm_runtime *rtd)
 	wm8350_mic_jack_detect(codec, &mic_jack, SND_JACK_MICROPHONE,
 			       SND_JACK_BTN_0);
 
-	snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
+	snd_soc_dapm_force_enable_pin(&rtd->card->dapm, "Mic Bias");
 
 	return 0;
 }
-- 
1.8.0
