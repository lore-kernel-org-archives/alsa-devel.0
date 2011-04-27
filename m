From: xingchao <xingchao.wang@intel.com>
Subject: [PATCH] sst_platform: add hw_free callback
Date: Wed, 27 Apr 2011 16:58:54 -0400
Message-ID: <1303937934-27751-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DA47D1038BA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 10:59:05 +0200 (CEST)
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
Cc: feng.tang@intel.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, xingchao <xingchao.wang@intel.com>, vinod.koul@intel.com, priya.harsha@intel.com, michael.fu@intel.com, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: xingchao <xingchao.wang@intel.com>
---
 sound/soc/mid-x86/sst_platform.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 9765fb8..5a946b4 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -380,6 +380,11 @@ static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int sst_platform_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
 static struct snd_pcm_ops sst_platform_ops = {
 	.open = sst_platform_open,
 	.close = sst_platform_close,
@@ -388,6 +393,7 @@ static struct snd_pcm_ops sst_platform_ops = {
 	.trigger = sst_platform_pcm_trigger,
 	.pointer = sst_platform_pcm_pointer,
 	.hw_params = sst_platform_pcm_hw_params,
+	.hw_free = sst_platform_pcm_hw_free,
 };
 
 static void sst_pcm_free(struct snd_pcm *pcm)
-- 
1.7.1
