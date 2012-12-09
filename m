From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Check jack is inserted when
	handling mic IRQ
Date: Sun,  9 Dec 2012 12:31:08 +0900
Message-ID: <1355023870-32040-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A014261657
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 04:31:19 +0100 (CET)
In-Reply-To: <1355023870-32040-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we've got jack detection support then check that the jack is still
inserted when handling a mic IRQ in order to avoid transient reports
caused by shorts during the removal process as the two interrupts race
with each other.

Change-Id: Ie4d032b0d37b14997b0431328ab46923fe2cdca0
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b2dfcbb..76f2320 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3730,7 +3730,7 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
 	struct snd_soc_codec *codec = wm8994->codec;
-	int reg, count;
+	int reg, count, ret;
 
 	/*
 	 * Jack detection may have detected a removal simulataneously
@@ -3771,6 +3771,18 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	trace_snd_soc_jack_irq(dev_name(codec->dev));
 #endif
 
+	/* Avoid a transient report when the accessory is being removed */
+	if (wm8994->jackdet) {
+		ret = snd_soc_read(codec, WM1811_JACKDET_CTRL);
+		if (ret < 0) {
+			dev_err(codec->dev, "Failed to read jack status: %d\n",
+				ret);
+		} else if (!(ret & WM1811_JACKDET_LVL)) {
+			dev_dbg(codec->dev, "Ignoring removed jack\n");
+			return IRQ_HANDLED;
+		}
+	}
+
 	if (wm8994->mic_detecting)
 		wm8958_mic_id(codec, reg);
 	else
-- 
1.7.10.4
