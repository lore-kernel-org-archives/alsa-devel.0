From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "of-graph: export symbol of_phandle_iterator_init/next" to the asoc tree
Date: Wed, 17 May 2017 10:53:26 +0100
Message-ID: <E1dAve2-000758-DN@debutante>
References: <87poh2kufc.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87poh2kufc.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   of-graph: export symbol of_phandle_iterator_init/next

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

>From 00bab23f72100a5fd8a3030f81d0af07a859ed17 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Thu, 20 Apr 2017 01:31:16 +0000
Subject: [PATCH] of-graph: export symbol of_phandle_iterator_init/next

of_for_each_phandle() uses of_phandle_iterator_init/next
but it isn't exported. So kernel module complile will say

ERROR: "of_phandle_iterator_init" [xxx.ko] undefined!
ERROR: "of_phandle_iterator_next" [xxx.ko] undefined!

This patch solved this issue

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 28d5f53bc631..5db6aa1688e9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1601,6 +1601,7 @@ int of_phandle_iterator_init(struct of_phandle_iterator *it,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(of_phandle_iterator_init);
 
 int of_phandle_iterator_next(struct of_phandle_iterator *it)
 {
@@ -1670,6 +1671,7 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(of_phandle_iterator_next);
 
 int of_phandle_iterator_args(struct of_phandle_iterator *it,
 			     uint32_t *args,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
