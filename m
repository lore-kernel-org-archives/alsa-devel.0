From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: SSI/SSIU use
	rsnd_get_slot_extend() to check TDM" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:26 +0000
Message-ID: <E1a9twU-000652-Dc@debutante>
References: <877fkdiy48.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47D0526656B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:31 +0100 (CET)
In-Reply-To: <877fkdiy48.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: SSI/SSIU use rsnd_get_slot_extend() to check TDM

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

>From 49ee73b441f5734c3da254c60e134f343b89911a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Dec 2015 02:56:50 +0000
Subject: [PATCH] ASoC: rsnd: SSI/SSIU use rsnd_get_slot_extend() to check TDM

Current SSI/SSIU are using rsnd_get_slot_runtime() to check TDM,
but using rsnd_get_slot_extend() is more sane.
This patch fix it up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c  | 2 +-
 sound/soc/sh/rcar/ssiu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 79c3211a1e7f..7481bc3e0dff 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -267,7 +267,7 @@ static int rsnd_ssi_config_init(struct rsnd_ssi *ssi,
 	u32 wsr;
 	int is_tdm;
 
-	is_tdm = (rsnd_get_slot_runtime(io) >= 6) ? 1 : 0;
+	is_tdm = (rsnd_get_slot_extend(io) >= 6) ? 1 : 0;
 
 	/*
 	 * always use 32bit system word.
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 326550114299..c7f89beff44f 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -78,7 +78,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	if (rsnd_get_slot_runtime(io) >= 6) {
+	if (rsnd_get_slot_extend(io) >= 6) {
 		/*
 		 * TDM Extend Mode
 		 * see
-- 
2.6.2
