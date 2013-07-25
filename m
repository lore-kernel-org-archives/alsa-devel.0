From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8994: Add clock bindings to the device
	tree
Date: Thu, 25 Jul 2013 15:31:08 +0100
Message-ID: <1374762668-5037-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1436026084C
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 16:31:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Due to the variable availability of the clock API there is no code in the
driver to use these at present, for the time being the machine drivers
will need to handle requesting clocks.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/sound/wm8994.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8994.txt b/Documentation/devicetree/bindings/sound/wm8994.txt
index f2f3e80..e045e90 100644
--- a/Documentation/devicetree/bindings/sound/wm8994.txt
+++ b/Documentation/devicetree/bindings/sound/wm8994.txt
@@ -32,6 +32,10 @@ Optional properties:
     The second cell is the flags, encoded as the trigger masks from
     Documentation/devicetree/bindings/interrupts.txt
 
+  - clocks : A list of up to two phandle and clock specifier pairs
+  - clock-names : A list of clock names sorted in the same order as clocks.
+                  Valid clock names are "MCLK1" and "MCLK2".
+
   - wlf,gpio-cfg : A list of GPIO configuration register values. If absent,
     no configuration of these registers is performed. If any value is
     over 0xffff then the register will be left as default. If present 11
-- 
1.8.3.2
