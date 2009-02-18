From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Include I2C headers for corgi and
	poodle
Date: Wed, 18 Feb 2009 12:56:26 +0000
Message-ID: <1234961787-18435-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218125510.GA11978@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D29E1038AF
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:56:35 +0100 (CET)
In-Reply-To: <20090218125510.GA11978@opensource.wolfsonmicro.com>
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
 sound/soc/pxa/corgi.c  |    1 +
 sound/soc/pxa/poodle.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index eaa6691..2a309c7 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/timer.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index fd683a0..10e3d70 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/timer.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
-- 
1.5.6.3
