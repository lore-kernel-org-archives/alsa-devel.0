From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda: Fix implicit definition of
	pci_iomap() on SH" to the asoc tree
Date: Thu, 13 Sep 2018 12:32:47 +0100 (BST)
Message-ID: <20180913113247.296021121CA5@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 077582677BB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 13:32:48 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda: Fix implicit definition of pci_iomap() on SH

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

>From d9b84a15892c02334ac8a5c28865ae54168d9b22 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Sep 2018 12:31:32 +0100
Subject: [PATCH] ALSA: hda: Fix implicit definition of pci_iomap() on SH

Include asm/io.h directly so we've got a definition of pci_iomap(), the
current set of includes do this implicitly on most architectures but not
on SH.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a585d0ec6d77..6ea04f889809 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <asm/io.h>
 #include <sound/core.h>
 #include <sound/hda_codec.h>
 #include "hda_local.h"
-- 
2.19.0.rc2
