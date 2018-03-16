From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ASoC: rsnd: Document R-Car M3-W support
Date: Fri, 16 Mar 2018 14:59:45 +0100
Message-ID: <1521208785-5698-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
 by alsa0.perex.cz (Postfix) with ESMTP id ABAC1267503
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 15:20:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

Document support for the sound modules in the Renesas M3-W (r8a7796)
SoC.

No driver update is needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
"renesas,rcar_sound-r8a7796" has been in use since quite a while, but
the binding update was still missing.
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 5bed9a5957729453..b86d790f630ff79a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -351,6 +351,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7793" (R-Car M2-N)
 				    - "renesas,rcar_sound-r8a7794" (R-Car E2)
 				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
+				    - "renesas,rcar_sound-r8a7796" (R-Car M3-W)
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
-- 
2.7.4
