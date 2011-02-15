From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 4/5] ASoC: sst_platform: fix the pulseaudio
	error
Date: Tue, 15 Feb 2011 18:28:54 +0530
Message-ID: <1297774735-32184-5-git-send-email-vinod.koul@intel.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E621D10388C
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:50:11 +0100 (CET)
In-Reply-To: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Pulseaudio doesnt work with current driver and it was root caused to absense of
hw_params function and malloc_pages in it.
This patch adds this and allows pa to work fine with these drivers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 96e6e9c..ee2c224 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -365,6 +365,14 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	return stream->stream_info.buffer_ptr;
 }
 
+static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
+
+	return 0;
+}
 
 static struct snd_pcm_ops sst_platform_ops = {
 	.open = sst_platform_open,
@@ -373,6 +381,7 @@ static struct snd_pcm_ops sst_platform_ops = {
 	.prepare = sst_platform_pcm_prepare,
 	.trigger = sst_platform_pcm_trigger,
 	.pointer = sst_platform_pcm_pointer,
+	.hw_params = sst_platform_pcm_hw_params,
 };
 
 static void sst_pcm_free(struct snd_pcm *pcm)
-- 
1.7.2.3
