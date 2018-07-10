From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Allow disabling jack-detect by
	calling set_jack(NULL)" to the asoc tree
Date: Tue, 10 Jul 2018 19:16:36 +0100
Message-ID: <E1fcxBk-0001iP-Kh@debutante>
References: <20180704225935.7902-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CF22267716
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 20:16:42 +0200 (CEST)
In-Reply-To: <20180704225935.7902-2-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Allow disabling jack-detect by calling set_jack(NULL)

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 34c906ddacd237511808fb2bbd941e6b91e9095a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 5 Jul 2018 00:59:32 +0200
Subject: [PATCH] ASoC: rt5651: Allow disabling jack-detect by calling
 set_jack(NULL)

Allow the machine driver to disable jack-detect over a suspend/resume by
calling snd_soc_component_set_jack(NULL).

Note this renames rt5651_set_jack, where all the jack-enable work was done
to rt5651_enable_jack_detect. This function can now no longer fail as it
does not request the IRQ anymore. It can still be passed an invalid jack
source, but that should never happen, so this is now logged and treated as
no jack source.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 55 +++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 39d2c67cd064..40bd1e70fee7 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1703,14 +1703,10 @@ static void rt5651_cancel_work(void *data)
 	cancel_work_sync(&rt5651->jack_detect_work);
 }
 
-static int rt5651_set_jack(struct snd_soc_component *component,
-			   struct snd_soc_jack *hp_jack, void *data)
+static void rt5651_enable_jack_detect(struct snd_soc_component *component,
+				      struct snd_soc_jack *hp_jack)
 {
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	if (!rt5651->irq)
-		return -EINVAL;
 
 	/* IRQ output on GPIO1 */
 	snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
@@ -1737,10 +1733,10 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 			RT5651_JD2_IRQ_EN, RT5651_JD2_IRQ_EN);
 		break;
 	case RT5651_JD_NULL:
-		return 0;
+		return;
 	default:
 		dev_err(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
-		return -EINVAL;
+		return;
 	}
 
 	/* Enable jack detect power */
@@ -1774,19 +1770,28 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 		RT5651_MB1_OC_STKY_MASK, RT5651_MB1_OC_STKY_EN);
 
 	rt5651->hp_jack = hp_jack;
-
-	ret = devm_request_threaded_irq(component->dev, rt5651->irq, NULL,
-					rt5651_irq,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING |
-					IRQF_ONESHOT, "rt5651", rt5651);
-	if (ret) {
-		dev_err(component->dev, "Failed to reguest IRQ: %d\n", ret);
-		return ret;
-	}
-
+	enable_irq(rt5651->irq);
 	/* sync initial jack state */
 	queue_work(system_power_efficient_wq, &rt5651->jack_detect_work);
+}
+
+static void rt5651_disable_jack_detect(struct snd_soc_component *component)
+{
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+
+	disable_irq(rt5651->irq);
+	rt5651_cancel_work(rt5651);
+
+	rt5651->hp_jack = NULL;
+}
+
+static int rt5651_set_jack(struct snd_soc_component *component,
+			   struct snd_soc_jack *jack, void *data)
+{
+	if (jack)
+		rt5651_enable_jack_detect(component, jack);
+	else
+		rt5651_disable_jack_detect(component);
 
 	return 0;
 }
@@ -2048,6 +2053,18 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
+	ret = devm_request_irq(&i2c->dev, rt5651->irq, rt5651_irq,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+			       | IRQF_ONESHOT, "rt5651", rt5651);
+	if (ret == 0) {
+		/* Gets re-enabled by rt5651_set_jack() */
+		disable_irq(rt5651->irq);
+	} else {
+		dev_warn(&i2c->dev, "Failed to reguest IRQ %d: %d\n",
+			 rt5651->irq, ret);
+		rt5651->irq = -ENXIO;
+	}
+
 	ret = devm_snd_soc_register_component(&i2c->dev,
 				&soc_component_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
-- 
2.18.0.rc2
