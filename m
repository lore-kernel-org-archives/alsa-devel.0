From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 1/1] ASoC: kirkwood: add alias to pcm module
Date: Thu, 02 Sep 2010 10:31:47 +0200
Message-ID: <20100902083154.834825725@rtp-net.org>
References: <20100902083146.067960541@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 74DC8103880
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 10:33:43 +0200 (CEST)
Content-Disposition: inline; filename=kirkwood-pcm-alias.patch
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Allow snd-soc-kirkwood autoloading by adding an alias.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: sound-2.6/sound/soc/kirkwood/kirkwood-dma.c
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood-dma.c	2010-09-02 08:31:40.000000000 +0200
+++ sound-2.6/sound/soc/kirkwood/kirkwood-dma.c	2010-09-02 08:32:22.000000000 +0200
@@ -400,4 +400,4 @@
 MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
 MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
 MODULE_LICENSE("GPL");
-
+MODULE_ALIAS("platform:kirkwood-pcm-audio");
