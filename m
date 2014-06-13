From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/19] ASoc: Intel: mfld-pcm: report pcm delay
Date: Fri, 13 Jun 2014 18:03:53 +0530
Message-ID: <1402662848-24534-5-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A27B72619E7
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:32:52 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Now the DSP is capable of reporting the delay, report it to upper layers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |    1 +
 sound/soc/intel/sst-mfld-platform.h     |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 4528946..80879e5 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -409,6 +409,7 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 		pr_err("sst: error code = %d\n", ret_val);
 		return ret_val;
 	}
+	substream->runtime->delay = str_info->pcm_delay;
 	return str_info->buffer_ptr;
 }
 
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 6d929c7..33a0a27 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -42,6 +42,7 @@ struct pcm_stream_info {
 	void *arg;
 	void (*period_elapsed) (void *arg);
 	unsigned long long buffer_ptr;
+	unsigned long long pcm_delay;
 	int sfreq;
 };
 
-- 
1.7.0.4
