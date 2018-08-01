From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.17 289/336] ASoC: topology: Fix bclk and
	fsync inversion in set_link_hw_format()
Date: Wed,  1 Aug 2018 18:50:24 +0200
Message-ID: <20180801165040.083146846@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 2331A2676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 19:10:48 +0200 (CEST)
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <alexander.levin@microsoft.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Marinushkin <k.marinushkin@gmail.com>

[ Upstream commit a941e2fab3207cb0d57dc4ec47b1b12c8ea78b84 ]

The values of bclk and fsync are inverted WRT the codec. But the existing
solution already works for Broadwell, see the alsa-lib config:

`alsa-lib/src/conf/topology/broadwell/broadwell.conf`

This commit provides the backwards-compatible solution to fix this misuse.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/sound/asoc.h |   16 ++++++++++++++--
 sound/soc/soc-topology.c  |   12 +++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -160,6 +160,18 @@
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 #define SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP            (1 << 3)
 
+/* DAI topology BCLK parameter
+ * For the backwards capability, by default codec is bclk master
+ */
+#define SND_SOC_TPLG_BCLK_CM         0 /* codec is bclk master */
+#define SND_SOC_TPLG_BCLK_CS         1 /* codec is bclk slave */
+
+/* DAI topology FSYNC parameter
+ * For the backwards capability, by default codec is fsync master
+ */
+#define SND_SOC_TPLG_FSYNC_CM         0 /* codec is fsync master */
+#define SND_SOC_TPLG_FSYNC_CS         1 /* codec is fsync slave */
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -315,8 +327,8 @@ struct snd_soc_tplg_hw_config {
 	__u8 clock_gated;	/* 1 if clock can be gated to save power */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
-	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
-	__u8 fsync_master;	/* 1 for master of FSYNC, 0 for slave */
+	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
+	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
 	__u8 mclk_direction;    /* 0 for input, 1 for output */
 	__le16 reserved;	/* for 32bit alignment */
 	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2019,13 +2019,15 @@ static void set_link_hw_format(struct sn
 			link->dai_fmt |= SND_SOC_DAIFMT_IB_IF;
 
 		/* clock masters */
-		bclk_master = hw_config->bclk_master;
-		fsync_master = hw_config->fsync_master;
-		if (!bclk_master && !fsync_master)
+		bclk_master = (hw_config->bclk_master ==
+			       SND_SOC_TPLG_BCLK_CM);
+		fsync_master = (hw_config->fsync_master ==
+				SND_SOC_TPLG_FSYNC_CM);
+		if (bclk_master && fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
-		else if (bclk_master && !fsync_master)
-			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
 		else if (!bclk_master && fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		else if (bclk_master && !fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
 		else
 			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
