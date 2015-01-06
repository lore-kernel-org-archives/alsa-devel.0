From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] sound: soc: atmel sam9g20_wm8731: remove useless include
Date: Tue,  6 Jan 2015 10:21:20 +0100
Message-ID: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Bo Shen <voice.shen@atmel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

A mach/ header is included but never used. Simply remove it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 sound/soc/atmel/sam9g20_wm8731.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 66b66d0e7514..531728975bbb 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -47,7 +47,6 @@
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
-#include <mach/hardware.h>
 
 #include "../codecs/wm8731.h"
 #include "atmel-pcm.h"
-- 
2.1.0
