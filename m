From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Atom: fix boot warning
Date: Fri, 22 Apr 2016 09:03:53 +0530
Message-ID: <1461296033-6762-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E953A2616C9
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 05:29:14 +0200 (CEST)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sandeep Tayal <sandeepx.tayal@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Users have reported seeing this false warning on atom driver

[    5.647469] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    5.661612] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    5.661646] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    5.661681] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    5.661708] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    5.661738] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    5.661771] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    5.661807] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!

This is caused when check for control is not being associated
with a dapm widget, but the check is wrong as the else case
maybe triggered when widget is not powered up, so we should
check if widget is associated before printing this message.

Tested-by: Sandeep Tayal <sandeepx.tayal@intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index b97e6adcf1b2..98720a93de8a 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -195,7 +195,7 @@ static int sst_check_and_send_slot_map(struct sst_data *drv, struct snd_kcontrol
 
 	if (e->w && e->w->power)
 		ret = sst_send_slot_map(drv);
-	else
+	else if (!e->w)
 		dev_err(&drv->pdev->dev, "Slot control: %s doesn't have DAPM widget!!!\n",
 				kcontrol->id.name);
 	return ret;
-- 
1.9.1
