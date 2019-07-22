From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/21] ASoC: SOF: core: increase default IPC
	timeouts
Date: Mon, 22 Jul 2019 09:13:46 -0500
Message-ID: <20190722141402.7194-6-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E936AF80483
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:15 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Increase the default timeout values for boot (100ms to 2sec) and
IPC message sending (5ms to 500ms). The values should be overridden
with values from platform data.

There is no functional need to have such short timeouts as both boot
and IPC send errors are considered fatal errors. More relaxed timeouts
are convenient when running the driver on top of emulation such as QEMU.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 5beda47cdf9f..81f28f7ff1a0 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -17,8 +17,8 @@
 #include "ops.h"
 
 /* SOF defaults if not provided by the platform in ms */
-#define TIMEOUT_DEFAULT_IPC_MS  5
-#define TIMEOUT_DEFAULT_BOOT_MS 100
+#define TIMEOUT_DEFAULT_IPC_MS  500
+#define TIMEOUT_DEFAULT_BOOT_MS 2000
 
 /*
  * Generic object lookup APIs.
-- 
2.20.1
