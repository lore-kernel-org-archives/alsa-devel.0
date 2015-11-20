From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: tidyup vendor prefix from
	ak4613 to asahi-kasei" to the asoc tree
Date: Fri, 20 Nov 2015 18:20:23 +0000
Message-ID: <E1ZzqIJ-0003tT-7Y@debutante>
References: <87k2peipxz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04C5626664F
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:30 +0100 (CET)
In-Reply-To: <87k2peipxz.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: tidyup vendor prefix from ak4613 to asahi-kasei

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

>From 5547ba616b964de05ba48ec4d529ed1ac22a4326 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Nov 2015 04:22:14 +0000
Subject: [PATCH] ASoC: ak4613: tidyup vendor prefix from ak4613 to asahi-kasei

a3af0c65("ASoC: ak4613: add single-end optional property for IN/OUT pins")
added IN/OUT pin single-end optional property, but it used "ak4613" as
vendor prefix. This patch fixup to asahi-kasei.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ak4613.txt | 16 ++++++++--------
 sound/soc/codecs/ak4613.c                          |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
index 3cf63e7f8e77..1783f9ef0930 100644
--- a/Documentation/devicetree/bindings/sound/ak4613.txt
+++ b/Documentation/devicetree/bindings/sound/ak4613.txt
@@ -8,14 +8,14 @@ Required properties:
 - reg : The chip select number on the I2C bus
 
 Optional properties:
-- ak4613,in1-single-end	: Boolean. Indicate input / output pins are single-ended.
-- ak4613,in2-single-end	  rather than differential.
-- ak4613,out1-single-end
-- ak4613,out2-single-end
-- ak4613,out3-single-end
-- ak4613,out4-single-end
-- ak4613,out5-single-end
-- ak4613,out6-single-end
+- asahi-kasei,in1-single-end	: Boolean. Indicate input / output pins are single-ended.
+- asahi-kasei,in2-single-end	  rather than differential.
+- asahi-kasei,out1-single-end
+- asahi-kasei,out2-single-end
+- asahi-kasei,out3-single-end
+- asahi-kasei,out4-single-end
+- asahi-kasei,out5-single-end
+- asahi-kasei,out6-single-end
 
 Example:
 
diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 62c08a6395af..647f69de6baa 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -464,14 +464,14 @@ static void ak4613_parse_of(struct ak4613_priv *priv,
 
 	/* Input 1 - 2 */
 	for (i = 0; i < 2; i++) {
-		snprintf(prop, sizeof(prop), "ak4613,in%d-single-end", i + 1);
+		snprintf(prop, sizeof(prop), "asahi-kasei,in%d-single-end", i + 1);
 		if (!of_get_property(np, prop, NULL))
 			priv->ic |= 1 << i;
 	}
 
 	/* Output 1 - 6 */
 	for (i = 0; i < 6; i++) {
-		snprintf(prop, sizeof(prop), "ak4613,out%d-single-end", i + 1);
+		snprintf(prop, sizeof(prop), "asahi-kasei,out%d-single-end", i + 1);
 		if (!of_get_property(np, prop, NULL))
 			priv->oc |= 1 << i;
 	}
-- 
2.6.2
