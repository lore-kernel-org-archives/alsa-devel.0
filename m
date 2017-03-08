From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: cs35l35: Add device tree binding for
	I2S drive configuration
Date: Wed, 8 Mar 2017 16:42:48 +0000
Message-ID: <1488991371-22513-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B12A266B02
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 17:41:49 +0100 (CET)
In-Reply-To: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Add a binding for setting how the I2S pins are driven in unused slots,
currently the chip will just use the default of drive 0, however
this causes issues when multiple devices are attached to the same bus.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/sound/cs35l35.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
index 07d9c0f..958f0ea 100644
--- a/Documentation/devicetree/bindings/sound/cs35l35.txt
+++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
@@ -37,6 +37,11 @@ Optional properties:
   Table 3-10 of the datasheet lists drive-strength specifications
   0 = 1x (Default)
   1 = .5x
+  - cirrus,sp-drv-unused : Determines how unused slots should be driven on the
+  Serial Port.
+  0 - Hi-Z
+  2 - Drive 0's (Default)
+  3 - Drive 1's
 
   - cirrus,bst-pdn-fet-on : Boolean to determine if the Boost PDN control
   powers down with a rectification FET On or Off. If VSPK is supplied
-- 
2.1.4
