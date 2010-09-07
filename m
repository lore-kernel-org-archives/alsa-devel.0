From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/4] ASoC: rx1950: check that machine is rx1950
	in glue driver
Date: Tue,  7 Sep 2010 17:04:15 +0300
Message-ID: <1283868258-26493-2-git-send-email-anarsoul@gmail.com>
References: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B5F8103821
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 16:17:27 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2230382eyd.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 07:17:27 -0700 (PDT)
In-Reply-To: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Philipp Zabel <philipp.zabel@gmail.com>, anarsoul@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/s3c24xx/rx1950_uda1380.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index 2a16113..0f6e806 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -40,6 +40,8 @@
 
 #include <mach/regs-clock.h>
 
+#include <asm/mach-types.h>
+
 #include "s3c-dma.h"
 #include "s3c24xx-i2s.h"
 #include "../codecs/uda1380.h"
@@ -274,6 +276,9 @@ static int __init rx1950_init(void)
 {
 	int ret;
 
+	if (!machine_is_rx1950())
+		return -ENODEV;
+
 	/* configure some gpios */
 	ret = gpio_request(S3C2410_GPA(1), "speaker-power");
 	if (ret)
-- 
1.7.2.2
