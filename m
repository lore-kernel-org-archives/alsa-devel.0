From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't assume node full path name
	for HDMI probing" to the asoc tree
Date: Mon, 16 Apr 2018 12:40:00 +0100
Message-ID: <E1f82UK-0007Yi-Go@debutante>
References: <87r2nmfqbu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E982E2673ED
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 13:40:02 +0200 (CEST)
In-Reply-To: <87r2nmfqbu.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Mark Brown <broonie@kernel.org>, Nguyen Viet Dung <dung.nguyen.aj@renesas.com>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't assume node full path name for HDMI probing

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

>From 9ff7386656f5b7d9524ab7bdf69d508d14800d42 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Apr 2018 02:10:45 +0000
Subject: [PATCH] ASoC: rsnd: don't assume node full path name for HDMI probing

Current ssi.c is assuming below 2 things to probing HDMI node.
1) remote node is including "hdmi0" or "hdmi1" in node name
2) remote_ep->full_name is including full path name

But, these assumptions are broken by below
1) Node names should not use numerical suffixes
 commit 6b5ac2f1cb11 ("arm64: dts: renesas: r8a7795: Drop bogus HDMI
                       node names suffixes")
2) node full_name no longer include full path name
 commit a7e4cfb0a7ca ("of/fdt: only store the device node basename
                       in full_name")

Because of these reasons, ssi.c can't probe HDMI on current kernel.
This patch probes HDMI0/1 by using its address.
Note is that we need to keep updating for this address for future
generation chip.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 333b802681ad..31ffe3f0e163 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1004,19 +1004,26 @@ static void __rsnd_ssi_parse_hdmi_connection(struct rsnd_priv *priv,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
 	struct rsnd_ssi *ssi;
+	struct device_node *remote_node = of_graph_get_port_parent(remote_ep);
+
+	/* support Gen3 only */
+	if (!rsnd_is_gen3(priv))
+		return;
 
 	if (!mod)
 		return;
 
 	ssi  = rsnd_mod_to_ssi(mod);
 
-	if (strstr(remote_ep->full_name, "hdmi0")) {
+	/* HDMI0 */
+	if (strstr(remote_node->full_name, "hdmi@fead0000")) {
 		rsnd_flags_set(ssi, RSND_SSI_HDMI0);
 		dev_dbg(dev, "%s[%d] connected to HDMI0\n",
 			 rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
 
-	if (strstr(remote_ep->full_name, "hdmi1")) {
+	/* HDMI1 */
+	if (strstr(remote_node->full_name, "hdmi@feae0000")) {
 		rsnd_flags_set(ssi, RSND_SSI_HDMI1);
 		dev_dbg(dev, "%s[%d] connected to HDMI1\n",
 			rsnd_mod_name(mod), rsnd_mod_id(mod));
-- 
2.17.0
