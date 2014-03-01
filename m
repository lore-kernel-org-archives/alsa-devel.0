From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] ASoC: pxa: zylonite: Convert to table
	based DAPM setup
Date: Sat,  1 Mar 2014 15:48:20 +0100
Message-ID: <1393685300-5307-8-git-send-email-lars@metafoo.de>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-192.synserver.de
 [212.40.185.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CAD92654AE
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:47:59 +0100 (CET)
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

Also drop the two snd_soc_dapm_enable_pin() since pins are enabled by default
and there is no matching snd_soc_dapm_disable_pin() in the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/zylonite.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index db8aadf..23bf991 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -71,22 +71,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int zylonite_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
 	if (clk_pout)
 		snd_soc_dai_set_pll(rtd->codec_dai, 0, 0,
 				    clk_get_rate(pout), 0);
 
-	snd_soc_dapm_new_controls(dapm, zylonite_dapm_widgets,
-				  ARRAY_SIZE(zylonite_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	/* Static setup for now */
-	snd_soc_dapm_enable_pin(dapm, "Headphone");
-	snd_soc_dapm_enable_pin(dapm, "Headset Earpiece");
-
 	return 0;
 }
 
@@ -256,6 +244,11 @@ static struct snd_soc_card zylonite = {
 	.resume_pre = &zylonite_resume_pre,
 	.dai_link = zylonite_dai,
 	.num_links = ARRAY_SIZE(zylonite_dai),
+
+	.dapm_widgets = zylonite_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(zylonite_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *zylonite_snd_ac97_device;
-- 
1.8.0
