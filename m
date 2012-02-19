From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ALSA: Remove __devinit annotation for
 pxa2xx_ac97_hw_probe to fix section mismatch warning
Date: Sun, 19 Feb 2012 15:39:18 +0800
Message-ID: <1329637158.4818.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 398C1103BE8
	for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2012 08:39:25 +0100 (CET)
Received: by dady9 with SMTP id y9so4940710dad.38
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 23:39:24 -0800 (PST)
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
Cc: Eric Miao <eric.y.miao@gmail.com>, Iwai <tiwai@suse.de>, Takashi@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This fixes below build warning:
WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
The function pxa2xx_ac97_probe() references
the function __devinit pxa2xx_ac97_hw_probe().
This is often because pxa2xx_ac97_probe lacks a __devinit
annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 0e9e822..5e926c4 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -313,7 +313,7 @@ int pxa2xx_ac97_hw_resume(void)
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
 #endif
 
-int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
+int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 {
 	int ret;
 	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
-- 
1.7.5.4
