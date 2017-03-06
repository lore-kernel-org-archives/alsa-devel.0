From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Subject: [PATCH] ASoC: Intel: Skylake: use a helper macro to
	rounding-up calculation
Date: Mon,  6 Mar 2017 16:12:22 +0900
Message-ID: <20170306071222.16219-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f42.google.com (mail-pg0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F7EB266871
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 08:12:31 +0100 (CET)
Received: by mail-pg0-f42.google.com with SMTP id b129so63238702pgc.2
 for <alsa-devel@alsa-project.org>; Sun, 05 Mar 2017 23:12:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, jeeja.kp@intel.com, shreyas.nc@intel.com, vinod.koul@intel.com
Cc: ichiro.suzuki@miraclelinux.com, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

In 'include/linux/kernel.h', there's a helper macro to round numerical
value. Let's use it.

Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
---
 sound/soc/intel/skylake/skl-topology.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2dbfb1b..f38f8e6 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -299,8 +299,6 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 {
 	int multiplier = 1;
 	struct skl_module_fmt *in_fmt, *out_fmt;
-	int in_rate, out_rate;
-
 
 	/* Since fixups is applied to pin 0 only, ibs, obs needs
 	 * change for pin 0 only
@@ -311,21 +309,13 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 	if (mcfg->m_type == SKL_MODULE_TYPE_SRCINT)
 		multiplier = 5;
 
-	if (in_fmt->s_freq % 1000)
-		in_rate = (in_fmt->s_freq / 1000) + 1;
-	else
-		in_rate = (in_fmt->s_freq / 1000);
-
-	mcfg->ibs = in_rate * (mcfg->in_fmt->channels) *
+	mcfg->ibs = DIV_ROUND_UP(in_fmt->s_freq, 1000) *
+			(mcfg->in_fmt->channels) *
 			(mcfg->in_fmt->bit_depth >> 3) *
 			multiplier;
 
-	if (mcfg->out_fmt->s_freq % 1000)
-		out_rate = (mcfg->out_fmt->s_freq / 1000) + 1;
-	else
-		out_rate = (mcfg->out_fmt->s_freq / 1000);
-
-	mcfg->obs = out_rate * (mcfg->out_fmt->channels) *
+	mcfg->obs = DIV_ROUND_UP(mcfg->out_fmt->s_freq, 1000) *
+			(mcfg->out_fmt->channels) *
 			(mcfg->out_fmt->bit_depth >> 3) *
 			multiplier;
 }
-- 
2.9.3
