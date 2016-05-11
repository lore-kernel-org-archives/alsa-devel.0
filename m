From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] rcar: src: skip disabled-SRC nodes
Date: Thu, 12 May 2016 01:36:40 +0300
Message-ID: <2350728.BUGJNqvVzR@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The current device tree representation of the R-Car Sample Rate Converters
(SRC) assumes that they are numbered consecutively, starting from 0. Alas,
this  is not  the case with the R8A7794 SoC where SRC0 isn't present.  In
order to keep the existing  device trees working, I'm suggesting to use a
disabled node for SRC0.  Teach the SRC probe  to just skip disabled nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'for-next' branch of Mark Brown's 'sound.git' repo.

sound/soc/sh/rcar/src.c |    4 ++++
 sound/soc/sh/rcar/src.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: sound/sound/soc/sh/rcar/src.c
===================================================================
--- sound.orig/sound/soc/sh/rcar/src.c
+++ sound/sound/soc/sh/rcar/src.c
@@ -572,6 +572,9 @@ int rsnd_src_probe(struct rsnd_priv *pri
 
 	i = 0;
 	for_each_child_of_node(node, np) {
+		if (!of_device_is_available(np))
+			goto skip;
+
 		src = rsnd_src_get(priv, i);
 
 		snprintf(name, RSND_SRC_NAME_SIZE, "%s.%d",
@@ -595,6 +598,7 @@ int rsnd_src_probe(struct rsnd_priv *pri
 		if (ret)
 			goto rsnd_src_probe_done;
 
+skip:
 		i++;
 	}
 
