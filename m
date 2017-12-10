From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 43/45] sound/soc/zte: remove duplicate includes
Date: Mon, 11 Dec 2017 00:02:03 +0530
Message-ID: <1512930723-5037-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E564F266AE4
 for <alsa-devel@alsa-project.org>; Sun, 10 Dec 2017 19:32:14 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id m26so9890097pfj.11
 for <alsa-devel@alsa-project.org>; Sun, 10 Dec 2017 10:32:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jun.nie@linaro.org, baoyou.xie@linaro.org, shawnguo@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: pravin.shedge4linux@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 sound/soc/zte/zx-i2s.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/zte/zx-i2s.c b/sound/soc/zte/zx-i2s.c
index 9a05659..93428e1 100644
--- a/sound/soc/zte/zx-i2s.c
+++ b/sound/soc/zte/zx-i2s.c
@@ -20,9 +20,6 @@
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
 
 #define ZX_I2S_PROCESS_CTRL	0x04
 #define ZX_I2S_TIMING_CTRL	0x08
-- 
2.7.4
