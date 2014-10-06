From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v8 4/6] ASoC: core: Call mute for cpu dais as
	well
Date: Mon,  6 Oct 2014 19:29:12 +0530
Message-ID: <1412603954-9030-5-git-send-email-vinod.koul@intel.com>
References: <1412603954-9030-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AC2A9260480
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 16:32:00 +0200 (CEST)
In-Reply-To: <1412603954-9030-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

We call mute for codec dai only, we should call this for cpu dai as well to
allow cpu dais (FEs) in DSPs to be muted/unmuted on shutdown/startup

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 642c862..79b9eb0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -654,6 +654,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 			codec_dai->rate = 0;
 	}
 
+	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
+
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
@@ -772,6 +774,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	for (i = 0; i < rtd->num_codecs; i++)
 		snd_soc_dai_digital_mute(rtd->codec_dais[i], 0,
 					 substream->stream);
+	snd_soc_dai_digital_mute(cpu_dai, 0, substream->stream);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
-- 
1.7.0.4
