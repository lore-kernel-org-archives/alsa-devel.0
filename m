From: mengdong.lin@linux.intel.com
Subject: [PATCH 10/13] ASoC: topology: ABI - Add flags and
	private data to BE/CC links
Date: Fri, 19 Aug 2016 18:14:07 +0800
Message-ID: <29fe9d566ddeb7e1eafcb5ae7c5c06228ddba2f6.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D293D266C1E
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:08:15 +0200 (CEST)
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

The flags will be used to configure an existing Backend and Codec<->Codec
link or create a new links.

The private data is reserved for future extension.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 21ebb97..4f1427a 100644
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
 
 /*
  * DAI physical PCM data formats.
@@ -552,6 +557,10 @@ struct snd_soc_tplg_link_config {
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
