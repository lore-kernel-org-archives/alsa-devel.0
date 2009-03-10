From: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed missing McBSP pinmux for
	SFFSDR
Date: Mon,  9 Mar 2009 23:32:09 -0400
Message-ID: <1236655929-31688-5-git-send-email-hugo@hugovil.com>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1236655929-31688-1-git-send-email-hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
---
 sound/soc/davinci/davinci-sffsdr.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 7fdfba8..1fc53c1 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -31,6 +31,7 @@
 #endif
 #include <mach/asp.h>
 #include <mach/edma.h>
+#include <mach/mux.h>
 
 #include "../codecs/pcm3008.h"
 #include "davinci-pcm.h"
@@ -135,6 +136,8 @@ static int __init sffsdr_init(void)
 	if (!machine_is_sffsdr())
 		return -EINVAL;
 
+	davinci_cfg_reg(DM644X_MCBSP);
+
 	sffsdr_snd_device = platform_device_alloc("soc-audio", 0);
 	if (!sffsdr_snd_device) {
 		printk(KERN_ERR "platform device allocation failed\n");
-- 
1.5.5
