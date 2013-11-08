From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: rcar: some dubious one-bit signed bitfields
Date: Fri, 8 Nov 2013 12:46:53 +0300
Message-ID: <20131108094653.GF27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Because these are signed they can either be 0 or -1 instead of 0 and 1
as intended.  It doesn't cause a problem from what I can see, but it's
dangerous and Sparse complains:

	sound/soc/sh/rcar/rsnd.h:177:25:
		error: dubious one-bit signed bitfield

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 9e463e5..b5ac3a2 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -174,11 +174,11 @@ struct rsnd_dai {
 	struct rsnd_dai_stream playback;
 	struct rsnd_dai_stream capture;
 
-	int clk_master:1;
-	int bit_clk_inv:1;
-	int frm_clk_inv:1;
-	int sys_delay:1;
-	int data_alignment:1;
+	unsigned int clk_master:1;
+	unsigned int bit_clk_inv:1;
+	unsigned int frm_clk_inv:1;
+	unsigned int sys_delay:1;
+	unsigned int data_alignment:1;
 };
 
 #define rsnd_dai_nr(priv) ((priv)->dai_nr)
