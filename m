From: <gregkh@linuxfoundation.org>
Subject: Patch "ASoC: topology: Fix bclk and fsync inversion in
	set_link_hw_format()" has been added to the 4.14-stable tree
Date: Sat, 28 Jul 2018 12:07:16 +0200
Message-ID: <153277243610689@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 11425267762
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 12:11:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alexander.levin@microsoft.com, alsa-devel@alsa-project.org, broonie@kernel.org, gregkh@linuxfoundation.org, k.marinushkin@gmail.com, liam.r.girdwood@linux.intel.com, perex@perex.cz, pierre-louis.bossart@linux.intel.com, tiwai@suse.de, xiuli.pan@linux.intel.com
Cc: stable-commits@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


This is a note to let you know that I've just added the patch titled

    ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-topology-fix-bclk-and-fsync-inversion-in-set_link_hw_format.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sat Jul 28 10:25:26 CEST 2018
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Date: Wed, 4 Apr 2018 06:19:37 +0200
Subject: ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()

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
@@ -2010,13 +2010,15 @@ static void set_link_hw_format(struct sn
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


Patches currently in stable-queue which might be from k.marinushkin@gmail.com are

queue-4.14/asoc-topology-fix-bclk-and-fsync-inversion-in-set_link_hw_format.patch
queue-4.14/asoc-topology-add-missing-clock-gating-parameter-when-parsing-hw_configs.patch
