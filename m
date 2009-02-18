From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/11] ASoC: Check machine type before loading
	on AT91SAM9G20-EK
Date: Wed, 18 Feb 2009 12:02:28 +0000
Message-ID: <1234958553-16049-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 44BE910388F
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:18:18 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index be3f923..b7efdc8 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -45,6 +45,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+#include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 
@@ -268,6 +269,9 @@ static int __init at91sam9g20ek_init(void)
 	struct ssc_device *ssc = NULL;
 	int ret;
 
+	if (!machine_is_at91sam9g20ek())
+		return -ENODEV;
+
 	/*
 	 * Request SSC device
 	 */
-- 
1.5.6.3
