From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing clocks/clock-names on
	Document" to the asoc tree
Date: Wed, 17 May 2017 10:52:34 +0100
Message-ID: <E1dAvdC-0006u0-Js@debutante>
References: <8737cvsyah.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74663267556
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 11:52:44 +0200 (CEST)
In-Reply-To: <8737cvsyah.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add missing clocks/clock-names on Document

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

>From 5b3889f80a79d9b73f73e19ba9a001c2d47ab47f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Apr 2017 02:26:48 +0000
Subject: [PATCH] ASoC: rsnd: add missing clocks/clock-names on Document

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 3332910a9a11..13cb21d53b8b 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -368,6 +368,10 @@ Required properties:
 				  see below for detail.
 - #sound-dai-cells		: it must be 0 if your system is using single DAI
 				  it must be 1 if your system is using multi  DAI
+- clocks			: References to SSI/SRC/MIX/CTU/DVC/AUDIO_CLK clocks.
+- clock-names			: List of necessary clock names.
+				  "ssi-all", "ssi.X", "src.X", "mix.X", "ctu.X",
+				  "dvc.X", "clk_a", "clk_b", "clk_c", "clk_i"
 
 Optional properties:
 - #clock-cells			: it must be 0 if your system has audio_clkout
-- 
2.11.0
