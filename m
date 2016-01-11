From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] ASoC: AMD: Add missing include file
Date: Mon, 11 Jan 2016 02:41:05 -0800
Message-ID: <1452508865-25863-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
List-Id: alsa-devel@alsa-project.org

arm:allmodconfig, s390:allmodconfig, sparc64:allmodconfig, and probably
other builds fail with

sound/soc/amd/acp-pcm-dma.c:83:2: error:
	implicit declaration of function =E2=80=98readl=E2=80=99
sound/soc/amd/acp-pcm-dma.c:88:2: error:
	implicit declaration of function =E2=80=98writel=E2=80=99

Include linux/io.h explicitly to fix the problem.

=46ixes: 7c31335a03b6a ("ASoC: AMD: add AMD ASoC ACP 2.x DMA driver")
Cc: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/amd/acp-pcm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cc8b841b69b6..3191e0a7d273 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -15,6 +15,7 @@
=20
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
=20
--=20
2.1.4
