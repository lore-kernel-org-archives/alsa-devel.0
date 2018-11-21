From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: rsnd: Add device tree support for
	r8a77995
Date: Wed, 21 Nov 2018 01:06:43 +0000
Message-ID: <87zhu31c3r.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400132.outbound.protection.outlook.com [40.107.140.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 125732678DD
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 02:06:46 +0100 (CET)
Content-Language: en-US
Content-ID: <FF81A78421C5FA4F9FB538F4F26462B2@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, HIROYUKI YOKOYAMA <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org


From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 453e8ec..47dc819 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -277,6 +277,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7796" (R-Car M3-W)
 				    - "renesas,rcar_sound-r8a77965" (R-Car M3-N)
 				    - "renesas,rcar_sound-r8a77990" (R-Car E3)
+				    - "renesas,rcar_sound-r8a77995" (R-Car D3)
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
-- 
2.7.4
