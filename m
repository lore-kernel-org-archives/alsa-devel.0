From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v1 2/3] MAINTAINERS: add zte tdm controller
	driver to ARM ZTE architecture
Date: Mon, 13 Feb 2017 16:17:32 +0800
Message-ID: <1486973853-25291-2-git-send-email-baoyou.xie@linaro.org>
References: <1486973853-25291-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f181.google.com (mail-pf0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id CEDB72668EC
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 09:18:13 +0100 (CET)
Received: by mail-pf0-f181.google.com with SMTP id 202so22774094pfx.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 00:18:13 -0800 (PST)
In-Reply-To: <1486973853-25291-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, jun.nie@linaro.org, shawn.guo@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, baoyou.xie@linaro.org, linux-arm-kernel@lists.infradead.org
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
