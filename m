From: mengdong.lin@linux.intel.com
Subject: [PATCH 02/13] ASoC: topology: ABI - Add sig_bits to
	stream caps
Date: Fri, 19 Aug 2016 18:12:46 +0800
Message-ID: <d9147786c40ccf5eeb461c06ae008c4f22c68e7a.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 33348266C1F
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:06:54 +0200 (CEST)
In-Reply-To: <cover.1471599648.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Kernel struct snd_soc_pcm_stream, SoC PCM stream information, needs this
field. Although current topology users don't configure this, we define it
for future extension.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f734bea..33d00a4 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -257,6 +257,7 @@ struct snd_soc_tplg_stream_caps {
 	__le32 period_size_max;	/* max period size bytes */
 	__le32 buffer_size_min;	/* min buffer size bytes */
 	__le32 buffer_size_max;	/* max buffer size bytes */
+	__le32 sig_bits;        /* number of bits of content */
 } __attribute__((packed));
 
 /*
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 1e26dc6..b271248 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1556,6 +1556,7 @@ static void set_stream_info(struct snd_soc_pcm_stream *stream,
 	stream->rate_min = caps->rate_min;
 	stream->rate_max = caps->rate_max;
 	stream->formats = caps->formats;
+	stream->sig_bits = caps->sig_bits;
 }
 
 static void set_dai_flags(struct snd_soc_dai_driver *dai_drv,
-- 
2.5.0
