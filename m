From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] sound: Fix make allmodconfig on MIPS correctly
Date: Sun, 12 May 2013 14:31:19 +0200
Message-ID: <1368361879.1350.13.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit d4702b189c ("sound: Fix make allmodconfig on MIPS") added a
(negative) dependency on ISA_DMA_SUPPORT_BROKEN. Since that Kconfig
symbol doesn't exist, this dependency will always evaluate to true.
Apparently GENERIC_ISA_DMA_SUPPORT_BROKEN was meant to be used here.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested only with "git grep".

 sound/oss/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/Kconfig b/sound/oss/Kconfig
index 51c4ba9..1a96402 100644
--- a/sound/oss/Kconfig
+++ b/sound/oss/Kconfig
@@ -250,7 +250,7 @@ config MSND_FIFOSIZE
 menuconfig SOUND_OSS
 	tristate "OSS sound modules"
 	depends on ISA_DMA_API && VIRT_TO_BUS
-	depends on !ISA_DMA_SUPPORT_BROKEN
+	depends on !GENERIC_ISA_DMA_SUPPORT_BROKEN
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
 	  sound programming easier since they provide a common API.  Say Y or
-- 
1.7.11.7
