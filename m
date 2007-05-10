From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH3/5] ASoC S3C24xx machine drivers - SMDK 2443
Date: Thu, 10 May 2007 14:00:34 +0100
Message-ID: <1178802034.10518.71.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-gN6V2R14CtL1PJgTJtAE"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mimesweeper.wolfsonmicro.main (lumison.wolfsonmicro.com
	[87.246.78.27]) by alsa0.perex.cz (Postfix) with ESMTP id B68FD24390
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:01:04 +0200 (CEST)
Received: from orlando.wolfsonmicro.main (orlando.wolfsonmicro.main) by
	mimesweeper.wolfsonmicro.main (Clearswift SMTPRS 5.2.3) with ESMTP id
	<T7f82b3ba4cac140805bcc@mimesweeper.wolfsonmicro.main> for
	<alsa-devel@alsa-project.org>; Thu, 10 May 2007 14:01:03 +0100
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--=-gN6V2R14CtL1PJgTJtAE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Graeme Gregory <gg@opensource.wolfsonmicro.com>

This patch adds ALSA support for the SMDK2443 reference board.

Signed-off-by: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-gN6V2R14CtL1PJgTJtAE
Content-Disposition: attachment; filename="smdk2443-wm9710.patch"
Content-Type: text/x-patch; name="smdk2443-wm9710.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r d3759641c380 soc/s3c24xx/smdk2443_wm9710.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/s3c24xx/smdk2443_wm9710.c	Thu May 10 13:50:11 2007 +0100
@@ -0,0 +1,85 @@
+/*
+ * smdk2443_wm9710.c  --  SoC audio for smdk2443
+ *
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ * Author: Graeme Gregory
+ *         graeme.gregory@wolfsonmicro.com or linux@wolfsonmicro.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  Revision history
+ *    8th Mar 2007   Initial version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/ac97.h"
+#include "s3c24xx-pcm.h"
+#include "s3c24xx-ac97.h"
+
+static struct snd_soc_machine smdk2443;
+
+static struct snd_soc_dai_link smdk2443_dai[] = {
+{
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &s3c2443_ac97_dai[0],
+	.codec_dai = &ac97_dai,
+},
+};
+
+static struct snd_soc_machine smdk2443 = {
+	.name = "SMDK2443",
+	.dai_link = smdk2443_dai,
+	.num_links = ARRAY_SIZE(smdk2443_dai),
+};
+
+static struct snd_soc_device smdk2443_snd_ac97_devdata = {
+	.machine = &smdk2443,
+	.platform = &s3c24xx_soc_platform,
+	.codec_dev = &soc_codec_dev_ac97,
+};
+
+static struct platform_device *smdk2443_snd_ac97_device;
+
+static int __init smdk2443_init(void)
+{
+	int ret;
+
+	smdk2443_snd_ac97_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk2443_snd_ac97_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk2443_snd_ac97_device,
+				&smdk2443_snd_ac97_devdata);
+	smdk2443_snd_ac97_devdata.dev = &smdk2443_snd_ac97_device->dev;
+	ret = platform_device_add(smdk2443_snd_ac97_device);
+
+	if (ret)
+		platform_device_put(smdk2443_snd_ac97_device);
+
+	return ret;
+}
+
+static void __exit smdk2443_exit(void)
+{
+	platform_device_unregister(smdk2443_snd_ac97_device);
+}
+
+module_init(smdk2443_init);
+module_exit(smdk2443_exit);
+
+/* Module information */
+MODULE_AUTHOR("Graeme Gregory, graeme.gregory@wolfsonmicro.com, www.wolfsonmicro.com");
+MODULE_DESCRIPTION("ALSA SoC WM9710 SMDK2443");
+MODULE_LICENSE("GPL");

--=-gN6V2R14CtL1PJgTJtAE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-gN6V2R14CtL1PJgTJtAE--
