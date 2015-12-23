From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Enable mic level detection
	reporting to user-space" to the asoc tree
Date: Wed, 23 Dec 2015 00:09:00 +0000
Message-ID: <E1aBWzE-0007MM-CL@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF609265DDF
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:06 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Enable mic level detection reporting to user-space

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

>From e05c25a1af29d65260ed1458f2cc4a959030ebd2 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 3 Dec 2015 17:10:07 +0000
Subject: [PATCH] ASoC: da7218: Enable mic level detection reporting to
 user-space

This patch adds support to the codec driver to handle mic level
detect related IRQs, and report these to user-space using a uevent
variable.

The uevent variable string "EVENT=MIC_LEVEL_DETECT" is sent to
user-space, if the mic level detect feature is enabled, and the
audio captured at the chosen mic(s) is above a certain threshold.
User-space can then handle the event accordingly (e.g. process
audio capture stream).

This method was chosen over ALSA control notification for a couple
of reasons:

 1) There's no requirement here for a control to read state from.
    The event is the only thing that's required and of interest.
 2) tinyalsa support for control notifications does not exist so on
    platforms using this over alsa-lib there is a need to add code
    to support this event handling.

Another possible option would be to use the standard Jack reporting
framework but this really does not fit for this kind of event.

Finally, use of the input device framework is not being encouraged,
due to difficulties in enabling apps to access input devices, so
this has also been avoided.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index eacde128c4d6..72686517ff54 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2202,6 +2202,16 @@ int da7218_hpldet(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(da7218_hpldet);
 
+static void da7218_micldet_irq(struct snd_soc_codec *codec)
+{
+	char *envp[] = {
+		"EVENT=MIC_LEVEL_DETECT",
+		NULL,
+	};
+
+	kobject_uevent_env(&codec->dev->kobj, KOBJ_CHANGE, envp);
+}
+
 static void da7218_hpldet_irq(struct snd_soc_codec *codec)
 {
 	struct da7218_priv *da7218 = snd_soc_codec_get_drvdata(codec);
@@ -2232,6 +2242,10 @@ static irqreturn_t da7218_irq_thread(int irq, void *data)
 	if (!status)
 		return IRQ_NONE;
 
+	/* Mic level detect */
+	if (status & DA7218_LVL_DET_EVENT_MASK)
+		da7218_micldet_irq(codec);
+
 	/* HP detect */
 	if (status & DA7218_HPLDET_JACK_EVENT_MASK)
 		da7218_hpldet_irq(codec);
@@ -2936,11 +2950,6 @@ static int da7218_probe(struct snd_soc_codec *codec)
 	}
 
 	if (da7218->irq) {
-		/* Mask off mic level events, currently not handled */
-		snd_soc_update_bits(codec, DA7218_EVENT_MASK,
-				    DA7218_LVL_DET_EVENT_MSK_MASK,
-				    DA7218_LVL_DET_EVENT_MSK_MASK);
-
 		ret = devm_request_threaded_irq(codec->dev, da7218->irq, NULL,
 						da7218_irq_thread,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-- 
2.6.2
