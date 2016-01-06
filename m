From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: precedence error in
	rsnd_ssiu_init()" to the asoc tree
Date: Wed, 06 Jan 2016 18:12:27 +0000
Message-ID: <E1aGsZP-0007E2-HZ@debutante>
References: <20160106092855.GA23185@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A6B265308
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 19:13:48 +0100 (CET)
In-Reply-To: <20160106092855.GA23185@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: precedence error in rsnd_ssiu_init()

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

>From 8012c983dd0cea8f5be5a02ca75fd8d437227a10 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 6 Jan 2016 12:38:41 +0300
Subject: [PATCH] ASoC: rsnd: precedence error in rsnd_ssiu_init()

The bitwise OR has higher precedence than ?: so the val2 was always set
to 0x2.

Fixes: b4c83b171557 ('ASoC: rsnd: add Multi channel support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 3fe9e08e81a3..06d72828e5bc 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -73,7 +73,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		switch (multi_ssi_slaves) {
 		case 0x0206: /* SSI0/1/2/9 */
 			val2 = (1 << 4) | /* SSI0129 sync */
-				rsnd_rdai_is_clk_master(rdai) ? 0x2 : 0x1;
+				(rsnd_rdai_is_clk_master(rdai) ? 0x2 : 0x1);
 			/* fall through */
 		case 0x0006: /* SSI0/1/2 */
 			val1 = rsnd_rdai_is_clk_master(rdai) ?
-- 
2.7.0.rc3
