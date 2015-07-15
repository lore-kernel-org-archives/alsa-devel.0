From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Remove irq_jack_detection
	function" to the asoc tree
Date: Wed, 15 Jul 2015 12:55:45 +0100
Message-ID: <E1ZFLHt-0006f3-2w@debutante>
References: <1436856687-31550-3-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7447265AF5
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:55:51 +0200 (CEST)
In-Reply-To: <1436856687-31550-3-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Remove irq_jack_detection function

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f312bc59d21bed7593199a1921468868150954fa Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 14 Jul 2015 14:51:26 +0800
Subject: [PATCH] ASoC: rt5645: Remove irq_jack_detection function

irq_jack_detection is only called from rt5645_jack_detect_work:
remove the function to simplify the code.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 53 ++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9dfa431b337d..8693a25830d3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2874,7 +2874,18 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
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
@@ -2905,34 +2916,6 @@ static void rt5645_jack_detect_work(struct work_struct *work)
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
@@ -2947,7 +2930,7 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 				    report, SND_JACK_HEADPHONE);
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
-		return report;
+		return;
 	case 1: /* 2 port */
 		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0070;
 		break;
@@ -3029,8 +3012,16 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
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
2.1.4
