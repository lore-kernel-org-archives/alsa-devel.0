From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Clear stored Baytrail DSP DMA
	pointer before stream start
Date: Mon, 26 May 2014 16:56:30 +0300
Message-ID: <1401112593-2852-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 161C426513B
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:56:44 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Stored DSP DMA pointer must be cleared before starting the stream since
PCM pointer callback sst_byt_pcm_pointer() can be called before pointer is
updated. In that case last position of previous stream was wronly returned.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 3af38576e91e..8eab97368ea7 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -180,6 +180,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		pcm_data->hw_ptr = 0;
 		sst_byt_stream_start(byt, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
-- 
2.0.0.rc2
