From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix typos in Atmel module registration
Date: Tue,  9 Dec 2008 15:03:59 +0000
Message-ID: <1228835039-21122-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209150110.GA20933@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1FF0724476
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 16:04:00 +0100 (CET)
In-Reply-To: <20081209150110.GA20933@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I wish I had boards which work with unmodified kernels :/

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/atmel-pcm.c     |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index d6bcb4e..027eb13 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -483,7 +483,7 @@ static int __devinit atmel_pcm_modinit(void)
 }
 module_init(atmel_pcm_modinit);
 
-static void __exit atmel_pcm_exit(void)
+static void __exit atmel_pcm_modexit(void)
 {
 	snd_soc_unregister_platform(&atmel_soc_platform);
 }
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index c9f02ed..87904b6 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -776,12 +776,13 @@ static int __devinit atmel_ssc_modinit(void)
 {
 	return snd_soc_register_dais(atmel_ssc_dai, ARRAY_SIZE(atmel_ssc_dai));
 }
-module_init(snd_soc_init);
+module_init(atmel_ssc_modinit);
 
-static void __exit snd_soc_exit(void)
+static void __exit atmel_ssc_modexit(void)
 {
 	snd_soc_unregister_dais(atmel_ssc_dai, ARRAY_SIZE(atmel_ssc_dai));
 }
+module_exit(atmel_ssc_modexit);
 
 /* Module information */
 MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
-- 
1.5.6.5
