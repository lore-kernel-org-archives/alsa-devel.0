From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 10/12] ASoC: pxa: Fix module autoload for OF platform drivers
Date: Thu, 3 Sep 2015 13:00:03 +0200
Message-ID: <20150903110003.GA17009@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

These platform drivers have a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 sound/soc/pxa/pxa-ssp.c    | 1 +
 sound/soc/pxa/pxa2xx-pcm.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index fbe2e93..c254a75 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -809,6 +809,7 @@ static const struct of_device_id pxa_ssp_of_ids[] = {
 	{ .compatible = "mrvl,pxa-ssp-dai" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, pxa_ssp_of_ids);
 #endif
 
 static int asoc_ssp_probe(struct platform_device *pdev)
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index a51c9da..f1aea95 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -138,6 +138,7 @@ static const struct of_device_id snd_soc_pxa_audio_match[] = {
 	{ .compatible   = "mrvl,pxa-pcm-audio" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, snd_soc_pxa_audio_match);
 #endif
 
 static struct platform_driver pxa_pcm_driver = {
-- 
2.4.6
