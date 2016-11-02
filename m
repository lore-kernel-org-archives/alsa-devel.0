From: mengdong.lin@linux.intel.com
Subject: [PATCH v7 11/11] ASoC: topology: ABI - Add voice wake
	up flag for DAI links
Date: Thu,  3 Nov 2016 01:05:32 +0800
Message-ID: <4ec58db3621474cd8acf664483b18c30628f6cad.1478071138.git.mengdong.lin@linux.intel.com>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C2FF2666FA
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 18:04:29 +0100 (CET)
In-Reply-To: <cover.1478071138.git.mengdong.lin@linux.intel.com>
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

Add a new flag bit SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP to link flags.
If a link is used for voice wake up, users can set this flag bit and
topology will set the link's 'ignore_suspend' to true.

This ABI update is backward compatible.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 3c3fcc8..6a4280c 100644
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
index f44f12e..8772fd9 100644
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
2.7.4
