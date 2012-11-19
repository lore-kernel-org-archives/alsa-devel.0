From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 3/4] ASoC: Jack: Standardise ASoC Jack messages
Date: Mon, 19 Nov 2012 14:39:14 +0000
Message-ID: <1353335955-5249-3-git-send-email-lrg@ti.com>
References: <1353335955-5249-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE4C265142
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 15:39:26 +0100 (CET)
In-Reply-To: <1353335955-5249-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC has a mixture of message prefixes e.g. "ASoC", "asoc"
or none and message types e.g. pr_debug or dev_dbg.

Make sure all ASoC core messages use the same "ASoC" prefix and
convert any component device specific messages to use dev_dbg
instead of pr_debug.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-jack.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index e41e14c..0bb5ccc 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -169,12 +169,13 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 
 	for (i = 0; i < count; i++) {
 		if (!pins[i].pin) {
-			printk(KERN_ERR "No name for pin %d\n", i);
+			dev_err(jack->codec->dev, "ASoC: No name for pin %d\n",
+				i);
 			return -EINVAL;
 		}
 		if (!pins[i].mask) {
-			printk(KERN_ERR "No mask for pin %d (%s)\n", i,
-			       pins[i].pin);
+			dev_err(jack->codec->dev, "ASoC: No mask for pin %d"
+				" (%s)\n", i, pins[i].pin);
 			return -EINVAL;
 		}
 
@@ -294,13 +295,13 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 	for (i = 0; i < count; i++) {
 		if (!gpio_is_valid(gpios[i].gpio)) {
-			printk(KERN_ERR "Invalid gpio %d\n",
+			dev_err(jack->codec->dev, "ASoC: Invalid gpio %d\n",
 				gpios[i].gpio);
 			ret = -EINVAL;
 			goto undo;
 		}
 		if (!gpios[i].name) {
-			printk(KERN_ERR "No name for gpio %d\n",
+			dev_err(jack->codec->dev, "ASoC: No name for gpio %d\n",
 				gpios[i].gpio);
 			ret = -EINVAL;
 			goto undo;
@@ -329,7 +330,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		if (gpios[i].wake) {
 			ret = irq_set_irq_wake(gpio_to_irq(gpios[i].gpio), 1);
 			if (ret != 0)
-				printk(KERN_ERR
+				dev_err(jack->codec->dev, "ASoC: "
 				  "Failed to mark GPIO %d as wake source: %d\n",
 					gpios[i].gpio, ret);
 		}
-- 
1.7.10.4
