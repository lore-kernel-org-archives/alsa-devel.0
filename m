From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: uapi: mirror firmware changes" to
	the asoc tree
Date: Mon,  3 Jun 2019 19:02:06 +0100 (BST)
Message-ID: <20190603180206.CC1E1440049@finisterre.sirena.org.uk>
References: <20190603161821.7486-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10B83F8973F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:02:07 +0200 (CEST)
In-Reply-To: <20190603161821.7486-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: uapi: mirror firmware changes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 59be197354496b87869792bfa15477e8798462da Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 3 Jun 2019 11:18:13 -0500
Subject: [PATCH] ASoC: SOF: uapi: mirror firmware changes

We missed these two definitions for GDB support and component
notifications, they are defined for the SOF firmware. Since they are
not used by the kernel so far, we can still add them without any ABI
change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/header.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/sof/header.h b/include/sound/sof/header.h
index ccb6a004b37b..0aeb2c8ad6fd 100644
--- a/include/sound/sof/header.h
+++ b/include/sound/sof/header.h
@@ -48,6 +48,7 @@
 #define SOF_IPC_FW_READY			SOF_GLB_TYPE(0x7U)
 #define SOF_IPC_GLB_DAI_MSG			SOF_GLB_TYPE(0x8U)
 #define SOF_IPC_GLB_TRACE_MSG			SOF_GLB_TYPE(0x9U)
+#define SOF_IPC_GLB_GDB_DEBUG                   SOF_GLB_TYPE(0xAU)
 
 /*
  * DSP Command Message Types
@@ -78,6 +79,7 @@
 #define SOF_IPC_COMP_GET_VALUE			SOF_CMD_TYPE(0x002)
 #define SOF_IPC_COMP_SET_DATA			SOF_CMD_TYPE(0x003)
 #define SOF_IPC_COMP_GET_DATA			SOF_CMD_TYPE(0x004)
+#define SOF_IPC_COMP_NOTIFICATION		SOF_CMD_TYPE(0x005)
 
 /* DAI messages */
 #define SOF_IPC_DAI_CONFIG			SOF_CMD_TYPE(0x001)
-- 
2.20.1
