From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ASoC: intel: Don't print FW version
	repeatedly
Date: Mon, 27 Mar 2017 14:17:00 +0200
Message-ID: <20170327121700.21502-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E39E26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 14:17:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Intel SST driver spews an info message "FW Versoin xxxx" at each time
the device gets initialized.  Since it's triggered at each PM (or even
runtime PM), it appears too frequently, which is rather annoying.
Moreover, the firmware in the driver is cached, thus it's assured to
be always the same version once after loaded; i.e. it's superfluous to
show the same version number repeatedly.

This patch suppresses the superfluous messages by replacing with
dev_info_once().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Use dev_info_oce()

 sound/soc/intel/atom/sst/sst_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 14c2d9d18180..65f3696133d3 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -236,7 +236,7 @@ static void process_fw_init(struct intel_sst_drv *sst_drv_ctx,
 		retval = init->result;
 		goto ret;
 	}
-	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
+	dev_info_once(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
 			init->fw_version.type, init->fw_version.major,
 			init->fw_version.minor, init->fw_version.build);
 	dev_dbg(sst_drv_ctx->dev, "Build date %s Time %s\n",
-- 
2.11.1
