From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 3/4] ASoC: sst_platform: using builtin function
Date: Tue, 06 Sep 2011 15:21:38 +0800
Message-ID: <20110906072138.7310.65955.stgit@localhost>
References: <20110906072129.7310.6960.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id ED34B103917
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 09:19:10 +0200 (CEST)
In-Reply-To: <20110906072129.7310.6960.stgit@localhost>
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
Cc: Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use the builtin snd_soc_set_runtime_hwparams() instead of assigning it by
myself.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index d99f253..af666ae 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -226,13 +226,14 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 
 static int sst_platform_open(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sst_runtime_stream *stream;
 	int ret_val = 0;
 
 	pr_debug("sst_platform_open called\n");
-	runtime = substream->runtime;
-	runtime->hw = sst_platform_pcm_hw;
+
+	snd_soc_set_runtime_hwparams(substream, &sst_platform_pcm_hw);
+
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
 		return -ENOMEM;
