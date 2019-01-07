From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Baytrail: remove unneeded
	variable" to the asoc tree
Date: Mon,  7 Jan 2019 12:31:48 +0000 (GMT)
Message-ID: <20190107123148.4F4401127490@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F3418267D0B
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:31:48 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Baytrail: remove unneeded variable

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 060d35be2dfa9202d37f967fd20f133c530505d2 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sun, 16 Dec 2018 16:49:06 -0600
Subject: [PATCH] ASoC: Intel: Baytrail: remove unneeded variable

Detected with Coccinelle

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 260447da32b8..2cd8f9668b50 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -278,7 +278,6 @@ static int sst_byt_process_notification(struct sst_byt *byt,
 	struct sst_byt_stream *stream;
 	u64 header;
 	u8 msg_id, stream_id;
-	int handled = 1;
 
 	header = sst_dsp_shim_read64_unlocked(sst, SST_IPCD);
 	msg_id = sst_byt_header_msg_id(header);
@@ -298,7 +297,7 @@ static int sst_byt_process_notification(struct sst_byt *byt,
 		break;
 	}
 
-	return handled;
+	return 1;
 }
 
 static irqreturn_t sst_byt_irq_thread(int irq, void *context)
-- 
2.20.1
