From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/6] ASoC: SOF: Remove call to
	snd_sof_dsp_mailbox_init
Date: Wed,  7 Aug 2019 10:01:58 -0500
Message-ID: <20190807150203.26359-2-pierre-louis.bossart@linux.intel.com>
References: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB0B2F800E4
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 17:02:28 +0200 (CEST)
In-Reply-To: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This is reserved for some historical reason, we didn't enable memory
windows for byt/bdw at the beginning, to make it compatible, we get
those mailbox offsets from fw_ready struct firstly, and then update them
if they existed in the following memory windows, to make sure the
mailbox still can be used if no memory windows are created.

With this change all platforms have the same implementation for
xxx_fw_ready function so that we can refactor it in a common file.

Suggested-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/bdw.c | 5 -----
 sound/soc/sof/intel/byt.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 4bb9636da990..94be024a99eb 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -455,11 +455,6 @@ static int bdw_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
 	sof_block_read(sdev, sdev->mmio_bar, offset, fw_ready,
 		       sizeof(*fw_ready));
 
-	snd_sof_dsp_mailbox_init(sdev, fw_ready->dspbox_offset,
-				 fw_ready->dspbox_size,
-				 fw_ready->hostbox_offset,
-				 fw_ready->hostbox_size);
-
 	/* make sure ABI version is compatible */
 	ret = snd_sof_ipc_valid(sdev);
 	if (ret < 0)
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 000d576f6a8d..cb8f02ee09f2 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -237,11 +237,6 @@ static int byt_fw_ready(struct snd_sof_dev *sdev, u32 msg_id)
 	sof_block_read(sdev, sdev->mmio_bar, offset, fw_ready,
 		       sizeof(*fw_ready));
 
-	snd_sof_dsp_mailbox_init(sdev, fw_ready->dspbox_offset,
-				 fw_ready->dspbox_size,
-				 fw_ready->hostbox_offset,
-				 fw_ready->hostbox_size);
-
 	/* make sure ABI version is compatible */
 	ret = snd_sof_ipc_valid(sdev);
 	if (ret < 0)
-- 
2.20.1
