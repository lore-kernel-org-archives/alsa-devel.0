From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/5] ASOC: SOF: ipc: prevent logging trace
	messages
Date: Wed, 12 Jun 2019 11:57:01 -0500
Message-ID: <20190612165705.1858-2-pierre-louis.bossart@linux.intel.com>
References: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87868F806F5
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:57:12 +0200 (CEST)
In-Reply-To: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Dragos Tarcatu <dragos_tarcatu@mentor.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Dragos Tarcatu <dragos_tarcatu@mentor.com>

If the firmware is set for verbose tracing, the kernel log is flooded
with ipc rx/ipc rx done messages. Prevent logging those unless the
verbose IPC debugging config option is set.

Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 558b596e2133..f3eb46bc808b 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -196,7 +196,8 @@ static void ipc_log_header(struct device *dev, u8 *text, u32 cmd)
 #else
 static inline void ipc_log_header(struct device *dev, u8 *text, u32 cmd)
 {
-	dev_dbg(dev, "%s: 0x%x\n", text, cmd);
+	if ((cmd & SOF_GLB_TYPE_MASK) != SOF_IPC_GLB_TRACE_MSG)
+		dev_dbg(dev, "%s: 0x%x\n", text, cmd);
 }
 #endif
 
-- 
2.20.1
