From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] sound: sound_firmware: Fix invalid use of
	vfs_read()
Date: Tue, 26 May 2015 14:41:52 +0200
Message-ID: <1432644112-16543-6-git-send-email-tiwai@suse.de>
References: <1432644112-16543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AD0726522D
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:41:54 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CE5F9ADB6
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:41:53 +0000 (UTC)
In-Reply-To: <1432644112-16543-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

It should use kernel_read() instead of vfs_read() to load a firmware
binary onto the kernel pages.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sound_firmware.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/sound_firmware.c b/sound/sound_firmware.c
index b155137ee312..026347643c81 100644
--- a/sound/sound_firmware.c
+++ b/sound/sound_firmware.c
@@ -12,7 +12,6 @@ static int do_mod_firmware_load(const char *fn, char **fp)
 	struct file* filp;
 	long l;
 	char *dp;
-	loff_t pos;
 
 	filp = filp_open(fn, 0, 0);
 	if (IS_ERR(filp))
@@ -34,8 +33,7 @@ static int do_mod_firmware_load(const char *fn, char **fp)
 		fput(filp);
 		return 0;
 	}
-	pos = 0;
-	if (vfs_read(filp, dp, l, &pos) != l)
+	if (kernel_read(filp, 0, dp, l) != l)
 	{
 		printk(KERN_INFO "Failed to read '%s'.\n", fn);
 		vfree(dp);
-- 
2.4.1
