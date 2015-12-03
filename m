From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7218: Enable mic level detection
 reporting to user-space
Date: Thu, 3 Dec 2015 10:45:50 +0000
Message-ID: <d6102f65136a8457d7ca19a51be4a938f3146613.1449059324.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 47EB72652E2
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 11:45:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch adds support to the codec driver to handle mic level
detect related IRQs, and report these to user-space using a uevent
variable.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7218.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 4fee7ae..752ed04 100644
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
1.9.3
