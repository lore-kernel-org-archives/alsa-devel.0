From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/5] ASoC: SOF: ignore unrecoverable CTX_SAVE
	IPC errors at suspend
Date: Wed, 12 Jun 2019 11:57:04 -0500
Message-ID: <20190612165705.1858-5-pierre-louis.bossart@linux.intel.com>
References: <20190612165705.1858-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 859E7F896E0
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 18:57:14 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

As part of the suspend flow, a context save IPC message is
sent to the firmware before powering down the DSP. If errors
are met, the suspend flow is aborted with current code.

Change the behaviour such that if firmware returns -EBUSY or
-EAGAIN, return the error codes to PM core as before. The device
is left in active state in this case.

If other errors are reported, print a warning but do not block the
suspend flow. As per interface specification, no valid error can be
returned in this scenario. If the hardware has hit a fatal error and
is not able to respond successfully, best recovery method is to
proceed with suspend and power off the DSP.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pm.c b/sound/soc/sof/pm.c
index 8ef1d51025d8..b7843f02ef67 100644
--- a/sound/soc/sof/pm.c
+++ b/sound/soc/sof/pm.c
@@ -343,11 +343,20 @@ static int sof_suspend(struct device *dev, bool runtime_suspend)
 #endif
 	/* notify DSP of upcoming power down */
 	ret = sof_send_pm_ipc(sdev, SOF_IPC_PM_CTX_SAVE);
-	if (ret < 0) {
+	if (ret == -EBUSY || ret == -EAGAIN) {
+		/*
+		 * runtime PM has logic to handle -EBUSY/-EAGAIN so
+		 * pass these errors up
+		 */
 		dev_err(sdev->dev,
 			"error: ctx_save ipc error during suspend %d\n",
 			ret);
 		return ret;
+	} else if (ret < 0) {
+		/* FW in unexpected state, continue to power down */
+		dev_warn(sdev->dev,
+			 "ctx_save ipc error %d, proceeding with suspend\n",
+			 ret);
 	}
 
 	/* power down all DSP cores */
-- 
2.20.1
