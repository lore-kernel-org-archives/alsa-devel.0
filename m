From: mengdong.lin@linux.intel.com
Subject: [PATCH 6/9] topology: ABI - Change stream formats to a
	bitwise flag
Date: Thu,  5 Nov 2015 20:49:02 +0800
Message-ID: <0999b02f5e676afa0c9afbb3e0d4af6413a7d98d.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B3614265E27
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:33:35 +0100 (CET)
In-Reply-To: <cover.1446726689.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The toplogy user space tool will generate this bitwise flag by using
SNDRV_PCM_FORMAT_* exposed by asound.h, and the topology core will copy
this flag when generating DAI streams.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index acff6ec..5f857cf 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -190,7 +190,7 @@ struct snd_soc_tplg_ctl_hdr {
 struct snd_soc_tplg_stream_caps {
 	__le32 size;		/* in bytes of this structure */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
 	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
 	__le32 rate_min;	/* min rate */
 	__le32 rate_max;	/* max rate */
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 8559376..ec26f9c 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -174,7 +174,7 @@ static int split_format(struct snd_soc_tplg_stream_caps *caps, char *str)
 			return -EINVAL;
 		}
 
-		caps->formats[i] = format;
+		caps->formats |= 1 << format;
 		s = strtok(NULL, ", ");
 		i++;
 	}
-- 
1.9.1
