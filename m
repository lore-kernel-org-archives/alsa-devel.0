From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 7/8] regulator: arizona-micbias: Add
	description of micbias binding
Date: Tue, 28 Mar 2017 15:14:43 +0100
Message-ID: <1490710484-25277-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 818C6266DF0
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:13:49 +0200 (CEST)
In-Reply-To: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

Add the new micbias regulators into the Arizona regulator binding
document.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Rob Herring <robh@kernel.org>
---

No changes since v1.

 Documentation/devicetree/bindings/regulator/arizona-regulator.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
index 443564d..68a13d5 100644
--- a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
@@ -15,3 +15,9 @@ Optional subnodes:
     Documentation/devicetree/bindings/regulator/regulator.txt
   - micvdd : Initial data for the MICVDD regulator, as covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
+
+  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt but the
+    following additional properties are also supported:
+      - wlf,ext-cap : Specifies if the MICBIAS has external decoupling
+        capacitors attached.
-- 
2.1.4
