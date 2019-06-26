From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing pin sharing with
	SSI9" to the asoc tree
Date: Wed, 26 Jun 2019 12:32:43 +0100 (BST)
Message-ID: <20190626113243.EACA6440049@finisterre.sirena.org.uk>
References: <875zotyup5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFB5CF896B7
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 13:32:45 +0200 (CEST)
In-Reply-To: <875zotyup5.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Hien Dang <hien.dang.eb@renesas.com>, Mark Brown <broonie@kernel.org>, Chaoliang Qin <chaoliang.qin.jg@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add missing pin sharing with SSI9

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 526a6d45b013d45fdddd420860c69fb29fed3d62 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Jun 2019 11:00:05 +0900
Subject: [PATCH] ASoC: rsnd: add missing pin sharing with SSI9

When SSI9 is sharing pin with SSI0, we need to care about it,
but is missing. This patch fixup it.

Reported-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Chaoliang Qin <chaoliang.qin.jg@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 1 +
 sound/soc/sh/rcar/ssi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index e821ccc70f47..fce4e050a9b7 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -87,6 +87,7 @@ static u32 rsnd_adg_ssi_ws_timing_gen2(struct rsnd_dai_stream *io)
 		switch (id) {
 		case 1:
 		case 2:
+		case 9:
 			ws = 0;
 			break;
 		case 4:
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 44bda210256e..f6a7466622ea 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -740,6 +740,7 @@ static void rsnd_ssi_parent_attach(struct rsnd_mod *mod,
 	switch (rsnd_mod_id(mod)) {
 	case 1:
 	case 2:
+	case 9:
 		rsnd_dai_connect(rsnd_ssi_mod_get(priv, 0), io, RSND_MOD_SSIP);
 		break;
 	case 4:
-- 
2.20.1
