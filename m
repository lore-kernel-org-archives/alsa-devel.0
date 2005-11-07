From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/drivers/vx/vx_hwdep.c should #include <linux/vmalloc.h>
Date: Mon, 7 Nov 2005 21:03:41 +0100
Message-ID: <20051107200341.GI3847__31957.2142827839$1131394075$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C2A9818A
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2005 21:03:41 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is required for always getting the vmalloc()/vfree() prototypes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm1-full/sound/drivers/vx/vx_hwdep.c.old	2005-11-07 18:48:50.000000000 +0100
+++ linux-2.6.14-mm1-full/sound/drivers/vx/vx_hwdep.c	2005-11-07 18:49:04.000000000 +0100
@@ -23,6 +23,7 @@
 #include <sound/driver.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/vmalloc.h>
 #include <sound/core.h>
 #include <sound/hwdep.h>
 #include <sound/vx_core.h>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
