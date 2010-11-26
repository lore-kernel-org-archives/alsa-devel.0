From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/4] ASoC: Add missing gpio_free(S3C64XX_GPK(12)) in
	smartq_exit()
Date: Fri, 26 Nov 2010 14:53:38 +0800
Message-ID: <1290754418.25125.6.camel@mola>
References: <1290754245.25125.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290754245.25125.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/smartq_wm8987.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 0a46fa8..61e2b52 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -274,6 +274,7 @@ err_unregister_device:
 
 static void __exit smartq_exit(void)
 {
+	gpio_free(S3C64XX_GPK(12));
 	snd_soc_jack_free_gpios(&smartq_jack, ARRAY_SIZE(smartq_jack_gpios),
 				smartq_jack_gpios);
 
-- 
1.7.2
