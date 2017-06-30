From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: show index in debug when
	adding DAPM routes" to the asoc tree
Date: Fri, 30 Jun 2017 12:59:29 +0100
Message-ID: <E1dQua9-00083V-H4@finisterre>
References: <1498742546-23463-3-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2D9B2674DD
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:38 +0200 (CEST)
In-Reply-To: <1498742546-23463-3-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: show index in debug when adding DAPM routes

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

>From b75a65118d287aadeade8b106ed0da7b5e42c167 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Thu, 29 Jun 2017 14:22:26 +0100
Subject: [PATCH] ASoC: topology: show index in debug when adding DAPM routes

Makes the debug output much more useful.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6070e35455aa..73308e6d3729 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1163,7 +1163,8 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	dev_dbg(tplg->dev, "ASoC: adding %d DAPM routes\n", count);
+	dev_dbg(tplg->dev, "ASoC: adding %d DAPM routes for index %d\n", count,
+		hdr->index);
 
 	for (i = 0; i < count; i++) {
 		elem = (struct snd_soc_tplg_dapm_graph_elem *)tplg->pos;
-- 
2.13.2
