From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Get correct revision id for wm2200
Date: Thu, 16 Feb 2012 10:05:59 +0800
Message-ID: <1329357959.29391.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F871103838
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 03:06:10 +0100 (CET)
Received: by pbbrp2 with SMTP id rp2so2097145pbb.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 18:06:09 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm2200.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index a9388df..acbdc5f 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2084,7 +2084,7 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 		goto err_reset;
 	}
 
-	wm2200->rev = ret & WM2200_DEVICE_REVISION_MASK;
+	wm2200->rev = reg & WM2200_DEVICE_REVISION_MASK;
 
 	dev_info(&i2c->dev, "revision %c\n", wm2200->rev + 'A');
 
-- 
1.7.5.4
