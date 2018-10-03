From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: intel: skylake: Add missing break in
	skl_tplg_get_token()
Date: Wed,  3 Oct 2018 19:31:44 +0200
Message-ID: <20181003173144.5132-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D389F2677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 19:31:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

skl_tplg_get_token() misses a break in the big switch() block for
SKL_TKN_U8_CORE_ID entry.
Spotted nicely by -Wimplicit-fallthrough compiler option.

Fixes: 6277e83292a2 ("ASoC: Intel: Skylake: Parse vendor tokens to build module data")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/skylake/skl-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2620d77729c5..f99c600f86e4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2461,6 +2461,7 @@ static int skl_tplg_get_token(struct device *dev,
 
 	case SKL_TKN_U8_CORE_ID:
 		mconfig->core_id = tkn_elem->value;
+		break;
 
 	case SKL_TKN_U8_MOD_TYPE:
 		mconfig->m_type = tkn_elem->value;
-- 
2.18.0
