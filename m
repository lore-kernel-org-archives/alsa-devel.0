From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 2/2] ASoC: fix config error path
Date: Wed, 06 Apr 2011 23:25:21 +0800
Message-ID: <20110406152521.32471.34258.stgit@localhost>
References: <20110406152511.32471.28875.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 32728103845
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 17:25:19 +0200 (CEST)
In-Reply-To: <20110406152511.32471.28875.stgit@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

initialize ret to invalid value so that when we reach the config error path in
soc_pcm_open, it will return the correct error code. without this patch, though
config error path is executed, soc_pcm_open will return 0 in
snd_pcm_open_substream and then cause double release of substream.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 88bb206..b8e69f2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -629,6 +629,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			runtime->hw.rates |= codec_dai_drv->capture.rates;
 	}
 
+	ret = -EINVAL;
 	snd_pcm_limit_hw_rates(runtime);
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "asoc: %s <-> %s No matching rates\n",
