From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ASoC: cs4271: switch to mute_stream
Date: Fri, 15 Mar 2013 06:35:47 +0100
Message-ID: <1363325748-6429-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 664E42616FC
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 06:36:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, subaparts@yandex.ru, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use the newly introduced mute_stream DAI operation, and don't mute the
codec if it's called for the _CAPTURE stream.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/cs4271.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index ac0d3b4..03036b3 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -388,7 +388,7 @@ static int cs4271_hw_params(struct snd_pcm_substream *substream,
 	return cs4271_set_deemph(codec);
 }
 
-static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
+static int cs4271_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
@@ -396,6 +396,9 @@ static int cs4271_digital_mute(struct snd_soc_dai *dai, int mute)
 	int val_a = 0;
 	int val_b = 0;
 
+	if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
 	if (mute) {
 		val_a = CS4271_VOLA_MUTE;
 		val_b = CS4271_VOLB_MUTE;
@@ -442,7 +445,7 @@ static const struct snd_soc_dai_ops cs4271_dai_ops = {
 	.hw_params	= cs4271_hw_params,
 	.set_sysclk	= cs4271_set_dai_sysclk,
 	.set_fmt	= cs4271_set_dai_fmt,
-	.digital_mute	= cs4271_digital_mute,
+	.mute_stream	= cs4271_mute_stream,
 };
 
 static struct snd_soc_dai_driver cs4271_dai = {
-- 
1.8.1.4
