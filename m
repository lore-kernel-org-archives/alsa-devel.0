From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: add NULL test" to the asoc tree
Date: Wed, 23 Dec 2015 00:08:55 +0000
Message-ID: <E1aBWz9-0007Jq-Vq@debutante>
References: <1450610153-7746-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DFBD265DA1
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:03 +0100 (CET)
In-Reply-To: <1450610153-7746-5-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: add NULL test

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

>From 3f317c9faabc546a503bc62e806fa2e8e93e76be Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 20 Dec 2015 12:15:53 +0100
Subject: [PATCH] ASoC: Intel: add NULL test

Add NULL test on call to devm_kzalloc.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
identifier fld;
@@

* x = devm_kzalloc(...);
  ... when != x == NULL
  x->fld
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 79547bec558b..4765ad474544 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -377,6 +377,8 @@ static int sst_byt_pcm_probe(struct snd_soc_platform *platform)
 
 	priv_data = devm_kzalloc(platform->dev, sizeof(*priv_data),
 				 GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
 	priv_data->byt = plat_data->dsp;
 	snd_soc_platform_set_drvdata(platform, priv_data);
 
-- 
2.6.2
