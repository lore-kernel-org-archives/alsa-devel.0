From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Fix i.MX audio build for i.MX3x
Date: Fri,  8 Jan 2010 16:19:56 +0000
Message-ID: <1262967598-4096-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 388BD10384F
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 17:20:02 +0100 (CET)
In-Reply-To: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Don't unconditionally include the i.MX2x DMA driver, the arch/arm
functions it uses aren't available for i.MX3x.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/imx/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
index 4bde34a..d05cc95 100644
--- a/sound/soc/imx/Makefile
+++ b/sound/soc/imx/Makefile
@@ -1,5 +1,5 @@
 # i.MX Platform Support
-snd-soc-imx-objs := imx-ssi.o imx-pcm-fiq.o imx-pcm-dma-mx2.o
+snd-soc-imx-objs := imx-ssi.o imx-pcm-fiq.o
 
 ifdef CONFIG_MACH_MX27
 snd-soc-imx-objs += imx-pcm-dma-mx2.o
-- 
1.6.6
