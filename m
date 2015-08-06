From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Use kcalloc instead of
	kzalloc for array allocation" to the asoc tree
Date: Thu, 06 Aug 2015 12:28:23 +0100
Message-ID: <E1ZNJLT-0001ig-N3@finisterre>
References: <1438785262.9624.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A22BE2604C7
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2015 13:28:38 +0200 (CEST)
In-Reply-To: <1438785262.9624.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Use kcalloc instead of kzalloc for array allocation

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

>From 289c79458c1ef55caf40dae1b3f0dcc5e12ec13e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 5 Aug 2015 22:34:22 +0800
Subject: [PATCH] ASoC: topology: Use kcalloc instead of kzalloc for array
 allocation

Also remove unnecessary memset.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f38f111..c9575a7 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1070,7 +1070,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 	struct snd_soc_tplg_mixer_control *mc;
 	int i, err;
 
-	kc = kzalloc(sizeof(*kc) * num_kcontrols, GFP_KERNEL);
+	kc = kcalloc(num_kcontrols, sizeof(*kc), GFP_KERNEL);
 	if (kc == NULL)
 		return NULL;
 
@@ -1251,7 +1251,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 	struct snd_kcontrol_new *kc;
 	int i, err;
 
-	kc = kzalloc(sizeof(*kc) * count, GFP_KERNEL);
+	kc = kcalloc(count, sizeof(*kc), GFP_KERNEL);
 	if (!kc)
 		return NULL;
 
@@ -1274,7 +1274,6 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
-		memset(kc, 0, sizeof(*kc));
 		kc[i].name = be->hdr.name;
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-- 
2.1.4
