From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: Skylake: Fix potential null
	pointer dereference
Date: Fri, 28 Jul 2017 16:12:16 +0530
Message-ID: <20170728104216.26859-4-guneshwor.o.singh@intel.com>
References: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A360B2676BB
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 12:43:36 +0200 (CEST)
In-Reply-To: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Check if the next sink is not null to avoid potential null pointer
dereference in skl_tplg_bind_sinks().

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 68c3f121efc3..8c3ce08f366d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -925,7 +925,7 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 		}
 	}
 
-	if (!sink)
+	if (!sink && next_sink)
 		return skl_tplg_bind_sinks(next_sink, skl, src_w, src_mconfig);
 
 	return 0;
-- 
2.13.0
