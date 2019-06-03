From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: ipc: Introduce
	SOF_IPC_GLB_TEST_MSG IPC command" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:53 +0100 (BST)
Message-ID: <20190603180153.4A6ED440049@finisterre.sirena.org.uk>
References: <20190603161821.7486-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C094BF896DD
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:01:55 +0200 (CEST)
In-Reply-To: <20190603161821.7486-8-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: ipc: Introduce SOF_IPC_GLB_TEST_MSG IPC command

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

>From 53b22d25ec36cebc2f5888a0bd5fba84b05f3dee Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Mon, 3 Jun 2019 11:18:19 -0500
Subject: [PATCH] ASoC: SOF: ipc: Introduce SOF_IPC_GLB_TEST_MSG IPC command

Add a new class of IPC command along with the first
test type, IPC_FLOOD, which will be used for flooding the DSP
with IPCs.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/header.h | 6 +++++-
 sound/soc/sof/ipc.c        | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/header.h b/include/sound/sof/header.h
index ab5862d80afe..12867bbd4372 100644
--- a/include/sound/sof/header.h
+++ b/include/sound/sof/header.h
@@ -49,6 +49,7 @@
 #define SOF_IPC_GLB_DAI_MSG			SOF_GLB_TYPE(0x8U)
 #define SOF_IPC_GLB_TRACE_MSG			SOF_GLB_TYPE(0x9U)
 #define SOF_IPC_GLB_GDB_DEBUG                   SOF_GLB_TYPE(0xAU)
+#define SOF_IPC_GLB_TEST_MSG			SOF_GLB_TYPE(0xBU)
 
 /*
  * DSP Command Message Types
@@ -99,11 +100,14 @@
 #define SOF_IPC_STREAM_VORBIS_PARAMS		SOF_CMD_TYPE(0x010)
 #define SOF_IPC_STREAM_VORBIS_FREE		SOF_CMD_TYPE(0x011)
 
-/* trace and debug */
+/* trace */
 #define SOF_IPC_TRACE_DMA_PARAMS		SOF_CMD_TYPE(0x001)
 #define SOF_IPC_TRACE_DMA_POSITION		SOF_CMD_TYPE(0x002)
 #define SOF_IPC_TRACE_DMA_PARAMS_EXT		SOF_CMD_TYPE(0x003)
 
+/* debug */
+#define SOF_IPC_TEST_IPC_FLOOD                  SOF_CMD_TYPE(0x001)
+
 /* Get message component id */
 #define SOF_IPC_MESSAGE_ID(x)			((x) & 0xffff)
 
diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 2414640a32d1..558b596e2133 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -175,6 +175,15 @@ static void ipc_log_header(struct device *dev, u8 *text, u32 cmd)
 		break;
 	case SOF_IPC_GLB_TRACE_MSG:
 		str = "GLB_TRACE_MSG"; break;
+	case SOF_IPC_GLB_TEST_MSG:
+		str = "GLB_TEST_MSG";
+		switch (type) {
+		case SOF_IPC_TEST_IPC_FLOOD:
+			str2 = "IPC_FLOOD"; break;
+		default:
+			str2 = "unknown type"; break;
+		}
+		break;
 	default:
 		str = "unknown GLB command"; break;
 	}
-- 
2.20.1
