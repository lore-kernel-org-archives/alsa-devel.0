From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ALSA: cs5535audio: Also needed on MIPS
Date: Tue, 11 Mar 2014 11:38:34 +0100
Message-ID: <20140311113834.24b9b0a6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 596C22607BB
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 11:38:37 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Jaya Kumar <jayakumar.alsa@gmail.com>
List-Id: alsa-devel@alsa-project.org

The CS5536 companion chipset is not only used on 32-bit x86 systems as
I originally thought, it is also used on MIPS Loongson/Lemote 2
systems. So let the snd-cs5535audio driver be built on MIPS too.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jaya Kumar <jayakumar.alsa@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Takashi: the powerpc reference was irrelevant as the defconfig file I
mentioned includes all possible sound drivers.

Ralf: do you happen to know if any other CS55xx chip was used on MIPS
systems? Or any non-x86 systems for that matter.

 sound/pci/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc6.orig/sound/pci/Kconfig	2014-03-10 21:09:12.142069639 +0100
+++ linux-3.14-rc6/sound/pci/Kconfig	2014-03-11 11:29:10.346528331 +0100
@@ -286,7 +286,7 @@ config SND_CS5530
 
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
-	depends on X86_32 || COMPILE_TEST
+	depends on X86_32 || MIPS || COMPILE_TEST
 	select SND_PCM
 	select SND_AC97_CODEC
 	help


-- 
Jean Delvare
SUSE L3 Support
