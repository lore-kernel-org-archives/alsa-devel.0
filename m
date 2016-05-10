From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use prohibited number to PDMACHCRn.SRS" to the asoc tree
Date: Tue, 10 May 2016 19:49:16 +0100
Message-ID: <E1b0Cia-0007Gr-Tb@debutante>
References: <87d1oumzcr.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1oumzcr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Nguyen Viet Dung <nv-dung@jinso.co.jp>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>Nguyen Viet Dung <nv-dung@jinso.co.jp>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't use prohibited number to PDMACHCRn.SRS

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

>From ee057d2ee73259f455cfbb7a4db808fc6b6405dd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 May 2016 02:22:37 +0000
Subject: [PATCH] ASoC: rsnd: don't use prohibited number to PDMACHCRn.SRS

Current rsnd_dmapp_get_id() returns 0xFF as error code if system used
strange connection. It will be used as PDMACHCRn.SRS, but 0xFF is
prohibited number.
In order not to use prohibited number, this patch indicates error message
and returns 0x00 (same as SSI00) in error case.
Special thanks to Dung-san.

Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 7658e8fd7bdc..6bc93cbb3049 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -316,11 +316,15 @@ static u32 rsnd_dmapp_get_id(struct rsnd_dai_stream *io,
 		size = ARRAY_SIZE(gen2_id_table_cmd);
 	}
 
-	if (!entry)
-		return 0xFF;
+	if ((!entry) || (size <= id)) {
+		struct device *dev = rsnd_priv_to_dev(rsnd_io_to_priv(io));
 
-	if (size <= id)
-		return 0xFF;
+		dev_err(dev, "unknown connection (%s[%d])\n",
+			rsnd_mod_name(mod), rsnd_mod_id(mod));
+
+		/* use non-prohibited SRS number as error */
+		return 0x00; /* SSI00 */
+	}
 
 	return entry[id];
 }
-- 
2.8.1
