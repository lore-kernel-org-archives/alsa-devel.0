From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 1/2] ASoC: check channel mismatch between
 cpu_dai and codec_dai
Date: Wed, 06 Apr 2011 23:25:11 +0800
Message-ID: <20110406152511.32471.28875.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F339103800
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 17:24:55 +0200 (CEST)
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

Suppose we have:

	cpu_dai
		channels_min = 1
		channels_max = 1

	codec_dai
		channels_min = 2
		channels_max = 2

This is a mismatch that should not happen, however according to the current
code, the result of runtime->hw will be:

		channels_min = 2
		channels_max = 1

We better spot it early. This patch checks this mismatch.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/soc-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0cf6997..88bb206 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -640,7 +640,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			codec_dai->name, cpu_dai->name);
 		goto config_err;
 	}
-	if (!runtime->hw.channels_min || !runtime->hw.channels_max) {
+	if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
+	    runtime->hw.channels_min > runtime->hw.channels_max) {
 		printk(KERN_ERR "asoc: %s <-> %s No matching channels\n",
 				codec_dai->name, cpu_dai->name);
 		goto config_err;
