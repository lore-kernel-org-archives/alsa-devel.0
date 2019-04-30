From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 02/19] ASOC: SOF: ipc: add support for stricter
	ABI checks
Date: Tue, 30 Apr 2019 18:09:17 -0500
Message-ID: <20190430230934.4321-3-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E01DF8962C
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:09:57 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
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

Fail early if firmware is more recent than kernel and Kconfig is
selected.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index d00373ceca12..bf58d58e7379 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -762,6 +762,15 @@ int snd_sof_ipc_valid(struct snd_sof_dev *sdev)
 		return -EINVAL;
 	}
 
+	if (v->abi_version > SOF_ABI_VERSION) {
+		if (!IS_ENABLED(CONFIG_SND_SOC_SOF_STRICT_ABI_CHECKS)) {
+			dev_warn(sdev->dev, "warn: FW ABI is more recent than kernel\n");
+		} else {
+			dev_err(sdev->dev, "error: FW ABI is more recent than kernel\n");
+			return -EINVAL;
+		}
+	}
+
 	if (ready->debug.bits.build) {
 		dev_info(sdev->dev,
 			 "Firmware debug build %d on %s-%s - options:\n"
-- 
2.17.1
