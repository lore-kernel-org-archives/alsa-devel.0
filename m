From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/9] ASoC: Include header file in cs4270 and
	wm9705
Date: Fri, 23 Jan 2009 17:18:39 +0000
Message-ID: <1232731120-6144-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
	<1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 729E524493
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <1232731120-6144-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensures that the DAI and socdev exported by the codec match up with
their exported prototype.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs4270.c |    2 ++
 sound/soc/codecs/wm9705.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 2e4ce04..e2130d7 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -29,6 +29,8 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 
+#include "cs4270.h"
+
 /* Private data for the CS4270 */
 struct cs4270_private {
 	unsigned int mclk; /* Input frequency of the MCLK pin */
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 5e1937a..d5c81bb 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -20,6 +20,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+#include "wm9705.h"
+
 /*
  * WM9705 register cache
  */
-- 
1.5.6.5
