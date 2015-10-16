From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Announce for removing Gen1 SRU
	support" to the asoc tree
Date: Fri, 16 Oct 2015 17:41:11 +0100
Message-ID: <E1Zn847-000886-HL@debutante>
References: <87eggxn88u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73A00260470
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 18:41:19 +0200 (CEST)
In-Reply-To: <87eggxn88u.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: Announce for removing Gen1 SRU support

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

>From 4362495734d155e10174ace9066827780edaed0d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Oct 2015 08:56:07 +0000
Subject: [PATCH] ASoC: rsnd: Announce for removing Gen1 SRU support

Gen1 SRU support was created for preparation of Gen2 SRC support,
but no-one is using this feature (sampling rate convert) on Gen1.
BockW had used SRU before, but it was pass through mode.
This means it is same as SSI. And BockW "platform base" code was
removed from upstream code. It is now supported via DT, but it doesn't
use SRU. More detail, r8a7778.dtsi has "rcar_sound,src" entry, but
no-one is using this feature today. SRU probing has no relation to this
removing. This means there is no effect for DT compatibility, no issues
on upstream kernel.

Gen2 SRC was created from Gen1 SRU, these are similar but not same IP.
Keeping Gen1 SRU in current driver is a little bit difficult,
and no-one is using it today. Gen1 sound is still supported via SSI.
Gen1 SRU support will be removed in the next kernel version.
This patch announces it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index ca7a20f03c9b..1d379e825a9d 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -1036,8 +1036,10 @@ int rsnd_src_probe(struct platform_device *pdev,
 	int i, nr, ret;
 
 	ops = NULL;
-	if (rsnd_is_gen1(priv))
+	if (rsnd_is_gen1(priv)) {
 		ops = &rsnd_src_gen1_ops;
+		dev_warn(dev, "Gen1 support will be removed soon\n");
+	}
 	if (rsnd_is_gen2(priv))
 		ops = &rsnd_src_gen2_ops;
 	if (!ops) {
-- 
2.6.1
