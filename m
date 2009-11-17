From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCHv2 5/7] S3C AUDIO: Added platform data header
Date: Tue, 17 Nov 2009 16:53:50 +0900
Message-ID: <1258444430-24118-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D62524445
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 09:01:23 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Many SoCs have their I2S pins MUXed with other functions. So we need
to pass a callback for driver to configure the pins appropriately.
Hence, the need of platform data and this header.

As and when needed new callbacks and structure pointers maybe added to this
header.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c/include/plat/audio.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/audio.h

diff --git a/arch/arm/plat-s3c/include/plat/audio.h b/arch/arm/plat-s3c/include/plat/audio.h
new file mode 100644
index 0000000..f22d23b
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/audio.h
@@ -0,0 +1,17 @@
+/* arch/arm/plat-s3c/include/plat/audio.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co. Ltd
+ * Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/**
+ * struct s3c_audio_pdata - common platform data for audio device drivers
+ * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
+ */
+struct s3c_audio_pdata {
+	int (*cfg_gpio)(struct platform_device *);
+};
-- 
1.6.2.5
