From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] wm8750: it's MONO1, not MONO
Date: Sat,  9 Aug 2008 14:58:20 +0400
Message-ID: <1218279500-16583-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 24F3A24C1C
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Aug 2008 12:58:29 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so710375fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 09 Aug 2008 03:58:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since first commit wm8750 contained output named MONO, but
all routes mentioned MONO1. Correct MONO to be MONO1.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    9 ++++-----
 sound/soc/codecs/wm8750.c   |    2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index be500d3..3802d68 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -8,11 +8,10 @@
 #include <sound/pxa2xx-lib.h>
 
 #include <asm/irq.h>
-#include <asm/hardware.h>
-
-#include <asm/arch/pxa-regs.h>
-#include <asm/arch/pxa2xx-gpio.h>
-#include <asm/arch/audio.h>
+#include <mach/hardware.h>
+#include <mach/pxa-regs.h>
+#include <mach/pxa2xx-gpio.h>
+#include <mach/audio.h>
 
 static DEFINE_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index e23cb09..2e71394 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -348,7 +348,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("ROUT1"),
 	SND_SOC_DAPM_OUTPUT("LOUT2"),
 	SND_SOC_DAPM_OUTPUT("ROUT2"),
-	SND_SOC_DAPM_OUTPUT("MONO"),
+	SND_SOC_DAPM_OUTPUT("MONO1"),
 	SND_SOC_DAPM_OUTPUT("OUT3"),
 
 	SND_SOC_DAPM_INPUT("LINPUT1"),
-- 
1.5.6.3
