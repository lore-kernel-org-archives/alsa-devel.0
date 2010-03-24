From: Dan Carpenter <error27@gmail.com>
Subject: [patch] wm8994: playback => capture
Date: Wed, 24 Mar 2010 14:58:34 +0300
Message-ID: <20100324115834.GG21571@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Joonyoung Shim <jy0922.shim@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sparse caught that initialize "playback" two times instead of
initializing "capture".

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 29f3771..d10d651 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3401,7 +3401,7 @@ struct snd_soc_dai wm8994_dai[] = {
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
 		},
-		.playback = {
+		.capture = {
 			.stream_name = "AIF3 Capture",
 			.channels_min = 2,
 			.channels_max = 2,
