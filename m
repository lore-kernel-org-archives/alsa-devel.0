From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ALSA: cs553*: Fix dependencies
Date: Mon, 10 Mar 2014 21:12:26 +0100
Message-ID: <20140310211226.17ad03c6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2318F2602AD
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 21:12:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Jaya Kumar <jayakumar.alsa@gmail.com>
List-Id: alsa-devel@alsa-project.org

The CS5530, CS5535 and CS5536 chipsets are companions of the Geode
series of processors, which are 32-bit x86 processors. So the
snd-cs5530 and snd-cs5535audio drivers are only needed on this
architecture, except for build testing purpose.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jaya Kumar <jayakumar.alsa@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-3.14-rc6.orig/sound/pci/Kconfig	2014-02-09 16:53:07.699734368 +0100
+++ linux-3.14-rc6/sound/pci/Kconfig	2014-03-10 20:52:21.908690341 +0100
@@ -276,7 +276,7 @@ config SND_CS46XX_NEW_DSP
 
 config SND_CS5530
 	tristate "CS5530 Audio"
-	depends on ISA_DMA_API
+	depends on ISA_DMA_API && (X86_32 || COMPILE_TEST)
 	select SND_SB16_DSP
 	help
 	  Say Y here to include support for audio on Cyrix/NatSemi CS5530 chips.
@@ -286,6 +286,7 @@ config SND_CS5530
 
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
+	depends on X86_32 || COMPILE_TEST
 	select SND_PCM
 	select SND_AC97_CODEC
 	help

-- 
Jean Delvare
SUSE L3 Support
