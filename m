From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: dma: remove unnecessary "volatile"" to the asoc tree
Date: Thu, 16 Mar 2017 14:11:17 +0000
Message-ID: <E1coW7Z-0002fF-KU@debutante>
References: <87a88l3lcw.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87a88l3lcw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: dma: remove unnecessary "volatile"

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

>From 9986943ef5d61a9bea3c86000d91d3b789f0060e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 Mar 2017 04:22:09 +0000
Subject: [PATCH] ASoC: rcar: dma: remove unnecessary "volatile"

commit 2a3af642eb20("ASoC: rcar: clear DE bit only in PDMACHCR...")
added rsnd_dmapp_bset(), but it used copy-paste. Thus, it had
unnecessary "volatile", and had below warning on x86.
This patch fix it.

   sound/soc/sh/rcar/dma.c: In function 'rsnd_dmapp_bset':
>> sound/soc/sh/rcar/dma.c:463:21: warning: passing argument 1 of \
   'ioread32' discards 'volatile' qualifier from pointer target \
   type [-Wdiscarded-qualifiers]
     u32 val = ioread32(addr);
                        ^~~~
   In file included from arch/x86/include/asm/io.h:203:0,
                    from arch/x86/include/asm/realmode.h:5,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:12,
                    from include/linux/smp.h:59,
                    from include/linux/topology.h:33,
                    from include/linux/gfp.h:8,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/of.h:21,
                    from include/linux/of_dma.h:16,
                    from sound/soc/sh/rcar/dma.c:12:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' \
   but argument is of type 'volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index c2e199b4fcf4..241cb3b08a07 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -459,7 +459,7 @@ static void rsnd_dmapp_bset(struct rsnd_dma *dma, u32 data, u32 mask, u32 reg)
 	struct rsnd_mod *mod = rsnd_mod_get(dma);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
-	volatile void __iomem *addr = rsnd_dmapp_addr(dmac, dma, reg);
+	void __iomem *addr = rsnd_dmapp_addr(dmac, dma, reg);
 	u32 val = ioread32(addr);
 
 	val &= ~mask;
-- 
2.11.0
