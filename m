From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: smdk_wm8580: Pass card DAPM context
	to snd_soc_dapm_disable_pin()
Date: Fri, 16 Jan 2015 14:34:53 +0100
Message-ID: <1421415293-29589-2-git-send-email-lars@metafoo.de>
References: <1421415293-29589-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-006.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id 13AA426051D
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 14:34:59 +0100 (CET)
In-Reply-To: <1421415293-29589-1-git-send-email-lars@metafoo.de>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The "MicIn" widget is a card level DAPM element so pass the card's DAPM
context instead of the CODEC's DAPM context to snd_soc_dapm_disable_pin().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/smdk_wm8580.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 17a2f71..548bfd9 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -136,13 +136,10 @@ static const struct snd_soc_dapm_route smdk_wm8580_audio_map[] = {
 
 static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
 	/* Enabling the microphone requires the fitting of a 0R
 	 * resistor to connect the line from the microphone jack.
 	 */
-	snd_soc_dapm_disable_pin(dapm, "MicIn");
+	snd_soc_dapm_disable_pin(&rtd->card->dapm, "MicIn");
 
 	return 0;
 }
-- 
1.8.0
