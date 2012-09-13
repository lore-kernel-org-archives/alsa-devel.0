From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 4/7] ASoC: fsl: cleanup headers in
	pcm030-audio-fabric
Date: Thu, 13 Sep 2012 17:43:13 -0400
Message-ID: <1347572596-37540-5-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BA1E26533F
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 23:43:27 +0200 (CEST)
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Remove unreferenced header files.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index b3af55d..1353e8f 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -12,22 +12,13 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/interrupt.h>
 #include <linux/device.h>
-#include <linux/delay.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
-#include <linux/dma-mapping.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
 #include <sound/soc.h>
 
 #include "mpc5200_dma.h"
-#include "mpc5200_psc_ac97.h"
-#include "../codecs/wm9712.h"
 
 #define DRV_NAME "pcm030-audio-fabric"
 
-- 
1.7.2.5
