From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH v2] ASoC: rsnd: Add device tree binding for
	r8a77990
Date: Thu,  6 Sep 2018 22:28:33 +0900
Message-ID: <1536240513-22172-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 38C4B2673F4
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 15:28:48 +0200 (CEST)
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so5282337pfo.12
 for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2018 06:28:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>

This patch adds the device tree binding of the r8a77990 SoC.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

v2 [Yoshihiro Kaneko]
- Rebased

 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 9e764270..58971a6 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -353,6 +353,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
 				    - "renesas,rcar_sound-r8a7796" (R-Car M3-W)
 				    - "renesas,rcar_sound-r8a77965" (R-Car M3-N)
+				    - "renesas,rcar_sound-r8a77990" (R-Car E3)
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
-- 
1.9.1
