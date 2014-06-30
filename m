From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: s6105-ipcam: Automatically
	disconnect non-connected pins
Date: Mon, 30 Jun 2014 10:01:39 +0200
Message-ID: <1404115299-24109-3-git-send-email-lars@metafoo.de>
References: <1404115299-24109-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-252.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id B5C4126552C
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 10:03:09 +0200 (CEST)
In-Reply-To: <1404115299-24109-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>
List-Id: alsa-devel@alsa-project.org

All CODEC input and output widgets are either in the DAPM routing table or
manually marked as non-connected. This means the card is fully routed and we can
let the core take care of disconnecting non-connected pins.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/s6000/s6105-ipcam.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index 50875e6..3510c01 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -133,22 +133,8 @@ static const struct snd_kcontrol_new audio_out_mux = {
 /* Logic for a aic3x as connected on the s6105 ip camera ref design */
 static int s6105_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_card *card = rtd->card;
 
-	/* not present */
-	snd_soc_dapm_nc_pin(dapm, "MONO_LOUT");
-	snd_soc_dapm_nc_pin(dapm, "LINE2L");
-	snd_soc_dapm_nc_pin(dapm, "LINE2R");
-
-	/* not connected */
-	snd_soc_dapm_nc_pin(dapm, "MIC3L"); /* LINE2L on this chip */
-	snd_soc_dapm_nc_pin(dapm, "MIC3R"); /* LINE2R on this chip */
-	snd_soc_dapm_nc_pin(dapm, "LLOUT");
-	snd_soc_dapm_nc_pin(dapm, "RLOUT");
-	snd_soc_dapm_nc_pin(dapm, "HPRCOM");
-
 	/* must correspond to audio_out_mux.private_value initializer */
 	snd_soc_dapm_disable_pin(&card->dapm, "Audio Out Differential");
 
@@ -180,6 +166,7 @@ static struct snd_soc_card snd_soc_card_s6105 = {
 	.num_dapm_widgets = ARRAY_SIZE(aic3x_dapm_widgets),
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
 };
 
 static struct s6000_snd_platform_data s6105_snd_data __initdata = {
-- 
1.8.0
