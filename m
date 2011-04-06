From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 3/4] ASoC: sst_platform: unregister sst card
 when being closed
Date: Wed, 06 Apr 2011 10:20:37 +0800
Message-ID: <20110406022037.28406.47732.stgit@localhost>
References: <20110406022026.28406.98577.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C0F7103847
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 04:20:15 +0200 (CEST)
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
 sound/soc/mid-x86/sst_platform.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 848ad3c..9ba9414 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -271,6 +271,7 @@ static int sst_platform_close(struct snd_pcm_substream *substream)
 	str_id = stream->stream_info.str_id;
 	if (str_id)
 		ret_val = stream->sstdrv_ops->pcm_control->close(str_id);
+	unregister_sst_card(stream->sstdrv_ops);
 	kfree(stream->sstdrv_ops);
 	kfree(stream);
 	return ret_val;
