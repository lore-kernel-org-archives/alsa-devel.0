From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH 2/2] mfd: arizona: Update DT binding to support
 INn_MODE
Date: Sat, 09 Aug 2014 17:35:45 +0900
Message-ID: <20140809173545.2fc1f72e@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

This patch update DT binding to support INn_MODE init_data

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 5c7e723..c21a30e 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -42,6 +42,11 @@ Optional properties:
     the chip default will be used.  If present exactly five values must
     be specified.
 
+  - wlf,inmode : A list of INn_MODE register values. If absent, INn_MODE register
+    set to 0 by default. The size of this list depends on ARIZONA_MAX_INPUT values.
+    ARIZONA_MAX_INPUT is defined in include/linux/mfd/arizona/pdata.h. If present,
+    exactly ARIZONA_MAX_INPUT values must be specified.
+
   - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
     they are being externally supplied. As covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
-- 
2.0.0.390.gcb682f8
