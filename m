From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: fix typo in
	soc_tplg_kcontrol_bind_io()" to the asoc tree
Date: Tue, 04 Aug 2015 18:47:57 +0100
Message-ID: <E1ZMgJh-0007qT-FQ@finisterre>
References: <1438699655-13985-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B811260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:48:05 +0200 (CEST)
In-Reply-To: <1438699655-13985-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: fix typo in soc_tplg_kcontrol_bind_io()

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

>From 5406898354ebfb11f49b955fb5e49a62786a542f Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Tue, 4 Aug 2015 15:47:35 +0100
Subject: [PATCH] ASoC: topology: fix typo in soc_tplg_kcontrol_bind_io()

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d096068..6a547c6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -534,7 +534,7 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 			k->put = bops[i].put;
 		if (k->get == NULL && bops[i].id == hdr->ops.get)
 			k->get = bops[i].get;
-		if (k->info == NULL && ops[i].id == hdr->ops.info)
+		if (k->info == NULL && bops[i].id == hdr->ops.info)
 			k->info = bops[i].info;
 	}
 
-- 
2.1.4
