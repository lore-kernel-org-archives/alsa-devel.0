From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 4/5] ASoC multi-component support : jack
Date: Thu, 24 Jun 2010 20:24:45 +0100
Message-ID: <1277407485.3100.583.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 01B521039A0
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 21:24:45 +0200 (CEST)
Received: by wyb38 with SMTP id 38so2318838wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 12:24:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Jack interface is per codec rather than per card in order to support sound
cards with more than one codec.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/soc-jack.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 29159e1..1dfc4fd 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -32,14 +32,14 @@
  * Returns zero if successful, or a negative error code on failure.
  * On success jack will be initialised.
  */
-int snd_soc_jack_new(struct snd_soc_card *card, const char *id, int type,
+int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 		     struct snd_soc_jack *jack)
 {
-	jack->card = card;
+	jack->codec = codec;
 	INIT_LIST_HEAD(&jack->pins);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	return snd_jack_new(card->codec->card, id, type, &jack->jack);
+	return snd_jack_new(codec->snd_card, id, type, &jack->jack);
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_new);
 
@@ -67,7 +67,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 	if (!jack)
 		return;
 
-	codec = jack->card->codec;
+	codec = jack->codec;
 
 	mutex_lock(&codec->mutex);
 
@@ -268,7 +268,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		ret = request_irq(gpio_to_irq(gpios[i].gpio),
 				gpio_handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				jack->card->dev->driver->name,
+				jack->codec->dev->driver->name,
 				&gpios[i]);
 		if (ret)
 			goto err;
-- 
1.7.0.4
