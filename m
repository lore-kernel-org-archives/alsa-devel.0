From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ASoC: free socdev if init_card() fails in
	wm9705_soc_probe()
Date: Sat, 22 Aug 2009 21:24:24 +0200
Message-ID: <4A9045E8.1080606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id C18B824801
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Aug 2009 21:19:35 +0200 (CEST)
Received: by ewy20 with SMTP id 20so1584406ewy.46
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2009 12:19:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Free socdev if snd_soc_init_card() fails.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
It doesn't seem to happen in snd_soc_init_card(), but please review.

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index fa88b46..e7d2840 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -406,7 +406,7 @@ static int wm9705_soc_probe(struct platform_device *pdev)
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9705: failed to register card\n");
-		goto pcm_err;
+		goto reset_err;
 	}
 
 	return 0;
