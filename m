From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 30/47] ASoC: wm8961: Replace direct
	snd_soc_codec dapm field access
Date: Mon,  1 Jun 2015 10:10:49 +0200
Message-ID: <1433146266-1599-30-git-send-email-lars@metafoo.de>
References: <1433146266-1599-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-058.synserver.de
 [212.40.185.58])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F046261740
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 10:11:26 +0200 (CEST)
In-Reply-To: <1433146266-1599-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8961.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 6f95d70..a057662 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -758,7 +758,7 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			/* Enable bias generation */
 			reg = snd_soc_read(codec, WM8961_ANTI_POP);
 			reg |= WM8961_BUFIOEN | WM8961_BUFDCOPEN;
@@ -773,7 +773,7 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_PREPARE) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE) {
 			/* VREF off */
 			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VREF;
-- 
2.1.4
