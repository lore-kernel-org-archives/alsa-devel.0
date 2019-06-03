From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Do not send cmd via SHIM register"
	to the asoc tree
Date: Mon,  3 Jun 2019 19:02:00 +0100 (BST)
Message-ID: <20190603180200.3D368440046@finisterre.sirena.org.uk>
References: <20190603162032.7626-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20CB9F80CC4
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:02:02 +0200 (CEST)
In-Reply-To: <20190603162032.7626-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Do not send cmd via SHIM register

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

>From 6fbbc18ead0f4f64a722f7e325046e5860d2c52b Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 3 Jun 2019 11:20:25 -0500
Subject: [PATCH] ASoC: SOF: Do not send cmd via SHIM register

We use shim registers only to notify the other
side that a message was sent. The actual information
for the message is transmitted via mailbox.

cmd information inside shim register is not used by
the DSP, so we remove it to avoid confusion.

Signed-off-by: Daniel Baluta <daniel.baluta@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/byt.c     | 5 +----
 sound/soc/sof/intel/cnl.c     | 4 +---
 sound/soc/sof/intel/hda-ipc.c | 4 +---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 9e4c07eb889b..8765eedfcf54 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -373,13 +373,10 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
 
 static int byt_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 {
-	u64 cmd = msg->header;
-
 	/* send the message */
 	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
 			  msg->msg_size);
-	snd_sof_dsp_write64(sdev, BYT_DSP_BAR, SHIM_IPCX,
-			    cmd | SHIM_BYT_IPCX_BUSY);
+	snd_sof_dsp_write64(sdev, BYT_DSP_BAR, SHIM_IPCX, SHIM_BYT_IPCX_BUSY);
 
 	return 0;
 }
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index e59d180da7e2..fd86269b5037 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -151,13 +151,11 @@ static void cnl_ipc_dsp_done(struct snd_sof_dev *sdev)
 static int cnl_ipc_send_msg(struct snd_sof_dev *sdev,
 			    struct snd_sof_ipc_msg *msg)
 {
-	u32 cmd = msg->header;
-
 	/* send the message */
 	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
 			  msg->msg_size);
 	snd_sof_dsp_write(sdev, HDA_DSP_BAR, CNL_DSP_REG_HIPCIDR,
-			  cmd | CNL_DSP_REG_HIPCIDR_BUSY);
+			  CNL_DSP_REG_HIPCIDR_BUSY);
 
 	return 0;
 }
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 51b285103394..728dd1e075a4 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -56,13 +56,11 @@ static void hda_dsp_ipc_dsp_done(struct snd_sof_dev *sdev)
 
 int hda_dsp_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 {
-	u32 cmd = msg->header;
-
 	/* send IPC message to DSP */
 	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
 			  msg->msg_size);
 	snd_sof_dsp_write(sdev, HDA_DSP_BAR, HDA_DSP_REG_HIPCI,
-			  cmd | HDA_DSP_REG_HIPCI_BUSY);
+			  HDA_DSP_REG_HIPCI_BUSY);
 
 	return 0;
 }
-- 
2.20.1
