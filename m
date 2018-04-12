From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: fix some tiny memory leaks"
	to the asoc tree
Date: Thu, 12 Apr 2018 17:17:03 +0100
Message-ID: <E1f6euF-0008JM-RX@debutante>
References: <20180405112518.GE4218@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9C626736C
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 18:17:12 +0200 (CEST)
In-Reply-To: <20180405112518.GE4218@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: fix some tiny memory leaks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 65030ff305bc9c51cb75705483bdaac7813778f0 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 5 Apr 2018 14:25:18 +0300
Subject: [PATCH] ASoC: topology: fix some tiny memory leaks

These tiny memory leaks don't have a huge real life impact but they
cause static checker warnings so let's fix them.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fa27d0fca6dc..942c6e5eb4b7 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1325,8 +1325,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 			ec->hdr.name);
 
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
-		if (kc[i].name == NULL)
+		if (kc[i].name == NULL) {
+			kfree(se);
 			goto err_se;
+		}
 		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
@@ -1442,8 +1444,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			be->hdr.name, be->hdr.access);
 
 		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
-		if (kc[i].name == NULL)
+		if (kc[i].name == NULL) {
+			kfree(sbe);
 			goto err;
+		}
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
-- 
2.17.0
