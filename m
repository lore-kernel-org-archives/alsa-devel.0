From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next 1/1] ASoC: rsnd: ssiu: reset
	SSI_MODE register
Date: Thu, 26 Oct 2017 08:07:42 -0700
Message-ID: <1509030462-4799-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AFCA266AF8
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 17:07:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, gustavo@embeddedor.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jiada Wang <jiada_wang@mentor.com>

register SSI_MODE is set when SSI works in TDM Extended or
TDM (Ex-)Split mode, but it isn't reset after SSI stops.
this will cause issue, if SSI starts to work in other modes
which requie SSI_MODE to have different value.

This patch resets SSI_MODE register in .stop callback,
when last stream calls .stop.

Fixes: 186fadc132f0 ("ASoC: rsnd: add TDM Extend Mode support")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/sh/rcar/ssiu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 4d94875..eff9f3b 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -217,6 +217,8 @@ static int rsnd_ssiu_stop_gen2(struct rsnd_mod *mod,
 	if (rsnd_ssi_multi_slaves_runtime(io))
 		rsnd_mod_write(mod, SSI_CONTROL, 0);
 
+	rsnd_mod_write(mod, SSI_MODE, 0);
+
 	return 0;
 }
 
-- 
1.7.9.5
