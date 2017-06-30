From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: make arrays path and cmd_case
	static const" to the asoc tree
Date: Fri, 30 Jun 2017 12:58:46 +0100
Message-ID: <E1dQuZS-0007wL-Uo@finisterre>
References: <20170630095059.8847-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96EC22674F0
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:06 +0200 (CEST)
In-Reply-To: <20170630095059.8847-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: make arrays path and cmd_case static const

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

>From 8288591368fcb470024348a9b846f7b3f791be44 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 30 Jun 2017 10:50:59 +0100
Subject: [PATCH] ASoC: rsnd: make arrays path and cmd_case static const

Don't populate the arrays path and cmd_case on the stack but make
them static const.  Makes the object code smaller:

Before:
   text    data     bss     dec     hex filename
   2673     624       0    3297     ce1 sound/soc/sh/rcar/cmd.o

After:
   text    data     bss     dec     hex filename
   2398     768       0    3166     c5e sound/soc/sh/rcar/cmd.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 9a136d86e2a9..f1d4fb566892 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -31,7 +31,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 	struct rsnd_mod *mix = rsnd_io_to_mod_mix(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	u32 data;
-	u32 path[] = {
+	static const u32 path[] = {
 		[1] = 1 << 0,
 		[5] = 1 << 8,
 		[6] = 1 << 12,
@@ -71,7 +71,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 	} else {
 		struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 
-		u8 cmd_case[] = {
+		static const u8 cmd_case[] = {
 			[0] = 0x3,
 			[1] = 0x3,
 			[2] = 0x4,
-- 
2.13.2
