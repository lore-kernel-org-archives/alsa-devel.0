From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/13] ASoC: Prepare SOC_SINGLE_XR_SX controls
	for regmap
Date: Tue, 18 Mar 2014 09:02:06 +0100
Message-ID: <1395129736-11938-4-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B998261AFC
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:41 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

SOC_SINGLE_XR_SX controls currently only work with CODECs that set the
'reg_word_size' field in their snd_soc_codec_driver struct. Going forward
support for ASoC level IO will eventually be removed and all drivers will be
converted to regmap. Preparing for the transition this patch adds support for
CODECs using regmap for IO to the SOC_SINGLE_XR_SX control. We already have the
val_bytes field in the CODEC struct which holds the number of bytes per word,
but it is only initialized when regmap is used. Also initialize it for drivers
still using legacy IO and update the SOC_SINGLE_XR_SX handlers to use it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b322cf29..0a39031 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3349,7 +3349,7 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->driver->reg_word_size * BITS_PER_BYTE;
+	unsigned int regwshift = codec->val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -3395,7 +3395,7 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int regbase = mc->regbase;
 	unsigned int regcount = mc->regcount;
-	unsigned int regwshift = codec->driver->reg_word_size * BITS_PER_BYTE;
+	unsigned int regwshift = codec->val_bytes * BITS_PER_BYTE;
 	unsigned int regwmask = (1<<regwshift)-1;
 	unsigned int invert = mc->invert;
 	unsigned long mask = (1UL<<mc->nbits)-1;
@@ -4298,6 +4298,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->num_dai = num_dai;
+	codec->val_bytes = codec_drv->reg_word_size;
 	mutex_init(&codec->mutex);
 
 	for (i = 0; i < num_dai; i++) {
-- 
1.8.0
