From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ttc-dkb: Remove unnecessary
	snd_soc_dapm_disable_pin() calls
Date: Fri,  9 Jan 2015 21:28:21 +0100
Message-ID: <1420835301-14469-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-098.synserver.de
 [212.40.185.98])
 by alsa0.perex.cz (Postfix) with ESMTP id E7D39260438
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 21:28:26 +0100 (CET)
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
Cc: Qiao Zhou <zhouqiao@marvell.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The "Headset Mic 2" and the "Headset Stereophone" widget are managed by the
jack detection logic. Their will be set depending on whether something is
connected to the jack or not. There is no need to manually change the state
beforehand as it will be overwritten anyway.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/ttc-dkb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index e3d7257a..5001dbb 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -76,10 +76,6 @@ static const struct snd_soc_dapm_route ttc_audio_map[] = {
 static int ttc_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_disable_pin(dapm, "Headset Mic 2");
-	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
 
 	/* Headset jack detection */
 	snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE
-- 
1.8.0
