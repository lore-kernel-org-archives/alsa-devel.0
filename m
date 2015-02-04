From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] sound: soc: codecs/ts3a227e: fix sparse warning
Date: Wed,  4 Feb 2015 17:29:30 +0000
Message-ID: <1423070970-24164-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch fixes following sparse warning:
ts3a227e.c:222:5: warning: symbol 'ts3a227e_enable_jack_detect' was not declared. Should it be static?

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Found this issue on linux-next (gcc  version 4.8.2,
 sparse version  0.4.5-rc1)and applies on top linux-next.

 sound/soc/codecs/ts3a227e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 5ecfa31..9fd80ac 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -20,6 +20,8 @@
 #include <sound/jack.h>
 #include <sound/soc.h>
 
+#include "ts3a227e.h"
+
 struct ts3a227e {
 	struct regmap *regmap;
 	struct snd_soc_jack *jack;
-- 
1.9.1
