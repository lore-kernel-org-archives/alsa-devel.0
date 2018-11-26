From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup for SSIU subnode" to the
	asoc tree
Date: Mon, 26 Nov 2018 17:20:55 +0000 (GMT)
Message-ID: <20181126172055.32367112519F@debutante.sirena.org.uk>
References: <87in0k3aud.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6940F26770D
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 18:20:55 +0100 (CET)
In-Reply-To: <87in0k3aud.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup for SSIU subnode

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

>From 7121779fec95ce106ed3a7948d265809bd4e849b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Nov 2018 01:17:01 +0000
Subject: [PATCH] ASoC: rsnd: tidyup for SSIU subnode

commit da48a6eb82ea2 ("ASoC: rsnd: add SSIU BUSIF support for
Document") updated Documentation for SSIU, but 1) we want to
keep old/deprecated DMA description, 2) it is missing SSIU
subnode properties. This patch tidyup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 47dc8190f0a7..4d19d2bd6286 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -327,8 +327,13 @@ SSI subnode properties:
 - no-busif			: BUSIF is not ussed when [mem -> SSI] via DMA case
 - dma				: Should contain Audio DMAC entry
 - dma-names			: SSI  case "rx"  (=playback), "tx"  (=capture)
+				  Deprecated: see SSIU subnode properties
 				  SSIU case "rxu" (=playback), "txu" (=capture)
 
+SSIU subnode properties:
+- dma				: Should contain Audio DMAC entry
+- dma-names			: "rx" (=playback), "tx" (=capture)
+
 SRC subnode properties:
 - dma				: Should contain Audio DMAC entry
 - dma-names			: "rx" (=playback), "tx" (=capture)
-- 
2.19.0.rc2
