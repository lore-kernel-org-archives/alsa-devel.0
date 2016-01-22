From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add debug message for
	rsnd_mod_call()" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:49 +0000
Message-ID: <E1aMgQ5-0004AZ-Gw@debutante>
References: <87mvrz4s2y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E389A26147E
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:53 +0100 (CET)
In-Reply-To: <87mvrz4s2y.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add debug message for rsnd_mod_call()

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

>From 4e880b2674a6d36d6c7b9741d88973e00a76922b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:55:57 +0000
Subject: [PATCH] ASoC: rsnd: add debug message for rsnd_mod_call()

rsnd_mod_call() tries to call each IP's relevant function. But it is
difficult to understand which function returned error.
This patch adds debug message for this purpose

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ca05a0a95a4d..691e22381280 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -337,6 +337,9 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		*status, call ? #func : "");				\
 	if (call)							\
 		ret = (mod)->ops->func(mod, io, param);			\
+	if (ret)							\
+		dev_dbg(dev, "%s[%d] : rsnd_mod_call error %d\n",	\
+			rsnd_mod_name(mod), rsnd_mod_id(mod), ret);	\
 	ret;								\
 })
 
-- 
2.7.0.rc3
