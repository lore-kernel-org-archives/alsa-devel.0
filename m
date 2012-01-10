From: Manjunath Hadli <manjunath.hadli@ti.com>
Subject: [RESEND PATCH] davinci: CQ93VC: remove machine
	specific header file inclusion from codec driver
Date: Tue, 10 Jan 2012 16:57:43 +0530
Message-ID: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E06E624353
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 12:28:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dlos <davinci-linux-open-source@linux.davincidsp.com>, LAK <linux-arm-kernel@lists.infradead.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Mark@alsa-project.org, Liam Girdwood <lrg@ti.com>, Manjunath Hadli <manjunath.hadli@ti.com>
List-Id: alsa-devel@alsa-project.org

remove unnecessary inclusion of machine specific header
file mach/dm365.h from cq93vc.c voice codec driver
which comes in the way of platform code consolidation.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
Cc: <alsa-devel@alsa-project.org>
Cc: <linux-kernel@vger.kernel.org>
---
 sound/soc/codecs/cq93vc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 46dbfd0..ff4eb7a 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -38,8 +38,6 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 
-#include <mach/dm365.h>
-
 static inline unsigned int cq93vc_read(struct snd_soc_codec *codec,
 						unsigned int reg)
 {
-- 
1.6.2.4
