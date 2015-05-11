From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] ASoC: uda134x: Replace direct
	snd_soc_codec dapm field access
Date: Mon, 11 May 2015 09:42:33 +0200
Message-ID: <1431330156-16706-8-git-send-email-lars@metafoo.de>
References: <1431330156-16706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-107.synserver.de (smtp-out-107.synserver.de
 [212.40.185.107])
 by alsa0.perex.cz (Postfix) with ESMTP id C94FA2606E4
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 09:42:47 +0200 (CEST)
In-Reply-To: <1431330156-16706-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda134x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index dbecbc0..913edf2 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -477,6 +477,7 @@ static struct snd_soc_dai_driver uda134x_dai = {
 
 static int uda134x_soc_probe(struct snd_soc_codec *codec)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct uda134x_priv *uda134x;
 	struct uda134x_platform_data *pd = codec->component.card->dev->platform_data;
 	const struct snd_soc_dapm_widget *widgets;
@@ -525,7 +526,7 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 		num_widgets = ARRAY_SIZE(uda1340_dapm_widgets);
 	}
 
-	ret = snd_soc_dapm_new_controls(&codec->dapm, widgets, num_widgets);
+	ret = snd_soc_dapm_new_controls(dapm, widgets, num_widgets);
 	if (ret) {
 		printk(KERN_ERR "%s failed to register dapm controls: %d",
 			__func__, ret);
-- 
1.8.0
