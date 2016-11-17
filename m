From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] sound: Add dependency on DMA
Date: Thu, 17 Nov 2016 10:52:37 -0800
Message-ID: <20161117185237.7070-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Florian Fainelli <f.fainelli@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Architectures like m32r do not have a proper DMA-API implementation,
fixes COMPILE_TEST linking failures for the sounds subsystem.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 sound/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/Kconfig b/sound/Kconfig
index 5a240e050ae6..a768704d2f47 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -60,6 +60,7 @@ if !M68K && !UML
 
 menuconfig SND
 	tristate "Advanced Linux Sound Architecture"
+	depends on HAS_DMA
 	help
 	  Say 'Y' or 'M' to enable ALSA (Advanced Linux Sound Architecture),
 	  the new base sound system.
-- 
2.9.3
