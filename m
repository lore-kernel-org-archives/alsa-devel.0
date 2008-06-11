From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/10] ASoC: Add missing includes
Date: Wed, 11 Jun 2008 13:47:09 +0100
Message-ID: <1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5947C2481C
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:17 +0200 (CEST)
In-Reply-To: <1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Ensure that DAIs are prototyped in the codec drivers that define them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ac97.c   |    1 +
 sound/soc/codecs/wm9712.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 7bf2081..300d007 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -21,6 +21,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
+#include "ac97.h"
 
 #define AC97_VERSION "0.6"
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index d9789f1..28ac66f 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -22,6 +22,7 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include "wm9712.h"
 
 #define WM9712_VERSION "0.4"
 
-- 
1.5.5.3
