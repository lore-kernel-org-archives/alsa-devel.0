From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 08/11] ASoC: topology: ABI - Add flags and
	private data to BE/CC links
Date: Fri,  9 Sep 2016 19:46:29 +0800
Message-ID: <d4036a0d8bc63a83d42af44fa30d64d310fb17f6.1473420558.git.mengdong.lin@linux.intel.com>
References: <cover.1473420558.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A2DDA26646C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2016 13:40:21 +0200 (CEST)
In-Reply-To: <cover.1473420558.git.mengdong.lin@linux.intel.com>
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

The flags will be used to configure an existing Backend and Codec<->Codec
link or create a new links.

The private data is reserved for future extension.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 31f2181..abae889 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -141,6 +141,11 @@
 /* DAI link flags */
 #define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 0)
 #define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 << 1)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES         (1 << 2)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS      (1 << 3)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 4)
+#define SND_SOC_TPLG_LNK_FLGBIT_DPCM_PLAYBACK           (1 << 5)
+#define SND_SOC_TPLG_LNK_FLGBIT_DPCM_CAPTURE            (1 << 6)
 
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
@@ -537,6 +542,10 @@ struct snd_soc_tplg_link_config {
 	struct snd_soc_tplg_hw_config hw_config[SND_SOC_TPLG_HW_CONFIG_MAX]; /* hw configs */
 	__le32 num_hw_configs;         /* number of hw configs */
 	__le32 default_hw_config_id;   /* default hw config ID for init */
+
+	__le32 flag_mask;       /* bitmask of flags to configure */
+	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
 /*
-- 
2.5.0
