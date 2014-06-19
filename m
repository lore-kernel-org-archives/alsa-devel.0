From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: omap-pcm: Include omap-pcm.h
Date: Thu, 19 Jun 2014 09:40:29 +0200
Message-ID: <1403163631-26215-4-git-send-email-lars@metafoo.de>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 32C0B265283
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 09:40:46 +0200 (CEST)
In-Reply-To: <1403163631-26215-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

omap_pcm_platform_register() is declared in omap-pcm.h and defined in
omap-pcm.c. To make sure that the function signature matches for both omap-pcm.c
should include omap-pcm.h

Fixes the following warning from sparse:
	sound/soc/omap/omap-pcm.c:235:5: warning: symbol
	'omap_pcm_platform_register' was not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 8d809f8..f4b05bc 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -31,6 +31,7 @@
 #include <sound/pcm_params.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/soc.h>
+#include <sound/omap-pcm.h>
 
 #ifdef CONFIG_ARCH_OMAP1
 #define pcm_omap1510()	cpu_is_omap1510()
-- 
1.8.0
