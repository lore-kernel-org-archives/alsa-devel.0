From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/6] ASoC: Intel: add fw name to common dsp
	context
Date: Thu,  5 Nov 2015 21:34:14 +0530
Message-ID: <1446739455-22332-6-git-send-email-vinod.koul@intel.com>
References: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AA5112664C3
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 17:01:21 +0100 (CET)
In-Reply-To: <1446739455-22332-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

In order to pass the fw name to IPC driver for loading fw, we
need to add a memeber to store the fw name

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 2151652d37b7..4452cda28874 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -308,6 +308,8 @@ struct sst_dsp {
 
 	/* SKL data */
 
+	const char *fw_name;
+
 	/* To allocate CL dma buffers */
 	struct skl_dsp_loader_ops dsp_ops;
 	struct skl_dsp_fw_ops fw_ops;
-- 
1.9.1
