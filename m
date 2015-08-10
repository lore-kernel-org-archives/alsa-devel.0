From: mengdong.lin@intel.com
Subject: [RFC PATCH 09/10] ASoC: Topology: change stream
	formats to bitwise flag
Date: Mon, 10 Aug 2015 14:13:50 +0800
Message-ID: <1439187230-1326-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BA172654B0
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 08:00:33 +0200 (CEST)
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The toplogy user space tool will generate this bitwise flag by using
SNDRV_PCM_FORMAT_* exposed by asound.h, and the topology core will copy
this flag when generating DAI streams.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 69383b0..eb2ad59 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -191,7 +191,7 @@ struct snd_soc_tplg_ctl_hdr {
 struct snd_soc_tplg_stream_caps {
 	__le32 size;		/* in bytes of this structure */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le64 formats;	/* supported formats SNDRV_PCM_FORMAT_* */
 	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
 	__le32 rate_min;	/* min rate */
 	__le32 rate_max;	/* max rate */
-- 
1.9.1
