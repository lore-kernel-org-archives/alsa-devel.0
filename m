From: Mark Brown <broonie@kernel.org>
Subject: Applied "- filename :
	ASoC-rsrc-card-Clarify-compatible-value.patch
Date: Fri, 30 Oct 2015 10:43:28 +0900
Message-ID: <E1Zryj2-0008UR-Ne@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EB61265AB3
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 02:43:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

- name          : ASoC: rsrc-card: Clarify compatible value" to the asoc tree
In-Reply-To:  <1446148795-20629-1-git-send-email-geert+renesas@glider.be>

The patch

   - filename      : ASoC-rsrc-card-Clarify-compatible-value.patch
- name          : ASoC: rsrc-card: Clarify compatible value

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 33833b9af9ec89356fbfcd9ff0679b136f20e12f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 29 Oct 2015 20:59:55 +0100
Subject: [PATCH] ASoC: rsrc-card: Clarify compatible value

The compatible value can be board-specific, not SoC-specific.
Add curly braces to indicate that the board type is optional.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
index 962748a..2b2caa2 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
@@ -4,8 +4,8 @@ Renesas Sampling Rate Convert Sound Card specifies audio DAI connections of SoC
 
 Required properties:
 
-- compatible				: "renesas,rsrc-card,<board>"
-					  Examples with soctypes are:
+- compatible				: "renesas,rsrc-card{,<board>}"
+					  Examples with boards are:
 					    - "renesas,rsrc-card"
 					    - "renesas,rsrc-card,lager"
 					    - "renesas,rsrc-card,koelsch"
-- 
2.6.1
