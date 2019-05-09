From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/6] ASoC: SOF: fix race in FW boot timeout
	handling
Date: Thu,  9 May 2019 15:10:23 -0500
Message-ID: <20190509201027.3906-3-pierre-louis.bossart@linux.intel.com>
References: <20190509201027.3906-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C4EAF89682
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 22:10:38 +0200 (CEST)
In-Reply-To: <20190509201027.3906-1-pierre-louis.bossart@linux.intel.com>
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

A race condition exists in handling firmware boot timeout.
If FW sends FW_READY just after boot timeout has expired in
driver, a kernel exception will result as FW_READY handler
will be run while the state is still being cleaned up in
snd_sof_run_firmware(). Avoid the race by setting
boot_complete also in the error case.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 81c7452aae17..628fae552442 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -372,6 +372,8 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 				 msecs_to_jiffies(sdev->boot_timeout));
 	if (ret == 0) {
 		dev_err(sdev->dev, "error: firmware boot failure\n");
+		/* after this point FW_READY msg should be ignored */
+		sdev->boot_complete = true;
 		snd_sof_dsp_dbg_dump(sdev, SOF_DBG_REGS | SOF_DBG_MBOX |
 			SOF_DBG_TEXT | SOF_DBG_PCI);
 		return -EIO;
-- 
2.17.1
