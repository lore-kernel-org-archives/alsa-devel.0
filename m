From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/9] ASoC: SOF: uapi: mirror firmware changes
Date: Mon,  3 Jun 2019 11:18:13 -0500
Message-ID: <20190603161821.7486-2-pierre-louis.bossart@linux.intel.com>
References: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 737B6F896CE
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 18:18:30 +0200 (CEST)
In-Reply-To: <20190603161821.7486-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We missed these two definitions for GDB support and component
notifications, they are defined for the SOF firmware. Since they are
not used by the kernel so far, we can still add them without any ABI
change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
