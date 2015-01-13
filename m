From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/29] ASoC: wm8990: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:24 +0100
Message-ID: <1421141255-21477-18-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A726261600
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:28:01 +0100 (CET)
In-Reply-To: <1421141255-21477-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8990.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 8a58422..c93bffc 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -374,13 +374,14 @@ SOC_SINGLE("RIN34 Mute Switch", WM8990_RIGHT_LINE_INPUT_3_4_VOLUME,
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	u32 reg_shift = kcontrol->private_value & 0xfff;
 	int ret = 0;
 	u16 reg;
 
 	switch (reg_shift) {
 	case WM8990_SPEAKER_MIXER | (WM8990_LDSPK_BIT << 8) :
-		reg = snd_soc_read(w->codec, WM8990_OUTPUT_MIXER1);
+		reg = snd_soc_read(codec, WM8990_OUTPUT_MIXER1);
 		if (reg & WM8990_LDLO) {
 			printk(KERN_WARNING
 			"Cannot set as Output Mixer 1 LDLO Set\n");
@@ -388,7 +389,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8990_SPEAKER_MIXER | (WM8990_RDSPK_BIT << 8):
-		reg = snd_soc_read(w->codec, WM8990_OUTPUT_MIXER2);
+		reg = snd_soc_read(codec, WM8990_OUTPUT_MIXER2);
 		if (reg & WM8990_RDRO) {
 			printk(KERN_WARNING
 			"Cannot set as Output Mixer 2 RDRO Set\n");
@@ -396,7 +397,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8990_OUTPUT_MIXER1 | (WM8990_LDLO_BIT << 8):
-		reg = snd_soc_read(w->codec, WM8990_SPEAKER_MIXER);
+		reg = snd_soc_read(codec, WM8990_SPEAKER_MIXER);
 		if (reg & WM8990_LDSPK) {
 			printk(KERN_WARNING
 			"Cannot set as Speaker Mixer LDSPK Set\n");
@@ -404,7 +405,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8990_OUTPUT_MIXER2 | (WM8990_RDRO_BIT << 8):
-		reg = snd_soc_read(w->codec, WM8990_SPEAKER_MIXER);
+		reg = snd_soc_read(codec, WM8990_SPEAKER_MIXER);
 		if (reg & WM8990_RDSPK) {
 			printk(KERN_WARNING
 			"Cannot set as Speaker Mixer RDSPK Set\n");
-- 
1.8.0
