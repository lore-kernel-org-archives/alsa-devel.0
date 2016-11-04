From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add voice wake up flag
	for DAI links" to the asoc tree
Date: Fri, 04 Nov 2016 11:38:02 -0600
Message-ID: <E1c2iRG-0007AL-US@finisterre>
References: <4ec58db3621474cd8acf664483b18c30628f6cad.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B9FB2674C4
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:38:32 +0100 (CET)
In-Reply-To: <4ec58db3621474cd8acf664483b18c30628f6cad.1478071138.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Add voice wake up flag for DAI links

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6ff67ccafdf4c782489de1ccc47e1ec8d8480b63 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 3 Nov 2016 01:05:32 +0800
Subject: [PATCH] ASoC: topology: ABI - Add voice wake up flag for DAI links

Add a new flag bit SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP to link flags.
If a link is used for voice wake up, users can set this flag bit and
topology will set the link's 'ignore_suspend' to true.

This ABI update is backward compatible.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 1 +
 sound/soc/soc-topology.c  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 3c3fcc86b9f4..6a4280c6e860 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -155,6 +155,7 @@
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES         (1 << 0)
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
+#define SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP            (1 << 3)
 
 /*
  * Block Header.
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f44f12eb1798..8772fd994e82 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1701,6 +1701,11 @@ static void set_link_flags(struct snd_soc_dai_link *link,
 		link->symmetric_samplebits =
 			flags & SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS ?
 			1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP)
+		link->ignore_suspend =
+		flags & SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP ?
+		1 : 0;
 }
 
 /* create the FE DAI link */
-- 
2.10.1
