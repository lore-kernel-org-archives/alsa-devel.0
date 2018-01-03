From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: tidyup simple-card example for
	CPU node" to the asoc tree
Date: Wed, 03 Jan 2018 17:43:47 +0000
Message-ID: <E1eWn4t-0005mU-27@debutante>
References: <873743nxuj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9129B2676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 18:43:53 +0100 (CET)
In-Reply-To: <873743nxuj.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Simon <horms@verge.net.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: tidyup simple-card example for CPU node

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

>From 2ca69d73bc05a55edb95689d436ce87974a3162e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 22 Dec 2017 05:29:03 +0000
Subject: [PATCH] ASoC: rcar: tidyup simple-card example for CPU node

commit a5702e1cb3c ("ASoC: rsnd: Drop unit-addresses without reg
properties") modifies simple-card multi CPU nodes.
But, naming of "cpu-x" breaks probing.
Let's add reg = <x>; instead of renaming node.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index b3c28bdcc268..5bed9a595772 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -197,12 +197,17 @@ Ex)
 	[MEM] -> [SRC2] -> [CTU03] -+
 
 	sound {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		compatible = "simple-scu-audio-card";
 		...
-		simple-audio-card,cpu-0 {
+		simple-audio-card,cpu@0 {
+			reg = <0>;
 			sound-dai = <&rcar_sound 0>;
 		};
-		simple-audio-card,cpu-1 {
+		simple-audio-card,cpu@1 {
+			reg = <1>;
 			sound-dai = <&rcar_sound 1>;
 		};
 		simple-audio-card,codec {
-- 
2.15.1
