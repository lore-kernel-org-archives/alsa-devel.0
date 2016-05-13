From: Mark Brown <broonie@kernel.org>
Subject: Applied "rcar: src: skip disabled-SRC nodes" to the asoc tree
Date: Fri, 13 May 2016 08:59:03 +0100
Message-ID: <E1b17zz-0004io-IY@debutante>
References: <2350728.BUGJNqvVzR@wasted.cogentembedded.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2350728.BUGJNqvVzR@wasted.cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   rcar: src: skip disabled-SRC nodes

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

>From de1965159a34951a86267d13db4f2a67234139d3 Mon Sep 17 00:00:00 2001
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 12 May 2016 01:36:40 +0300
Subject: [PATCH] rcar: src: skip disabled-SRC nodes

The current device tree representation of the R-Car Sample Rate Converters
(SRC) assumes that they are numbered consecutively, starting from 0. Alas,
this  is not  the case with the R8A7794 SoC where SRC0 isn't present.  In
order to keep the existing  device trees working, I'm suggesting to use a
disabled node for SRC0.  Teach the SRC probe  to just skip disabled nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 15d6ffe8be74..e39f916d0f2f 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -572,6 +572,9 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 
 	i = 0;
 	for_each_child_of_node(node, np) {
+		if (!of_device_is_available(np))
+			goto skip;
+
 		src = rsnd_src_get(priv, i);
 
 		snprintf(name, RSND_SRC_NAME_SIZE, "%s.%d",
@@ -595,6 +598,7 @@ int rsnd_src_probe(struct rsnd_priv *priv)
 		if (ret)
 			goto rsnd_src_probe_done;
 
+skip:
 		i++;
 	}
 
-- 
2.8.1
