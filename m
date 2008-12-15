From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Fix declaration of sound_class
Date: Mon, 15 Dec 2008 15:43:43 +0000
Message-ID: <1229355823-23640-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 150921037ED
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 16:43:45 +0100 (CET)
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

Include sound/core.h in sound_core.c so that sound_class is declared
before it is defined, avoiding it looking like it should be static.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/sound_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 10ba421..2b302bb 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <sound/core.h>
 
 #ifdef CONFIG_SOUND_OSS_CORE
 static int __init init_oss_soundcore(void);
-- 
1.5.6.5
