From: Kirtika Ruchandani <kirtika@chromium.org>
Subject: [PATCH] ASoC: Intel: Skylake: remove unused 'out_fmt' variable
Date: Wed,  7 Dec 2016 22:01:42 -0800
Message-ID: <1481176902-131803-1-git-send-email-kirtika@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: Kirtika Ruchandani <kirtika@chromium.org>, arnd@arndb.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hardik T Shah <hardik.t.shah@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Commit 4cd9899f0d16 introduced struct skl_module_fmt* out_fmt without
using it. Compiling with W=1 gives the below warning, fix it.

sound/soc/intel/skylake/skl-topology.c: In function ‘skl_tplg_update_buffer_size’:
sound/soc/intel/skylake/skl-topology.c:301:34: warning: variable ‘out_fmt’ set but not used [-Wunused-but-set-variable]

This is a harmless warning and is only being fixed to reduce the noise
with W=1 in the kernel.

Fixes: 4cd9899f0d16 ("ASoC: Intel: Skylake: Add multiple pin formats")
Cc: Hardik T Shah <hardik.t.shah@intel.com>
Cc: Omair M Abdullah <omair.m.abdullah@intel.com>
Cc: Jeeja KP <jeeja.kp@intel.com>
Cc: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kirtika Ruchandani <kirtika@chromium.org>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index bd313c9..4352236a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -298,7 +298,7 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
				struct skl_module_cfg *mcfg)
 {
	int multiplier = 1;
-	struct skl_module_fmt *in_fmt, *out_fmt;
+	struct skl_module_fmt *in_fmt;
	int in_rate, out_rate;


@@ -306,7 +306,6 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
	 * change for pin 0 only
	 */
	in_fmt = &mcfg->in_fmt[0];
-	out_fmt = &mcfg->out_fmt[0];

	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
		multiplier = 5;
--
2.8.0.rc3.226.g39d4020
