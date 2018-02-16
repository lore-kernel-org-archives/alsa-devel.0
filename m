From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Add myself as sgtl5000
	maintainer" to the asoc tree
Date: Fri, 16 Feb 2018 15:21:30 +0000
Message-ID: <E1emhpK-0003Tr-3x@debutante>
References: <1518792313-12582-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E8D267E5E
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 16:21:32 +0100 (CET)
In-Reply-To: <1518792313-12582-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Add myself as sgtl5000 maintainer

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

>From aba62a9e9a4064c5ea9deb33b5b1392f263cad24 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Fri, 16 Feb 2018 12:45:13 -0200
Subject: [PATCH] MAINTAINERS: Add myself as sgtl5000 maintainer

I would like helping maintaining and reviewing/testing sgtl5000
related patches.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..4e283d131def 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9921,6 +9921,13 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
+NXP SGTL5000 DRIVER
+M:	Fabio Estevam <fabio.estevam@nxp.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/sgtl5000.txt
+F:	sound/soc/codecs/sgtl5000*
+
 NXP TDA998X DRM DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Supported
-- 
2.16.1
