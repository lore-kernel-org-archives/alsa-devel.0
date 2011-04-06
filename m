From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 2/4] ASoC: sst_platform: free the resources on
	fail path
Date: Wed, 06 Apr 2011 10:20:32 +0800
Message-ID: <20110406022032.28406.70693.stgit@localhost>
References: <20110406022026.28406.98577.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 76E35103811
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 04:20:09 +0200 (CEST)
In-Reply-To: <20110406022026.28406.98577.stgit@localhost>
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

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index bd9d928..848ad3c 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -252,6 +252,8 @@ static int sst_platform_open(struct snd_pcm_substream *substream)
 	ret_val = register_sst_card(stream->sstdrv_ops);
 	if (ret_val) {
 		pr_err("sst: sst card registration failed\n");
+		kfree(stream->sstdrv_ops);
+		kfree(stream);
 		return ret_val;
 	}
 	runtime->private_data = stream;
