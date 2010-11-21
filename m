From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/4] ASoC: Fix compile breakage in jz4740.c and
	smartq_wm8987.c
Date: Sun, 21 Nov 2010 19:48:44 +0200
Message-ID: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D0541037FC
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 18:48:54 +0100 (CET)
Received: by ewy2 with SMTP id 2so3482634ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 09:48:54 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Commit ce6120c require that soc-dapm.h cannot be included before soc.h but
these two drivers were not checked. Fix them by including only soc.h as it
includes soc-dapm.h.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/jz4740.c         |    1 -
 sound/soc/s3c24xx/smartq_wm8987.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 8a45562..f7cd346 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -22,7 +22,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
-#include <sound/soc-dapm.h>
 #include <sound/soc.h>
 
 #define JZ4740_REG_CODEC_1 0x0
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index 1f6da1e..5b07bb9 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -19,7 +19,7 @@
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/soc-dapm.h>
+#include <sound/soc.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
-- 
1.7.0.4
