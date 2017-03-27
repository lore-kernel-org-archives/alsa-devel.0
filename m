From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Don't print FW version
	repeatedly" to the asoc tree
Date: Mon, 27 Mar 2017 12:32:11 +0100
Message-ID: <E1csSsd-0000nF-Fr@debutante>
References: <20170327083958.18020-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ECF626583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 13:32:22 +0200 (CEST)
In-Reply-To: <20170327083958.18020-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Don't print FW version repeatedly

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 36d96039e710488b53256defed0fd291e0f1a34b Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 27 Mar 2017 10:39:58 +0200
Subject: [PATCH] ASoC: intel: Don't print FW version repeatedly

Intel SST driver spews an info message "FW Versoin xxxx" at each time
the device gets initialized.  Since it's triggered at each PM (or even
runtime PM), it appears so ofetn, and rather becomes annoying than
useful.

This patch suppresses the superfluous messages by checking the
currently loaded FW version with the previously loaded one.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 14c2d9d18180..20b01e02ed8f 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -236,7 +236,9 @@ static void process_fw_init(struct intel_sst_drv *sst_drv_ctx,
 		retval = init->result;
 		goto ret;
 	}
-	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
+	if (memcmp(&sst_drv_ctx->fw_version, &init->fw_version,
+		   sizeof(init->fw_version)))
+		dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
 			init->fw_version.type, init->fw_version.major,
 			init->fw_version.minor, init->fw_version.build);
 	dev_dbg(sst_drv_ctx->dev, "Build date %s Time %s\n",
-- 
2.11.0
