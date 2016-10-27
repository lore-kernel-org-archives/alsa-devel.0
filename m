From: mengdong.lin@linux.intel.com
Subject: [PATCH 01/22] topology: ABI - Update stream caps and
	PCM objects to ABI v5
Date: Thu, 27 Oct 2016 15:11:19 +0800
Message-ID: <432fe25e7529a52a99df059d5aeb06268ac34a22.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D4AC826688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:10:04 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Pump ABI version to 5, with the updates for PCM (Front DAI & DAI link)
objects:

- add sig_bits to stream caps.
- add flags and private data to PCM.

The kernel can handle the ABI update in a backward compatible way with
the patch "ASoC: topology: Make PCM backward compatible from ABI v4".

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index abe49c5..45872c1 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -115,6 +115,13 @@
 #define SND_SOC_TPLG_TUPLE_TYPE_WORD	4
 #define SND_SOC_TPLG_TUPLE_TYPE_SHORT	5
 
+/* DAI link flags */
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES         (1 << 0)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
+#define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
+#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 3)
+#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 << 4)
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -242,6 +249,7 @@ struct snd_soc_tplg_stream_caps {
 	__le32 period_size_max;	/* max period size bytes */
 	__le32 buffer_size_min;	/* min buffer size bytes */
 	__le32 buffer_size_max;	/* max buffer size bytes */
+	__le32 sig_bits;        /* number of bits of content */
 } __attribute__((packed));
 
 /*
@@ -422,6 +430,9 @@ struct snd_soc_tplg_pcm {
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
 	__le32 num_streams;	/* number of streams */
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
+	__le32 flag_mask;       /* bitmask of flags to configure */
+	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
+	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
 
-- 
2.5.0
