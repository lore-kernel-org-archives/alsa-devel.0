From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Add missing include file" to the
	asoc tree
Date: Mon, 11 Jan 2016 13:24:35 +0000
Message-ID: <E1aIcSZ-0003mG-JE@debutante>
References: <1452508865-25863-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3036033704905815077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3842260526
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 14:24:48 +0100 (CET)
In-Reply-To: <1452508865-25863-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3036033704905815077==
Content-Type: text/plain

The patch

   ASoC: AMD: Add missing include file

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7cb1dc810935fbf82ad06007dc7fb08d93c1e59f Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Jan 2016 02:41:05 -0800
Subject: [PATCH] ASoC: AMD: Add missing include file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arm:allmodconfig, s390:allmodconfig, sparc64:allmodconfig, and probably
other builds fail with

sound/soc/amd/acp-pcm-dma.c:83:2: error:
	implicit declaration of function ‘readl’
sound/soc/amd/acp-pcm-dma.c:88:2: error:
	implicit declaration of function ‘writel’

Include linux/io.h explicitly to fix the problem.

Fixes: 7c31335a03b6a ("ASoC: AMD: add AMD ASoC ACP 2.x DMA driver")
Cc: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cc8b841b69b6..3191e0a7d273 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -15,6 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
 
-- 
2.7.0.rc3


--===============3036033704905815077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3036033704905815077==--
