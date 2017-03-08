From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Subject: [PATCH] ASoC: Intel: Skylake: code cleanup for pin
	fixup limitation
Date: Wed,  8 Mar 2017 17:47:02 +0900
Message-ID: <20170308084702.20558-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f42.google.com (mail-pg0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ABA8267044
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 09:47:11 +0100 (CET)
Received: by mail-pg0-f42.google.com with SMTP id b129so10959481pgc.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Mar 2017 00:47:10 -0800 (PST)
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
Cc: ichiro.suzuki@miraclelinux.com, alsa-devel@alsa-project.org, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

As a commit 4cd9899f0d16 ("ASoC: Intel: Skylake: Add multiple pin
formats") describes, 'fixups is applied to pin 0 only'. On the other
hand, the commit left some codes as what they were. This might
confuses readers.

This commit fixes the issue. This doesn't change driver behaviour at all.

Fixes: 4cd9899f0d16 ("ASoC: Intel: Skylake: Add multiple pin formats")
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
---
 sound/soc/intel/skylake/skl-topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index f38f8e6..8651359 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -310,13 +310,11 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 		multiplier = 5;
 
 	mcfg->ibs = DIV_ROUND_UP(in_fmt->s_freq, 1000) *
-			(mcfg->in_fmt->channels) *
-			(mcfg->in_fmt->bit_depth >> 3) *
+			in_fmt->channels * (in_fmt->bit_depth >> 3) *
 			multiplier;
 
-	mcfg->obs = DIV_ROUND_UP(mcfg->out_fmt->s_freq, 1000) *
-			(mcfg->out_fmt->channels) *
-			(mcfg->out_fmt->bit_depth >> 3) *
+	mcfg->obs = DIV_ROUND_UP(out_fmt->s_freq, 1000) *
+			out_fmt->channels * (out_fmt->bit_depth >> 3) *
 			multiplier;
 }
 
-- 
2.9.3
