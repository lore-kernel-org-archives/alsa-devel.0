From: mengdong.lin@intel.com
Subject: [PATCH 4/8] ASoC: topology: ABI - Add name element to
	snd_soc_tplg_stream
Date: Wed, 30 Sep 2015 17:05:43 +0800
Message-ID: <08b095d38f59c43690daaa45e1d201f367812228.1443602494.git.mengdong.lin@intel.com>
References: <cover.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C9C3265B51
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 10:51:12 +0200 (CEST)
In-Reply-To: <cover.1443602494.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@intel.com, vedang.patel@intel.com, subhransu.s.prusty@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

For codec-codec links, this struct will be mapped to the DAI links's
params, which is struct snd_soc_pcm_stream and it needs a stream name.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 88210a8..2181480 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -217,6 +217,7 @@ struct snd_soc_tplg_stream_caps {
  */
 struct snd_soc_tplg_stream {
 	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* Name of the stream */
 	__le64 format;		/* SNDRV_PCM_FMTBIT_* */
 	__le32 rate;		/* SNDRV_PCM_RATE_* */
 	__le32 period_bytes;	/* size of period in bytes */
-- 
1.9.1
