From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add kcontrol support for PGAs" to
	the asoc tree
Date: Fri, 23 Oct 2015 08:09:11 +0900
Message-ID: <E1ZpOyt-0008MX-BB@finisterre>
References: <1445360408-3478-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3954266AF7
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:20 +0200 (CEST)
In-Reply-To: <1445360408-3478-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Mythri P K <mythri.p.k@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add kcontrol support for PGAs

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

>From 19a2557b76d64f26c761925cb4fecefb5d72c099 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 20 Oct 2015 22:30:06 +0530
Subject: [PATCH] ASoC: dapm: Add kcontrol support for PGAs

For DSPs we can define processing blocks as DAPM PGA widgets.
Some of these proceesing blocks can be configured by usermode
like EQ etc. So we need to add support of kcontrol for PGA
widgets.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f4bf21a..9762ac4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -779,7 +779,7 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
  * Determine if a kcontrol is shared. If it is, look it up. If it isn't,
  * create it. Either way, add the widget into the control's widget list
  */
-static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
+static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 	int kci)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
@@ -810,6 +810,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 			switch (w->id) {
 			case snd_soc_dapm_switch:
 			case snd_soc_dapm_mixer:
+			case snd_soc_dapm_pga:
 				wname_in_long_name = true;
 				kcname_in_long_name = true;
 				break;
@@ -899,7 +900,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				continue;
 
 			if (!w->kcontrols[i]) {
-				ret = dapm_create_or_share_mixmux_kcontrol(w, i);
+				ret = dapm_create_or_share_kcontrol(w, i);
 				if (ret < 0)
 					return ret;
 			}
@@ -952,7 +953,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 		return -EINVAL;
 	}
 
-	ret = dapm_create_or_share_mixmux_kcontrol(w, 0);
+	ret = dapm_create_or_share_kcontrol(w, 0);
 	if (ret < 0)
 		return ret;
 
@@ -967,9 +968,13 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 /* create new dapm volume control */
 static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 {
-	if (w->num_kcontrols)
-		dev_err(w->dapm->dev,
-			"ASoC: PGA controls not supported: '%s'\n", w->name);
+	int i, ret;
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		ret = dapm_create_or_share_kcontrol(w, i);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.6.1
