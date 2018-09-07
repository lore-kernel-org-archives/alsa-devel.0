From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add device tree binding for
	r8a77990" to the asoc tree
Date: Fri,  7 Sep 2018 12:03:29 +0100 (BST)
Message-ID: <20180907110329.173DA1122A6D@debutante.sirena.org.uk>
References: <1536240513-22172-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A49A6267827
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 13:03:31 +0200 (CEST)
In-Reply-To: <1536240513-22172-1-git-send-email-ykaneko0929@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add device tree binding for r8a77990

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e058a4033240d30192124d6bf32b78e9a1f8975c Mon Sep 17 00:00:00 2001
From: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Date: Thu, 6 Sep 2018 22:28:33 +0900
Subject: [PATCH] ASoC: rsnd: Add device tree binding for r8a77990

This patch adds the device tree binding of the r8a77990 SoC.

Signed-off-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 8083f0d8f263..f4688c508be6 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -354,6 +354,7 @@ Required properties:
 				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
 				    - "renesas,rcar_sound-r8a7796" (R-Car M3-W)
 				    - "renesas,rcar_sound-r8a77965" (R-Car M3-N)
+				    - "renesas,rcar_sound-r8a77990" (R-Car E3)
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
-- 
2.19.0.rc1
