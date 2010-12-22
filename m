From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Trace Wolfson jack detection IRQs
Date: Wed, 22 Dec 2010 00:09:19 +0000
Message-ID: <1292976559-11466-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1292976559-11466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2BCE103B13
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 01:09:14 +0100 (CET)
In-Reply-To: <1292976559-11466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Add jack detection interrupt trace to Wolfson CODEC drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |    5 +++++
 sound/soc/codecs/wm8903.c |    4 ++++
 sound/soc/codecs/wm8962.c |    3 +++
 sound/soc/codecs/wm8994.c |    5 +++++
 4 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 3e0362e..82d877d 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -26,6 +26,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <trace/events/asoc.h>
 
 #include "wm8350.h"
 
@@ -1378,10 +1379,12 @@ static irqreturn_t wm8350_hp_jack_handler(int irq, void *data)
 
 	switch (irq - wm8350->irq_base) {
 	case WM8350_IRQ_CODEC_JCK_DET_L:
+		trace_snd_soc_jack_irq("WM8350 HPL");
 		jack = &priv->hpl;
 		break;
 
 	case WM8350_IRQ_CODEC_JCK_DET_R:
+		trace_snd_soc_jack_irq("WM8350 HPR");
 		jack = &priv->hpr;
 		break;
 
@@ -1456,6 +1459,8 @@ static irqreturn_t wm8350_mic_handler(int irq, void *data)
 	u16 reg;
 	int report = 0;
 
+	trace_snd_soc_jack_irq("WM8350 mic");
+
 	reg = wm8350_reg_read(wm8350, WM8350_JACK_PIN_STATUS);
 	if (reg & WM8350_JACK_MICSCD_LVL)
 		report |= priv->mic.short_report;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index d015745..b32699b 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -31,6 +31,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/wm8903.h>
+#include <trace/events/asoc.h>
 
 #include "wm8903.h"
 
@@ -1533,6 +1534,9 @@ static irqreturn_t wm8903_irq(int irq, void *data)
 	mic_report = wm8903->mic_last_report;
 	int_pol = snd_soc_read(codec, WM8903_INTERRUPT_POLARITY_1);
 
+	if (int_val & (WM8903_MICSHRT_EINT | WM8903_MICDET_EINT))
+		trace_snd_soc_jack_irq(dev_name(codec->dev));
+
 	if (int_val & WM8903_MICSHRT_EINT) {
 		dev_dbg(codec->dev, "Microphone short (pol=%x)\n", int_pol);
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f0c9d26..a24f83d 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -32,6 +32,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/wm8962.h>
+#include <trace/events/asoc.h>
 
 #include "wm8962.h"
 
@@ -3353,6 +3354,8 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	if (active & (WM8962_MICSCD_EINT | WM8962_MICD_EINT)) {
 		dev_dbg(codec->dev, "Microphone event detected\n");
 
+		trace_snd_soc_jack_irq(dev_name(codec->dev));
+
 		pm_wakeup_event(codec->dev, 300);
 
 		schedule_delayed_work(&wm8962->mic_work,
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e1a775b..067a532 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -28,6 +28,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
+#include <trace/events/asoc.h>
 
 #include <linux/mfd/wm8994/core.h>
 #include <linux/mfd/wm8994/registers.h>
@@ -2755,6 +2756,8 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 	int reg;
 	int report;
 
+	trace_snd_soc_jack_irq(dev_name(codec->dev));
+
 	reg = snd_soc_read(codec, WM8994_INTERRUPT_RAW_STATUS_2);
 	if (reg < 0) {
 		dev_err(codec->dev, "Failed to read microphone status: %d\n",
@@ -2901,6 +2904,8 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 		goto out;
 	}
 
+	trace_snd_soc_jack_irq(dev_name(codec->dev));
+
 	if (wm8994->jack_cb)
 		wm8994->jack_cb(reg, wm8994->jack_cb_data);
 	else
-- 
1.7.2.3
