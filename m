From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Update Intel ASoC drivers
	maintainers" to the asoc tree
Date: Wed, 31 Jul 2019 12:29:51 +0100 (BST)
Message-ID: <20190731112952.075492742D4F@ypsilon.sirena.org.uk>
References: <20190726181517.27655-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 922C9F80507
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 13:29:59 +0200 (CEST)
In-Reply-To: <20190726181517.27655-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, tiwai@suse.com, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Update Intel ASoC drivers maintainers

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

>From 6963d00bb6e42e91882d2eb36639701aca9fe032 Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Fri, 26 Jul 2019 20:15:17 +0200
Subject: [PATCH] MAINTAINERS: Update Intel ASoC drivers maintainers

Adding myself to Intel ASoC drivers maintainers list.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190726181517.27655-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 11db05b56744..92829ca37459 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7861,6 +7861,7 @@ S:	Maintained
 F:	drivers/video/fbdev/i810/
 
 INTEL ASoC DRIVERS
+M:	Cezary Rojewski <cezary.rojewski@intel.com>
 M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Jie Yang <yang.jie@linux.intel.com>
-- 
2.20.1
