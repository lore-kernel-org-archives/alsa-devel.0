From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: fix memory leaks on sm, se and sbe" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:27 +0100 (BST)
Message-ID: <20190628165627.CAB93440049@finisterre.sirena.org.uk>
References: <20190627133208.9550-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627133208.9550-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: fix memory leaks on sm, se and sbe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 1ad741d0e8e8ecccc16aa9ccb8362575197d91bf Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 27 Jun 2019 14:32:08 +0100
Subject: [PATCH] ASoC: topology: fix memory leaks on sm, se and sbe

Currently when a kstrdup fails the error exit paths don't free
the allocations for sm, se and sbe.  This can be fixed by assigning
kc[i].private_value to these before doing the ksrtdup so that the error
exit path will be able to free these objects.

Addresses-Coverity: ("Resource leak")
Fixes: 9f90af3a9952 ("ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create flow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fc1f1d6f9e92..dc463f1a9e24 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1326,10 +1326,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
+		kc[i].private_value = (long)sm;
 		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sm;
-		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
 
@@ -1412,10 +1412,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
+		kc[i].private_value = (long)se;
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_se;
-		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
 
@@ -1524,10 +1524,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
+		kc[i].private_value = (long)sbe;
 		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sbe;
-		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
 
-- 
2.20.1
