From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: trace: remove code duplication in
	sof_wait_trace_avail()" to the asoc tree
Date: Tue, 28 May 2019 16:06:57 +0100 (BST)
Message-ID: <20190528150657.5B0FC440049@finisterre.sirena.org.uk>
References: <20190524192309.6359-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3DD7DF8970A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:06:59 +0200 (CEST)
In-Reply-To: <20190524192309.6359-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: trace: remove code duplication in sof_wait_trace_avail()

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

>From f627b0524ccf993b646bd56f9bdacc973c8c39cc Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Fri, 24 May 2019 14:23:05 -0500
Subject: [PATCH] ASoC: SOF: trace: remove code duplication in
 sof_wait_trace_avail()

Move duplicated code in sof_wait_trace_avail() to a helper function.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/trace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index d588e4b70fad..a2d89d295f0f 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -13,10 +13,9 @@
 #include "sof-priv.h"
 #include "ops.h"
 
-static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
-				   loff_t pos, size_t buffer_size)
+static size_t sof_trace_avail(struct snd_sof_dev *sdev,
+			      loff_t pos, size_t buffer_size)
 {
-	wait_queue_entry_t wait;
 	loff_t host_offset = READ_ONCE(sdev->host_offset);
 
 	/*
@@ -31,6 +30,19 @@ static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
 	if (host_offset > pos)
 		return host_offset - pos;
 
+	return 0;
+}
+
+static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
+				   loff_t pos, size_t buffer_size)
+{
+	wait_queue_entry_t wait;
+	size_t ret = sof_trace_avail(sdev, pos, buffer_size);
+
+	/* data immediately available */
+	if (ret)
+		return ret;
+
 	/* wait for available trace data from FW */
 	init_waitqueue_entry(&wait, current);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -42,12 +54,7 @@ static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
 	}
 	remove_wait_queue(&sdev->trace_sleep, &wait);
 
-	/* return bytes available for copy */
-	host_offset = READ_ONCE(sdev->host_offset);
-	if (host_offset < pos)
-		return buffer_size - pos;
-
-	return host_offset - pos;
+	return sof_trace_avail(sdev, pos, buffer_size);
 }
 
 static ssize_t sof_dfsentry_trace_read(struct file *file, char __user *buffer,
-- 
2.20.1
