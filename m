From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: rsnd: remove unnecessary static in rsnd_ssiu_probe()
Date: Mon, 17 Jul 2017 10:30:20 -0500
Message-ID: <20170717153020.GA19704@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Remove unnecessary static on local variable ops.
Such variable is initialized before being used,
on every execution path throughout the function.
The static has no benefit and, removing it reduces
the code size.

This issue was detected using Coccinelle and the following semantic patch:

@bad exists@
position p;
identifier x;
type T;
@@

static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@

-static
 T x@p;
 ... when != x
     when strict
?x = e;

In the following log you can see the difference in the code size. Also,
there is a significant difference in the bss segment. This log is the
output of the size command, before and after the code change:

before:
   text    data     bss     dec     hex filename
   3211     680      64    3955     f73 sound/soc/sh/rcar/ssiu.o

after:
   text    data     bss     dec     hex filename
   3207     592       0    3799     ed7 sound/soc/sh/rcar/ssiu.o

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index bed2c9c..4d94875 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -250,7 +250,7 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_ssiu *ssiu;
-	static struct rsnd_mod_ops *ops;
+	struct rsnd_mod_ops *ops;
 	int i, nr, ret;
 
 	/* same number to SSI */
-- 
2.5.0
