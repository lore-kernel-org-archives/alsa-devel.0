From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/16] ALSA: hda - Add missing inclusion of
	<linux/clocksource.h>
Date: Thu, 16 Apr 2015 18:14:27 +0200
Message-ID: <1429200870-5288-14-git-send-email-tiwai@suse.de>
References: <1429200870-5288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 91D46261A96
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 18:14:38 +0200 (CEST)
In-Reply-To: <1429200870-5288-1-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

For fixing randconfig build errors like:

   sound/hda/hdac_stream.c: In function 'azx_timecounter_init':
   sound/hda/hdac_stream.c:365:2: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 8bd67a824b5e..9ffff6d9ba8e 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/clocksource.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/hdaudio.h>
-- 
2.3.5
