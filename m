From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: pcm512x: Replace direct
	snd_soc_codec dapm field access
Date: Fri, 15 May 2015 12:32:55 +0200
Message-ID: <1431685980-6600-3-git-send-email-lars@metafoo.de>
References: <1431685980-6600-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D33726606B
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:33:05 +0200 (CEST)
In-Reply-To: <1431685980-6600-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/pcm512x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index c305b28..de16429 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -242,7 +242,7 @@ static int pcm512x_overclock_pll_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
 
-	switch (codec->dapm.bias_level) {
+	switch (snd_soc_codec_get_bias_level(codec)) {
 	case SND_SOC_BIAS_OFF:
 	case SND_SOC_BIAS_STANDBY:
 		break;
@@ -270,7 +270,7 @@ static int pcm512x_overclock_dsp_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
 
-	switch (codec->dapm.bias_level) {
+	switch (snd_soc_codec_get_bias_level(codec)) {
 	case SND_SOC_BIAS_OFF:
 	case SND_SOC_BIAS_STANDBY:
 		break;
@@ -298,7 +298,7 @@ static int pcm512x_overclock_dac_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
 
-	switch (codec->dapm.bias_level) {
+	switch (snd_soc_codec_get_bias_level(codec)) {
 	case SND_SOC_BIAS_OFF:
 	case SND_SOC_BIAS_STANDBY:
 		break;
-- 
1.8.0
