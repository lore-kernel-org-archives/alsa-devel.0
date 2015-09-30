From: mengdong.lin@intel.com
Subject: [PATCH 5/8] ASoC: topology: ABI - Change stream
	formats to a bitwise flag
Date: Wed, 30 Sep 2015 17:05:59 +0800
Message-ID: <eea48b17c22cc093bc808a141593a46f993065ae.1443602494.git.mengdong.lin@intel.com>
References: <cover.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A4F88265D39
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 10:51:40 +0200 (CEST)
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

From: Mengdong Lin <mengdong.lin@intel.com>

The toplogy user space tool will generate this bitwise flag by using
SNDRV_PCM_FORMAT_* exposed by asound.h, and the topology core will copy
this flag when generating DAI streams.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 2181480..eeb74a9c 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -198,7 +198,7 @@ struct snd_soc_tplg_ctl_hdr {
 struct snd_soc_tplg_stream_caps {
 	__le32 size;		/* in bytes of this structure */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
 	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
 	__le32 rate_min;	/* min rate */
 	__le32 rate_max;	/* max rate */
-- 
1.9.1
