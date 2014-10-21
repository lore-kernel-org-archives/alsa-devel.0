From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH V2 1/2] ARM: pxa: spitz: register spitz-audio
	device
Date: Wed, 22 Oct 2014 01:15:32 +0400
Message-ID: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 03D7026062F
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 23:15:37 +0200 (CEST)
Received: by mail-wg0-f44.google.com with SMTP id y10so2268878wgg.15
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 14:15:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Register spitz-audio device to be used by ASoC driver.

[V2: Removed ifdefs around spitz_audio_init].

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 840c3a4..af1dea3 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -924,6 +924,19 @@ static inline void spitz_i2c_init(void) {}
 #endif
 
 /******************************************************************************
+ * Audio devices
+ ******************************************************************************/
+static struct platform_device spitz_audio_device = {
+	.name	= "spitz-audio",
+	.id	= -1,
+};
+
+static inline void spitz_audio_init(void)
+{
+	platform_device_register(&spitz_audio_device);
+}
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void spitz_poweroff(void)
@@ -970,6 +983,7 @@ static void __init spitz_init(void)
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+	spitz_audio_init();
 }
 
 static void __init spitz_fixup(struct tag *tags, char **cmdline)
-- 
2.1.1
