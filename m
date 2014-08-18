From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH v3 2/2] mfd: arizona: Update DT binding to support
 INn_MODE init_data
Date: Mon, 18 Aug 2014 20:00:09 +0900
Message-ID: <20140818200009.12a52dfa@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sameo@linux.intel.com, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com
List-Id: alsa-devel@alsa-project.org

This patch update DT binding to support INn_MODE init_data. Each
input signal path can be configurated either as a Analogue or
Digital using the INn_MODE registers.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 5c7e723..0064b21 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -42,6 +42,14 @@ Optional properties:
     the chip default will be used.  If present exactly five values must
     be specified.
 
+  - wlf,inmode : A list of INn_MODE register values, where n is the number
+    of input signals. Each input signal path can be configurated either as a
+    Analogue or Digital using the INn_MODE registers. If absent, INn_MODE
+    registers set to 0 by default. If present, values must be specified less
+    than or equal to the number of input singals. If values less than the
+    number of input signals, elements that has not been specifed are set to 0
+    by default.
+
   - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
     they are being externally supplied. As covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
-- 
2.0.0.390.gcb682f8
