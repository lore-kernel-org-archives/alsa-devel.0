From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: rsnd: dma: Calculate PDMACHCRE with
	consider of BUSIF" to the asoc tree
Date: Mon,  3 Sep 2018 14:45:26 +0100 (BST)
Message-ID: <20180903134526.B158B11227AE@debutante.sirena.org.uk>
References: <87zhwzdpze.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E6F2678B0
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:45:27 +0200 (CEST)
In-Reply-To: <87zhwzdpze.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: rsnd: dma: Calculate PDMACHCRE with consider of BUSIF

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

>From 92c7d384ff7282738c70720f8670c9b65c90c7df Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 3 Sep 2018 07:08:00 +0000
Subject: [PATCH] ASoc: rsnd: dma: Calculate PDMACHCRE with consider of BUSIF

PDMACHCR setting for SSI only considers BUSIF0 so far.
But BUSIF1 ~ BUSIF7 also maybe used, in the future.

This patch updates table gen2_id_table_ssiu, to also consider
BUSIF number used by SSI.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[kuninori: adjust to upstreaming]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 73f743ea3d08..d3b1a4ae876a 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -298,16 +298,26 @@ static struct rsnd_mod_ops rsnd_dmaen_ops = {
  *		Audio DMAC peri peri
  */
 static const u8 gen2_id_table_ssiu[] = {
-	0x00, /* SSI00 */
-	0x04, /* SSI10 */
-	0x08, /* SSI20 */
-	0x0c, /* SSI3  */
-	0x0d, /* SSI4  */
-	0x0e, /* SSI5  */
-	0x0f, /* SSI6  */
-	0x10, /* SSI7  */
-	0x11, /* SSI8  */
-	0x12, /* SSI90 */
+	/* SSI00 ~ SSI07 */
+	0x00, 0x01, 0x02, 0x03, 0x39, 0x3a, 0x3b, 0x3c,
+	/* SSI10 ~ SSI17 */
+	0x04, 0x05, 0x06, 0x07, 0x3d, 0x3e, 0x3f, 0x40,
+	/* SSI20 ~ SSI27 */
+	0x08, 0x09, 0x0a, 0x0b, 0x41, 0x42, 0x43, 0x44,
+	/* SSI30 ~ SSI37 */
+	0x0c, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b,
+	/* SSI40 ~ SSI47 */
+	0x0d, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51, 0x52,
+	/* SSI5 */
+	0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* SSI6 */
+	0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* SSI7 */
+	0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* SSI8 */
+	0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* SSI90 ~ SSI97 */
+	0x12, 0x13, 0x14, 0x15, 0x53, 0x54, 0x55, 0x56,
 };
 static const u8 gen2_id_table_scu[] = {
 	0x2d, /* SCU_SRCI0 */
@@ -333,18 +343,23 @@ static u32 rsnd_dmapp_get_id(struct rsnd_dai_stream *io,
 	struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 	struct rsnd_mod *dvc = rsnd_io_to_mod_dvc(io);
 	const u8 *entry = NULL;
-	int id = rsnd_mod_id(mod);
+	int id = 255;
 	int size = 0;
 
 	if (mod == ssi) {
+		int busif = rsnd_ssi_get_busif(io);
+
 		entry = gen2_id_table_ssiu;
 		size = ARRAY_SIZE(gen2_id_table_ssiu);
+		id = (rsnd_mod_id(mod) * 8) + busif;
 	} else if (mod == src) {
 		entry = gen2_id_table_scu;
 		size = ARRAY_SIZE(gen2_id_table_scu);
+		id = rsnd_mod_id(mod);
 	} else if (mod == dvc) {
 		entry = gen2_id_table_cmd;
 		size = ARRAY_SIZE(gen2_id_table_cmd);
+		id = rsnd_mod_id(mod);
 	}
 
 	if ((!entry) || (size <= id)) {
-- 
2.19.0.rc1
