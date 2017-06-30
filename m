From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix usage of
	SND_SOC_TPLG_INDEX_ALL during load" to the asoc tree
Date: Fri, 30 Jun 2017 12:59:35 +0100
Message-ID: <E1dQuaF-00084G-0j@finisterre>
References: <1498742546-23463-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ADAA2674EF
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:43 +0200 (CEST)
In-Reply-To: <1498742546-23463-2-git-send-email-liam.r.girdwood@linux.intel.com>
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

   ASoC: topology: Fix usage of SND_SOC_TPLG_INDEX_ALL during load

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

>From bb97142bcf8c042103e87d035a120f522d12e788 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Thu, 29 Jun 2017 14:22:25 +0100
Subject: [PATCH] ASoC: topology: Fix usage of SND_SOC_TPLG_INDEX_ALL during
 load

SND_SOC_TPLG_INDEX_ALL is used by drivers to tell the core to load
all topology component indexes, not just the index in the header.
Fix this so that SND_SOC_TPLG_INDEX_ALL will load all components no matter
their index.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 12e189701924..6070e35455aa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2381,7 +2381,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 
 	/* check for matching ID */
 	if (hdr->index != tplg->req_index &&
-		hdr->index != SND_SOC_TPLG_INDEX_ALL)
+		tplg->req_index != SND_SOC_TPLG_INDEX_ALL)
 		return 0;
 
 	tplg->index = hdr->index;
-- 
2.13.2
