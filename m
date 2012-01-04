From: Manjunath Hadli <manjunath.hadli@ti.com>
Subject: [PATCH v8 2/2] davinci: CQ93VC: remove machine specific header file
 inclusion from codec driver
Date: Wed, 4 Jan 2012 12:47:49 +0530
Message-ID: <1325661469-4411-3-git-send-email-manjunath.hadli@ti.com>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dlos <davinci-linux-open-source@linux.davincidsp.com>, LAK <linux-arm-kernel@lists.infradead.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Manjunath Hadli <manjunath.hadli@ti.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

remove unnecessary inclusion of machine specific header
file mach/dm365.h from cq93vc.c voice codec driver
which comes in the way of platform code consolidation.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>
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
