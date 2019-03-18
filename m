From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing reg/reg-name at
	Document" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:24 +0000 (GMT)
Message-ID: <20190318145124.A4FCC1128874@debutante.sirena.org.uk>
References: <87h8c0ye0n.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AFADF8972C
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:26 +0100 (CET)
In-Reply-To: <87h8c0ye0n.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add missing reg/reg-name at Document

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

>From 14c747506ae65005ab024f2247e68b8e045f210a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2019 14:11:27 +0900
Subject: [PATCH] ASoC: rsnd: add missing reg/reg-name at Document

reg is missing "Audio DMAC peri peri" part,
and reg-name itself is missing at Document.
This patch add these.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 648d43e1b1e9..c58af457a831 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -282,7 +282,10 @@ Required properties:
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
-				   SRU/ADG/SSIU/SSI if generation2
+				   SRU/ADG/SSIU/SSI/AUDIO-DMAC-periperi if generation2/generation3
+- reg-names			: Should contain the register names.
+				   scu/adg/ssi	if generation1
+				   scu/adg/ssiu/ssi/audmapp if generation2/generation3
 - rcar_sound,ssi		: Should contain SSI feature.
 				  The number of SSI subnode should be same as HW.
 				  see below for detail.
-- 
2.20.1
