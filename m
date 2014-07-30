From: jianqun <xjq@rock-chips.com>
Subject: [PATCH] ASoC: max98090 add irq valid check
Date: Wed, 30 Jul 2014 16:54:17 +0800
Message-ID: <1406710457-6195-1-git-send-email-xjq@rock-chips.com>
References: <1406685010-25108-1-git-send-email-xjq@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406685010-25108-1-git-send-email-xjq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, tbleung@chromium.org, dgreid@chromium.org, kevin.strasser@intel.com, jarkko.nikula@linux.intel.com, swarren@nvidia.com, ralph.birt@maximintegrated.com
Cc: heiko@sntech.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jianqun <xjq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

From: Jianqun <xjq@rock-chips.com>

Since IRQ pin from max98090 may NC, the irq number will be zero, that is
invalid for request_threaded_irq, so just add irq valid check there.

Since hardware may not MUST to use IRQ pin of max98090 as jack detect, the
driver can work well without it, can report jack trigger to CPU by a GPIO.

But here driver will register fail caused by failed to request irq.

Signed-off-by: Jianqun <xjq@rock-chips.com>
---
 sound/soc/codecs/max98090.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 566919c..9dc0e8c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2478,12 +2478,14 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	/* Register for interrupts */
 	dev_dbg(codec->dev, "irq = %d\n", max98090->irq);
 
-	ret = request_threaded_irq(max98090->irq, NULL,
-		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-		"max98090_interrupt", codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "request_irq failed: %d\n",
-			ret);
+	if (max98090->irq) {
+		ret = request_threaded_irq(max98090->irq, NULL,
+			max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"max98090_interrupt", codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "request_irq failed: %d\n",
+				ret);
+		}
 	}
 
 	/*
-- 
1.7.9.5
