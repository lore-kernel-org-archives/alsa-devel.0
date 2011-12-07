From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Include linux/module.h for
	smdk2443_wm9710
Date: Wed, 07 Dec 2011 17:52:19 +0800
Message-ID: <1323251539.27710.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F3241103862
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 10:52:26 +0100 (CET)
Received: by ghbg15 with SMTP id g15so295036ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2011 01:52:26 -0800 (PST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Graeme Gregory <graeme.gregory@wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Include linux/module.h to fix below build error:
  CC      sound/soc/samsung/smdk2443_wm9710.o
sound/soc/samsung/smdk2443_wm9710.c:64: error: expected declaration specifiers or '...' before string constant
sound/soc/samsung/smdk2443_wm9710.c:64: warning: data definition has no type or storage class
sound/soc/samsung/smdk2443_wm9710.c:64: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
sound/soc/samsung/smdk2443_wm9710.c:64: warning: function declaration isn't a prototype
sound/soc/samsung/smdk2443_wm9710.c:65: error: expected declaration specifiers or '...' before string constant
sound/soc/samsung/smdk2443_wm9710.c:65: warning: data definition has no type or storage class
sound/soc/samsung/smdk2443_wm9710.c:65: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
sound/soc/samsung/smdk2443_wm9710.c:65: warning: function declaration isn't a prototype
sound/soc/samsung/smdk2443_wm9710.c:66: error: expected declaration specifiers or '...' before string constant
sound/soc/samsung/smdk2443_wm9710.c:66: warning: data definition has no type or storage class
sound/soc/samsung/smdk2443_wm9710.c:66: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
sound/soc/samsung/smdk2443_wm9710.c:66: warning: function declaration isn't a prototype
make[3]: *** [sound/soc/samsung/smdk2443_wm9710.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/smdk2443_wm9710.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
index 3a0dbfc7..8bd1dc5 100644
--- a/sound/soc/samsung/smdk2443_wm9710.c
+++ b/sound/soc/samsung/smdk2443_wm9710.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include <linux/module.h>
 #include <sound/soc.h>
 
 static struct snd_soc_card smdk2443;
-- 
1.7.5.4
