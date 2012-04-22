From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: ASoC: sh: fsi: Build proble in 3.4-rc4
Date: Mon, 23 Apr 2012 00:01:41 +0200
Message-ID: <201204230001.41270.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

There is a build problem in sound/soc/sh/fsi.c which seems to be fixed by
the following patch.  I'm unsure if that is the right fix, though.

Thanks,
Rafael


---
 sound/soc/sh/fsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/sound/soc/sh/fsi.c
===================================================================
--- linux.orig/sound/soc/sh/fsi.c
+++ linux/sound/soc/sh/fsi.c
@@ -1003,7 +1003,7 @@ static void fsi_dma_do_tasklet(unsigned
 
 	desc = chan->device->device_prep_slave_sg(chan, &sg, 1, dir,
 						  DMA_PREP_INTERRUPT |
-						  DMA_CTRL_ACK);
+						  DMA_CTRL_ACK, NULL);
 	if (!desc) {
 		dev_err(dai->dev, "device_prep_slave_sg() fail\n");
 		return;
