From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: fix ix spelling mistake:
	"capablities" -> "capabilites"" to the asoc tree
Date: Thu, 18 Aug 2016 11:17:25 +0100
Message-ID: <E1baKO5-00022f-O2@debutante>
References: <1471456079-130702-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AE8F265D44
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 12:17:41 +0200 (CEST)
In-Reply-To: <1471456079-130702-1-git-send-email-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: fix ix spelling mistake: "capablities" -> "capabilites"

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

>From 84ccd63686498e907799fe3789b521a2a18dd6a9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 17 Aug 2016 18:47:59 +0100
Subject: [PATCH] ASoC: Intel: sst: fix ix spelling mistake: "capablities" ->
 "capabilites"

trivial fix to spelling mistake in dev_err message and reformat code
to avoid being over 80 chars wide per line

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a4b458e77089..498b5f7fba4c 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -190,7 +190,8 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 
 	default:
 		dev_err(sst->dev,
-			"SST Driver capablities missing for dev_id: %x", sst->dev_id);
+			"SST Driver capabilities missing for dev_id: %x",
+			sst->dev_id);
 		return -EINVAL;
 	};
 }
-- 
2.8.1
