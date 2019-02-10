From: Sergej Sawazki <sergej@taudac.com>
Subject: [PATCH v3] ASoC: wm8741: Add digital mute callback
Date: Sun, 10 Feb 2019 16:28:04 +0100
Message-ID: <1549812484-17449-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 0764526745B
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2019 16:28:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Sergej Sawazki <sergej@taudac.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
---
Changes in v3:
 * Removed debug message.
 
 sound/soc/codecs/wm8741.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 1fedf74..fdda83b 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -358,6 +358,15 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+int wm8741_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct snd_soc_component *component = codec_dai->component;
+
+	snd_soc_component_update_bits(component, WM8741_VOLUME_CONTROL,
+			WM8741_SOFT_MASK, !!mute << WM8741_SOFT_SHIFT);
+	return 0;
+}
+
 #define WM8741_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
@@ -371,6 +380,7 @@ static const struct snd_soc_dai_ops wm8741_dai_ops = {
 	.hw_params	= wm8741_hw_params,
 	.set_sysclk	= wm8741_set_dai_sysclk,
 	.set_fmt	= wm8741_set_dai_fmt,
+	.digital_mute   = wm8741_mute,
 };
 
 static struct snd_soc_dai_driver wm8741_dai = {
-- 
2.7.4
