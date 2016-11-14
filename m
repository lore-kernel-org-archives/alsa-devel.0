From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ASoC: rt5677: Remove superfluous
	linux/kthread.h inclusion
Date: Mon, 14 Nov 2016 22:17:45 +0100
Message-ID: <20161114211745.21761-2-tiwai@suse.de>
References: <20161114211745.21761-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BB675266F05
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 22:17:55 +0100 (CET)
In-Reply-To: <20161114211745.21761-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's nowhere used in this driver code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/rt5677-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 91879ea95415..ebd0f7c5ad3b 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/sched.h>
-#include <linux/kthread.h>
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/regulator/consumer.h>
-- 
2.10.2
