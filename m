From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/4] ASoC: sst_platform: initialize module_name
	properly
Date: Wed, 06 Apr 2011 10:20:26 +0800
Message-ID: <20110406022026.28406.98577.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 6064410384E
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 04:20:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>
Cc: Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

module_name will be checked in register_sst_card.
It will fail to register sst card if it's not initialized.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index ee2c224..bd9d928 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -247,6 +247,7 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 	}
 	stream->sstdrv_ops->vendor_id = MSIC_VENDOR_ID;
+	stream->sstdrv_ops->module_name = SST_CARD_NAMES;
 	/* registering with SST driver to get access to SST APIs to use */
 	ret_val = register_sst_card(stream->sstdrv_ops);
 	if (ret_val) {
