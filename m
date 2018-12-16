From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/9] ASoC: Intel: Haswell: assign booleans to
	true/false
Date: Sun, 16 Dec 2018 16:49:05 -0600
Message-ID: <20181216224910.16198-5-pierre-louis.bossart@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2124C2679E0
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 23:49:19 +0100 (CET)
In-Reply-To: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Detected with Coccinelle

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index d33bdaf92c57..31fcdf12c67d 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -1216,7 +1216,7 @@ int sst_hsw_stream_commit(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 		return ret;
 	}
 
-	stream->commited = 1;
+	stream->commited = true;
 	trace_hsw_stream_alloc_reply(stream);
 
 	return 0;
diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index fb9b8608eb3b..2debcc2ed99a 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -861,7 +861,7 @@ static int hsw_pcm_close(struct snd_pcm_substream *substream)
 		dev_dbg(rtd->dev, "error: free stream failed %d\n", ret);
 		goto out;
 	}
-	pcm_data->allocated = 0;
+	pcm_data->allocated = false;
 	pcm_data->stream = NULL;
 
 out:
-- 
2.17.1
