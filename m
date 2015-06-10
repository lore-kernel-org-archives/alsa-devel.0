From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ASoC: rt5645: Lock mutex in
	rt5645_enable_push_button_irq
Date: Wed, 10 Jun 2015 11:54:13 +0800
Message-ID: <1433908453-9548-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E7617265846
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 05:54:20 +0200 (CEST)
Received: by pdbnf5 with SMTP id nf5so28270130pdb.2
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 20:54:19 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

rt5645_enable_push_button_irq uses snd_soc_dapm_*_unlocked
functions, so it needs to lock the required dapm mutex.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d5f0f56..025cf14 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2761,6 +2761,7 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
+		snd_soc_dapm_mutex_lock(&codec->dapm);
 		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
 							"ADC L power");
 		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
@@ -2770,6 +2771,8 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
 							"Mic Det Power");
 		snd_soc_dapm_sync_unlocked(&codec->dapm);
+		snd_soc_dapm_mutex_unlock(&codec->dapm);
+
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
 		snd_soc_update_bits(codec,
@@ -2780,6 +2783,8 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	} else {
 		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
 		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
+
+		snd_soc_dapm_mutex_lock(&codec->dapm);
 		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
 							"ADC L power");
 		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
@@ -2790,6 +2795,7 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
 							"Mic Det Power");
 		snd_soc_dapm_sync_unlocked(&codec->dapm);
+		snd_soc_dapm_mutex_unlock(&codec->dapm);
 	}
 }
 
-- 
2.2.0.rc0.207.ga3a616c
