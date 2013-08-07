From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ALSA: don't push static constants on stack for
	%*ph
Date: Wed,  7 Aug 2013 17:55:14 +0300
Message-ID: <1375887314-15567-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 82FCD26552E
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 16:55:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There is no need to pass constants via stack. The width may be explicitly
specified in the format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/isa/gus/interwave.c  | 3 +--
 sound/usb/6fire/firmware.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 9942691..afef0d7 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -443,8 +443,7 @@ static void snd_interwave_detect_memory(struct snd_gus_card *gus)
 		for (i = 0; i < 8; ++i)
 			iwave[i] = snd_gf1_peek(gus, bank_pos + i);
 #ifdef CONFIG_SND_DEBUG_ROM
-		printk(KERN_DEBUG "ROM at 0x%06x = %*phC\n", bank_pos,
-				  8, iwave);
+		printk(KERN_DEBUG "ROM at 0x%06x = %8phC\n", bank_pos, iwave);
 #endif
 		if (strncmp(iwave, "INTRWAVE", 8))
 			continue;	/* first check */
diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index b9defcd..780bf3f 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -346,10 +346,10 @@ static int usb6fire_fw_check(u8 *version)
 		if (!memcmp(version, known_fw_versions + i, 2))
 			return 0;
 
-	snd_printk(KERN_ERR PREFIX "invalid fimware version in device: %*ph. "
+	snd_printk(KERN_ERR PREFIX "invalid fimware version in device: %4ph. "
 			"please reconnect to power. if this failure "
 			"still happens, check your firmware installation.",
-			4, version);
+			version);
 	return -EINVAL;
 }
 
-- 
1.8.4.rc1
