From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Include linux/io.h for jz4740 codec
Date: Tue, 06 Dec 2011 15:19:00 +0800
Message-ID: <1323155940.22557.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AF4E103B02
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 08:19:13 +0100 (CET)
Received: by yenl7 with SMTP id l7so2676911yen.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 23:19:10 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Include linux/io.h to fix below build errors:

  CC      sound/soc/codecs/jz4740.o
sound/soc/codecs/jz4740.c: In function 'jz4740_codec_read':
sound/soc/codecs/jz4740.c:82: error: implicit declaration of function 'readl'
sound/soc/codecs/jz4740.c: In function 'jz4740_codec_write':
sound/soc/codecs/jz4740.c:92: error: implicit declaration of function 'writel'
sound/soc/codecs/jz4740.c: In function 'jz4740_codec_probe':
sound/soc/codecs/jz4740.c:373: error: implicit declaration of function 'ioremap'
sound/soc/codecs/jz4740.c:373: warning: assignment makes pointer from integer without a cast
sound/soc/codecs/jz4740.c:393: error: implicit declaration of function 'iounmap'
make[3]: *** [sound/soc/codecs/jz4740.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/jz4740.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 517e2a5..d73d283 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <linux/delay.h>
 
-- 
1.7.5.4
