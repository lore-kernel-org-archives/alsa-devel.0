From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] sound: fix MODULE_LICENSE typos
Date: Fri, 22 Jun 2012 16:21:49 -0700
Message-ID: <20120622232149.GA29819@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kees Cook <keescook@chromium.org>, Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Joshua Kroll <joshkroll@google.com>
List-Id: alsa-devel@alsa-project.org

include/linux/license.h does not recognize "GPLv2", so adjust these
declarations to add the needed space before the version.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/soc/ux500/ux500_msp_dai.c |    2 +-
 sound/soc/ux500/ux500_msp_i2s.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 93c6c40..62ac028 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -840,4 +840,4 @@ static struct platform_driver msp_i2s_driver = {
 };
 module_platform_driver(msp_i2s_driver);
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 496dec1..ee14d2d 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -739,4 +739,4 @@ void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
 	devm_kfree(&pdev->dev, msp);
 }
 
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
