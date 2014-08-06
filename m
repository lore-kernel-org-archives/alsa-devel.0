Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F1E26109F
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:52:58 +0200 (CEST)
Received: from dflxv15.itg.ti.com ([128.247.5.124])
 by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76DqvS0006579
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:57 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
 by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqvCL023325
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dqu1G006181	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:56 -0500
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 6 Aug 2014 16:52:43 +0300
Message-ID: <a6888259f9508e0cc4be720a5f17a487d1d6cd0c.1407332062.git.jsarha@ti.com>
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 6/9] ARM: dts: am33xx: Add external clock
	provider
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

Add external clock provaider for am33xx devices.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..5093c64 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -92,6 +92,16 @@
 		pinctrl-single,function-mask = <0x7f>;
 	};
 
+	ext_clocks {
+		compatible = "ti,external-clocks";
+
+		ext_clocks: clocks {
+		};
+
+		ext_clockdomains: clockdomains {
+		};
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex. Since
-- 
1.7.9.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
