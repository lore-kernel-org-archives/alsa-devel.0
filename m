From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v8 4/7] ASoC: simple-amplifier: make
	enable-gpio optional
Date: Tue, 20 Nov 2018 21:17:49 -0800
Message-ID: <20181121051752.18387-5-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id BFC8E267936
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 06:19:15 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id b5so3725360plr.4
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:19:15 -0800 (PST)
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Amplifier may have no enable GPIO, so make this property
optional.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/simple-amplifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index c07e8a80b4b7..351aa55c384e 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -89,7 +89,8 @@ static int simple_amp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->gpiod_enable = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	priv->gpiod_enable = devm_gpiod_get_optional(dev, "enable",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_enable)) {
 		err = PTR_ERR(priv->gpiod_enable);
 		if (err != -EPROBE_DEFER)
-- 
2.19.1
