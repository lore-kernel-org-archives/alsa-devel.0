From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 6/8] ASoC: topology: ABI - Add name and
	stream name to BE DAI links
Date: Thu, 29 Sep 2016 14:09:44 +0800
Message-ID: <4c6b520e1846e13f4d7e201c51f183d02bdbfed8.1475127338.git.mengdong.lin@linux.intel.com>
References: <cover.1475127338.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E9082614A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 08:03:24 +0200 (CEST)
In-Reply-To: <cover.1475127338.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Topology can also use name or stream name to find an existing backend
link and configure it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index d440bb1..019c8af 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -515,6 +515,8 @@ struct snd_soc_tplg_pcm {
 struct snd_soc_tplg_link_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;              /* unique ID - used to match */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* name - used to match */
+	char stream_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* stream name - used to match */
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
 	__le32 num_streams;     /* number of streams */
 	struct snd_soc_tplg_hw_config hw_config[SND_SOC_TPLG_HW_CONFIG_MAX]; /* hw configs */
-- 
2.5.0
