From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: pcm512x: Do not redefine
	DIV_ROUND_CLOSEST_ULL
Date: Mon, 30 Mar 2015 22:31:02 -0300
Message-ID: <1427765462-7318-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id CD311260603
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 03:31:17 +0200 (CEST)
Received: by qcgx3 with SMTP id x3so2435576qcg.3
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 18:31:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, peda@axentia.se
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

DIV_ROUND_CLOSEST_ULL is already defined at <linux/kernel.h>, so use the 
definition from this header file rather than re-defining it locally.

This fixes the following build warning:

sound/soc/codecs/pcm512x.c:34:0: warning: "DIV_ROUND_CLOSEST_ULL" redefined [enabled by default]
In file included from include/linux/list.h:8:0,
                 from include/linux/module.h:9,
                 from sound/soc/codecs/pcm512x.c:19:
include/linux/kernel.h:110:0: note: this is the location of the previous definition

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/pcm512x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 5a30fdd..e12764d 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/clk.h>
+#include <linux/kernel.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -31,8 +32,6 @@
 
 #define DIV_ROUND_DOWN_ULL(ll, d) \
 	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
-#define DIV_ROUND_CLOSEST_ULL(ll, d) \
-	({ unsigned long long _tmp = (ll)+(d)/2; do_div(_tmp, d); _tmp; })
 
 #define PCM512x_NUM_SUPPLIES 3
 static const char * const pcm512x_supply_names[PCM512x_NUM_SUPPLIES] = {
-- 
1.9.1
