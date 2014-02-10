From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH v3 2/2] Binding: atmel-ssc: add option to
	choose clock
Date: Mon, 10 Feb 2014 14:09:46 +0800
Message-ID: <1392012586-30790-3-git-send-email-voice.shen@atmel.com>
References: <1392012586-30790-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id BAADC2610B4
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 07:12:17 +0100 (CET)
In-Reply-To: <1392012586-30790-1-git-send-email-voice.shen@atmel.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Rob Landley <rob@landley.net>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Richard Genoud <richard.genoud@gmail.com>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, nicolas.ferre@atmel.com, Mark Brown <broonie@linaro.org>, linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add the option to choose clock on which pin input to SSC (as slave).
Default is on TK pin to SSC, add "atmel,clk-from-rk-pin" option to
specify the clock is on RK pin to SSC.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v3:
  - None
Series-changes: 2
  - using "-" replace "_" in binding document

 Documentation/devicetree/bindings/misc/atmel-ssc.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index a45ae08..5c1e14e 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -14,6 +14,14 @@ Required properties for devices compatible with "atmel,at91sam9g45-ssc":
   See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
 - dma-names: Must be "tx", "rx".
 
+Optional properties:
+  - atmel,clk-from-rk-pin: bool property.
+     - When SSC works in slave mode, according to the hardware design, the
+       clock can get from TK pin, and also can get from RK pin. So, add
+       this parameter to choose where the clock from.
+     - By default the clock is from TK pin, if the clock from RK pin, this
+       property is needed.
+
 Examples:
 - PDC transfer:
 ssc0: ssc@fffbc000 {
-- 
1.8.5.2
