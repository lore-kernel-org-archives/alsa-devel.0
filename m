From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH] ASoC: Invert speaker enabling behaviour in SmartQ sound driver
Date: Sun, 04 Jul 2010 15:12:11 +0200
Message-ID: <4c3088ad.487e0e0a.3402.6e62@mx.google.com>
References: <F182A883-DE14-4BE4-8430-9C925E59893B@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <F182A883-DE14-4BE4-8430-9C925E59893B@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The speaker was enabled when the headphone was plugged in, which isn't the
wanted behaviour so correct this.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 sound/soc/s3c24xx/smartq_wm8987.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index c90ef96..b480348 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -112,7 +112,6 @@ static struct snd_soc_jack_pin smartq_jack_pins[] = {
 	{
 		.pin	= "Internal Speaker",
 		.mask	= SND_JACK_HEADPHONE,
-		.invert	= true,
 	},
 };
 
-- 
1.7.0.4
