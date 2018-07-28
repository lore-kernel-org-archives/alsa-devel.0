From: <gregkh@linuxfoundation.org>
Subject: Patch "ASoC: topology: Add missing clock gating
	parameter when parsing hw_configs" has been added to the
	4.14-stable tree
Date: Sat, 28 Jul 2018 12:07:16 +0200
Message-ID: <1532772436216125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 53B3326775C
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 12:11:53 +0200 (CEST)
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

    ASoC: topology: Add missing clock gating parameter when parsing hw_configs

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-topology-add-missing-clock-gating-parameter-when-parsing-hw_configs.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Sat Jul 28 10:25:26 CEST 2018
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Date: Wed, 4 Apr 2018 06:19:38 +0200
Subject: ASoC: topology: Add missing clock gating parameter when parsing hw_configs

From: Kirill Marinushkin <k.marinushkin@gmail.com>

[ Upstream commit 933e1c4a667103c4d10ebdc9505a0a6abd8c3fbd ]

Clock gating parameter is a part of `dai_fmt`. It is supported by
`alsa-lib` when creating a topology binary file, but ignored by kernel
when loading this topology file.

After applying this commit, the clock gating parameter is not ignored any
more. This solution is backwards compatible. The existing behaviour is
not broken, because by default the parameter value is 0 and is ignored.

snd_soc_tplg_hw_config.clock_gated = 0 => no effect
snd_soc_tplg_hw_config.clock_gated = 1 => SND_SOC_DAIFMT_GATED
snd_soc_tplg_hw_config.clock_gated = 2 => SND_SOC_DAIFMT_CONT

For example, the following config, based on
alsa-lib/src/conf/topology/broadwell/broadwell.conf, is now supported:

~~~~
SectionHWConfig."CodecHWConfig" {
        id "1"
        format "I2S"            # physical audio format.
        pm_gate_clocks "true"   # clock can be gated
}

SectionLink."Codec" {

        # used for binding to the physical link
        id "0"

        hw_configs [
                "CodecHWConfig"
        ]

        default_hw_conf_id "1"
}
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/sound/asoc.h |    7 ++++++-
 sound/soc/soc-topology.c  |    7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -139,6 +139,11 @@
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 
+/* DAI clock gating */
+#define SND_SOC_TPLG_DAI_CLK_GATE_UNDEFINED	0
+#define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
+#define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -324,7 +329,7 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_gated;	/* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1997,6 +1997,13 @@ static void set_link_hw_format(struct sn
 
 		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
+		/* clock gating */
+		if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
+			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
+		else if (hw_config->clock_gated ==
+			 SND_SOC_TPLG_DAI_CLK_GATE_CONT)
+			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
+
 		/* clock signal polarity */
 		invert_bclk = hw_config->invert_bclk;
 		invert_fsync = hw_config->invert_fsync;


Patches currently in stable-queue which might be from k.marinushkin@gmail.com are

queue-4.14/asoc-topology-fix-bclk-and-fsync-inversion-in-set_link_hw_format.patch
queue-4.14/asoc-topology-add-missing-clock-gating-parameter-when-parsing-hw_configs.patch
