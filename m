From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Check failure to create a
	widget" to the asoc tree
Date: Wed, 27 Apr 2016 17:34:45 +0100
Message-ID: <E1avSQH-0004Kd-Fk@debutante>
References: <1461739958-30065-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1876266634
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 18:34:49 +0200 (CEST)
In-Reply-To: <1461739958-30065-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Check failure to create a widget

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

>From 7de76b621f77aba456f594e4621eca2e94a146f3 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Wed, 27 Apr 2016 14:52:38 +0800
Subject: [PATCH] ASoC: topology: Check failure to create a widget

Stop loading topology info if error happens when creating a widget.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ca5f82885031..0224a6458f3b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1500,9 +1500,11 @@ static int soc_tplg_dapm_widget_elems_load(struct soc_tplg *tplg,
 	for (i = 0; i < count; i++) {
 		widget = (struct snd_soc_tplg_dapm_widget *) tplg->pos;
 		ret = soc_tplg_dapm_widget_create(tplg, widget);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(tplg->dev, "ASoC: failed to load widget %s\n",
 				widget->name);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.8.0.rc3
