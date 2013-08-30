From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl: Add one blank space after ':='
	in Makefile
Date: Fri, 30 Aug 2013 17:39:00 +0800
Message-ID: <4745bb7638040cb8549802c4caf8913bc1493fa3.1377855239.git.b42378@freescale.com>
References: <7c26687b556e1b4fc33ea5771de7b64e45a02d38.1377855239.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C7652655E5
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 11:27:16 +0200 (CEST)
In-Reply-To: <7c26687b556e1b4fc33ea5771de7b64e45a02d38.1377855239.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is a blank space missing between ':=' and 'imx-spdif.o', thus add it.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index e2aaff7..8db705b 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -45,7 +45,7 @@ snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
 snd-soc-imx-wm8962-objs := imx-wm8962.o
-snd-soc-imx-spdif-objs :=imx-spdif.o
+snd-soc-imx-spdif-objs := imx-spdif.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
 
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
-- 
1.7.1
