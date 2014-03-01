From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: pxa: mioa701_wm9713: Convert to
	table based DAPM setup
Date: Sat,  1 Mar 2014 15:48:18 +0100
Message-ID: <1393685300-5307-6-git-send-email-lars@metafoo.de>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-192.synserver.de
 [212.40.185.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F25C26534C
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:47:57 +0100 (CET)
In-Reply-To: <1393685300-5307-1-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes. This on one hand
makes the code a bit cleaner and on the other hand the board level DAPM elements
get registered in the card's DAPM context rather than in the CODEC's DAPM
context.

Also remove the snd_soc_dapm_enable_pin() calls, since pins are enabled by
default and there are no matching snd_soc_dapm_disable_pin() calls.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/mioa701_wm9713.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 160c524..595eee3 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -127,16 +127,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	unsigned short reg;
 
-	/* Add mioa701 specific widgets */
-	snd_soc_dapm_new_controls(dapm, mioa701_dapm_widgets,
-				  ARRAY_SIZE(mioa701_dapm_widgets));
-
-	/* Set up mioa701 specific audio path audio_mapnects */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	/* Prepare GPIO8 for rear speaker amplifier */
 	reg = codec->driver->read(codec, AC97_GPIO_CFG);
 	codec->driver->write(codec, AC97_GPIO_CFG, reg | 0x0100);
@@ -145,12 +137,6 @@ static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 	reg = codec->driver->read(codec, AC97_3D_CONTROL);
 	codec->driver->write(codec, AC97_3D_CONTROL, reg | 0xc000);
 
-	snd_soc_dapm_enable_pin(dapm, "Front Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Rear Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Front Mic");
-	snd_soc_dapm_enable_pin(dapm, "GSM Line In");
-	snd_soc_dapm_enable_pin(dapm, "GSM Line Out");
-
 	return 0;
 }
 
@@ -183,6 +169,11 @@ static struct snd_soc_card mioa701 = {
 	.owner = THIS_MODULE,
 	.dai_link = mioa701_dai,
 	.num_links = ARRAY_SIZE(mioa701_dai),
+
+	.dapm_widgets = mioa701_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mioa701_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static int mioa701_wm9713_probe(struct platform_device *pdev)
-- 
1.8.0
