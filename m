From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 6/7] ASoC: pxa: remove bindings from pxa2xx-pcm
Date: Wed, 27 Jun 2018 21:33:58 +0200
Message-ID: <20180627193359.26631-7-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EB442679A7
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:14 +0200 (CEST)
In-Reply-To: <20180627193359.26631-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

This platform is no longer needed on DT boards, so let's remove them to
avoid confusion. DT bindings should use the CPU DAIs (I2S/SSP/AC97)
directly.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt | 15 ---------------
 sound/soc/pxa/pxa2xx-pcm.c                        |  9 ---------
 2 files changed, 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt b/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
deleted file mode 100644
index 551fbb8348c2..000000000000
--- a/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-DT bindings for ARM PXA2xx PCM platform driver
-
-This is just a dummy driver that registers the PXA ASoC platform driver.
-It does not have any resources assigned.
-
-Required properties:
-
-	- compatible		'mrvl,pxa-pcm-audio'
-
-Example:
-
-	pxa_pcm_audio: snd_soc_pxa_audio {
-		compatible = "mrvl,pxa-pcm-audio";
-	};
-
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index a1df4ec76cbd..72eaaef1b426 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -32,18 +32,9 @@ static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
 					       NULL, 0);
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id snd_soc_pxa_audio_match[] = {
-	{ .compatible   = "mrvl,pxa-pcm-audio" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, snd_soc_pxa_audio_match);
-#endif
-
 static struct platform_driver pxa_pcm_driver = {
 	.driver = {
 		.name = "pxa-pcm-audio",
-		.of_match_table = of_match_ptr(snd_soc_pxa_audio_match),
 	},
 
 	.probe = pxa2xx_soc_platform_probe,
-- 
2.17.1
