From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: Fix error handling in e800_init to
	free gpios
Date: Wed, 07 Dec 2011 10:01:30 +0800
Message-ID: <1323223290.7936.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A6AE72457A
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 03:01:44 +0100 (CET)
Received: by ghbg15 with SMTP id g15so54090ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2011 18:01:42 -0800 (PST)
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
Cc: Ian Molton <spyro@f2s.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/e800_wm9712.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 6a8f38b..26e0232 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -136,8 +136,10 @@ static int __init e800_init(void)
 		goto free_spk_amp_gpio;
 
 	e800_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!e800_snd_device)
-		return -ENOMEM;
+	if (!e800_snd_device) {
+		ret = -ENOMEM;
+		goto free_spk_amp_gpio;
+	}
 
 	platform_set_drvdata(e800_snd_device, &e800);
 	ret = platform_device_add(e800_snd_device);
-- 
1.7.5.4
