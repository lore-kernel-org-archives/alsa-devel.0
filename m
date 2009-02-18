From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/11] ASoC: Improve diagnostics for
	AT91SAM9G20-EK probe
Date: Wed, 18 Feb 2009 12:02:27 +0000
Message-ID: <1234958553-16049-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 49EE310389A
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:43 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
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

We should display an error by default if we fail to register.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 6ea04be..be3f923 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -273,6 +273,7 @@ static int __init at91sam9g20ek_init(void)
 	 */
 	ssc = ssc_request(0);
 	if (IS_ERR(ssc)) {
+		printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
 		ret = PTR_ERR(ssc);
 		ssc = NULL;
 		goto err_ssc;
@@ -281,8 +282,7 @@ static int __init at91sam9g20ek_init(void)
 
 	at91sam9g20ek_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!at91sam9g20ek_snd_device) {
-		printk(KERN_DEBUG
-				"platform device allocation failed\n");
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
 		ret = -ENOMEM;
 	}
 
@@ -292,8 +292,7 @@ static int __init at91sam9g20ek_init(void)
 
 	ret = platform_device_add(at91sam9g20ek_snd_device);
 	if (ret) {
-		printk(KERN_DEBUG
-				"platform device allocation failed\n");
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
 		platform_device_put(at91sam9g20ek_snd_device);
 	}
 
-- 
1.5.6.3
