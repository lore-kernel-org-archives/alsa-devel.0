From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 2/3] ASoC: rt5645: Remove irq_jack_detection
	function
Date: Tue, 14 Jul 2015 14:51:26 +0800
Message-ID: <1436856687-31550-3-git-send-email-drinkcat@chromium.org>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC102650F2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 08:52:09 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so629375pdj.3
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 23:52:08 -0700 (PDT)
In-Reply-To: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

irq_jack_detection is only called from rt5645_jack_detect_work:
remove the function to simplify the code.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 53 ++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 45651f4..ef6d3ad 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2877,7 +2877,18 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	return rt5645->jack_type;
 }
 
-static int rt5645_irq_detection(struct rt5645_priv *rt5645);
+static int rt5645_button_detect(struct snd_soc_codec *codec)
+{
+	int btn_type, val;
+
+	val = snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
+	pr_debug("val=0x%x\n", val);
+	btn_type = val & 0xfff0;
+	snd_soc_write(codec, RT5650_4BTN_IL_CMD1, val);
+
+	return btn_type;
+}
+
 static irqreturn_t rt5645_irq(int irq, void *data);
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
@@ -2908,34 +2919,6 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 {
 	struct rt5645_priv *rt5645 =
 		container_of(work, struct rt5645_priv, jack_detect_work.work);
-
-	rt5645_irq_detection(rt5645);
-}
-
-static irqreturn_t rt5645_irq(int irq, void *data)
-{
-	struct rt5645_priv *rt5645 = data;
-
-	queue_delayed_work(system_power_efficient_wq,
-			   &rt5645->jack_detect_work, msecs_to_jiffies(250));
-
-	return IRQ_HANDLED;
-}
-
-static int rt5645_button_detect(struct snd_soc_codec *codec)
-{
-	int btn_type, val;
-
-	val = snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
-	pr_debug("val=0x%x\n", val);
-	btn_type = val & 0xfff0;
-	snd_soc_write(codec, RT5650_4BTN_IL_CMD1, val);
-
-	return btn_type;
-}
-
-static int rt5645_irq_detection(struct rt5645_priv *rt5645)
-{
 	int val, btn_type, gpio_state = 0, report = 0;
 
 	switch (rt5645->pdata.jd_mode) {
@@ -2950,7 +2933,7 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 				    report, SND_JACK_HEADPHONE);
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
-		return report;
+		return;
 	case 1: /* 2 port */
 		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0070;
 		break;
@@ -3032,8 +3015,16 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 		snd_soc_jack_report(rt5645->btn_jack,
 			report, SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3);
+}
 
-	return report;
+static irqreturn_t rt5645_irq(int irq, void *data)
+{
+	struct rt5645_priv *rt5645 = data;
+
+	queue_delayed_work(system_power_efficient_wq,
+			   &rt5645->jack_detect_work, msecs_to_jiffies(250));
+
+	return IRQ_HANDLED;
 }
 
 static int rt5645_probe(struct snd_soc_codec *codec)
-- 
2.4.3.573.g4eafbef
