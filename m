From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8782: Add __devexit_p at necessary
	place
Date: Sun, 02 Oct 2011 08:55:02 +0800
Message-ID: <1317516902.8024.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 67AC1246D0
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 02:55:15 +0200 (CEST)
Received: by iabn5 with SMTP id n5so3781429iab.38
	for <alsa-devel@alsa-project.org>; Sat, 01 Oct 2011 17:55:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to the comments in include/linux/init.h:

"Pointers to __devexit functions must use __devexit_p(function_name), the
wrapper will insert either the function_name or NULL, depending on the config
options."

We have __devexit annotation for wm8782_remove(), thus add __devexit_p at
necessary place.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8782.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index a2a09f8..f2ced71 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -60,7 +60,7 @@ static struct platform_driver wm8782_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8782_probe,
-	.remove = wm8782_remove,
+	.remove = __devexit_p(wm8782_remove),
 };
 
 static int __init wm8782_init(void)
-- 
1.7.4.1
