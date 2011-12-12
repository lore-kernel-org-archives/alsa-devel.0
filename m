From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix hx4700 error handling to free gpios
 if snd_soc_register_card fails
Date: Mon, 12 Dec 2011 11:26:00 +0800
Message-ID: <1323660360.4507.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 00E8524581
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 04:26:13 +0100 (CET)
Received: by yenm9 with SMTP id m9so3896999yen.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2011 19:26:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Dmitry Artamonow <mad_soft@inbox.ru>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/hx4700.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index e32afaf..03ef9f3 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -209,9 +209,10 @@ static int __devinit hx4700_audio_probe(struct platform_device *pdev)
 	snd_soc_card_hx4700.dev = &pdev->dev;
 	ret = snd_soc_register_card(&snd_soc_card_hx4700);
 	if (ret)
-		return ret;
+		gpio_free_array(hx4700_audio_gpios,
+				ARRAY_SIZE(hx4700_audio_gpios));
 
-	return 0;
+	return ret;
 }
 
 static int __devexit hx4700_audio_remove(struct platform_device *pdev)
-- 
1.7.5.4
