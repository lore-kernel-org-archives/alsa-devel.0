From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: skip disabled-SSI nodes" to the
	asoc tree
Date: Tue,  3 Oct 2017 17:53:46 +0100 (BST)
Message-ID: <20171003165346.7C890440053@finisterre.ee.mobilebroadband>
References: <87efqmm2hh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 488C52668F0
 for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2017 18:53:49 +0200 (CEST)
In-Reply-To: <87efqmm2hh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: skip disabled-SSI nodes

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

>From 9e9e95df06433b4f89cfeef0003af091ee0ebc86 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Oct 2017 07:37:32 +0000
Subject: [PATCH] ASoC: rcar: skip disabled-SSI nodes

The current device tree representation of the R-Car SSI assumes that they
are numbered consecutively, starting from 0. Alas, this is not the case
with the R8A77995 (D3) SoC which SSI1/SSI2 aren't present. In order to
keep the existing device trees working, I'm suggesting to use a disabled
node for SSI0/SSI1. Teach the SSI probe to just skip disabled nodes.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index fffc07e72627..03c2a1f02643 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1112,6 +1112,9 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 
 	i = 0;
 	for_each_child_of_node(node, np) {
+		if (!of_device_is_available(np))
+			goto skip;
+
 		ssi = rsnd_ssi_get(priv, i);
 
 		snprintf(name, RSND_SSI_NAME_SIZE, "%s.%d",
@@ -1148,7 +1151,7 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
 			of_node_put(np);
 			goto rsnd_ssi_probe_done;
 		}
-
+skip:
 		i++;
 	}
 
-- 
2.14.1
