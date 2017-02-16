From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v2 2/3] MAINTAINERS: add zte tdm controller driver to ARM  ZTE architecture
Date: Thu, 16 Feb 2017 19:05:05 +0800
Message-ID: <1487243106-22841-2-git-send-email-baoyou.xie@linaro.org>
References: <1487243106-22841-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487243106-22841-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, jun.nie@linaro.org, shawn.guo@linaro.org
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: alsa-devel@alsa-project.org

Add the zte tdm controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63063b..1269eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1991,7 +1991,9 @@ F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/sound/zte,zx-tdm.txt
 F:	include/dt-bindings/soc/zx*.h
+F:	sound/soc/zte/zx-tdm.c
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
-- 
2.7.4
