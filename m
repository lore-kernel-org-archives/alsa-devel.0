From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 03/11] ASoC: Intel: Skylake: Fix potential NULL
	pointer dereference
Date: Tue,  7 Nov 2017 16:16:18 +0530
Message-ID: <20171107104626.25800-4-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 2489F267387
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:12 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

Pointer 'mconfig' returned from call to skl_tplg_fe_get_cpr_module() can
be NULL. So check for the valid pointer before dereferencing.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 4380e40c6af0..1dd97479e0c0 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -355,7 +355,8 @@ static void skl_pcm_close(struct snd_pcm_substream *substream,
 	}
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
-	skl_tplg_d0i3_put(skl, mconfig->d0i3_caps);
+	if (mconfig)
+		skl_tplg_d0i3_put(skl, mconfig->d0i3_caps);
 
 	kfree(dma_params);
 }
-- 
2.14.2
