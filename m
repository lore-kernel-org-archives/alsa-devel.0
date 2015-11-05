From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/9] topology: ABI - Add name element to
	snd_soc_tplg_stream
Date: Thu,  5 Nov 2015 20:48:18 +0800
Message-ID: <b22238a1aaa3b76eda06a1744bc183255eb33d01.1446726689.git.mengdong.lin@linux.intel.com>
References: <cover.1446726689.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD3F265D81
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:32:53 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

For codec-codec links, this struct will be mapped to the DAI links's
params, which is struct snd_soc_pcm_stream and it needs a stream name.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index c642855..c5e08c4 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -208,6 +208,7 @@ struct snd_soc_tplg_stream_caps {
  */
 struct snd_soc_tplg_stream {
 	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* Name of the stream */
 	__le64 format;		/* SNDRV_PCM_FMTBIT_* */
 	__le32 rate;		/* SNDRV_PCM_RATE_* */
 	__le32 period_bytes;	/* size of period in bytes */
-- 
1.9.1
