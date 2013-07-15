From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: kirkwood: Remove unused headers
Date: Mon, 15 Jul 2013 16:42:48 +0100
Message-ID: <1373902970-935-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4508726165C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 17:42:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/kirkwood/kirkwood-openrd.c | 2 --
 sound/soc/kirkwood/kirkwood-t5325.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index b979c71..addbebc 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -16,9 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <mach/kirkwood.h>
 #include <linux/platform_data/asoc-kirkwood.h>
-#include <asm/mach-types.h>
 #include "../codecs/cs42l51.h"
 
 static int openrd_client_hw_params(struct snd_pcm_substream *substream,
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 1d0ed6f..4f4cb56 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -15,9 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <mach/kirkwood.h>
 #include <linux/platform_data/asoc-kirkwood.h>
-#include <asm/mach-types.h>
 #include "../codecs/alc5623.h"
 
 static int t5325_hw_params(struct snd_pcm_substream *substream,
-- 
1.8.3.2
