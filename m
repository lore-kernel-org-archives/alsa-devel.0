From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix to return correct path list
	in is_connected_ep." to the asoc tree
Date: Wed, 15 Jun 2016 15:38:44 +0100
Message-ID: <E1bDBxs-00070F-Es@finisterre>
References: <1465969615-29573-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01237266B8D
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:38:55 +0200 (CEST)
In-Reply-To: <1465969615-29573-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Fix to return correct path list in is_connected_ep.

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

>From 09464974eaa8325c4cd22c3cab743a110644fb31 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 15 Jun 2016 11:16:55 +0530
Subject: [PATCH] ASoC: dapm: Fix to return correct path list in
 is_connected_ep.

In is_connected_ep, when custom_stop_condition is true, need to
return the correct paths instead of con which is 0.

Fixes: 6742064aef7f('ASoC: dapm: support user-defined stop condition in dai_get_connected_widgets')
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index db781f6faaec..3c3f027d21bd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1092,8 +1092,10 @@ static __always_inline int is_connected_ep(struct snd_soc_dapm_widget *widget,
 	if (list)
 		list_add_tail(&widget->work_list, list);
 
-	if (custom_stop_condition && custom_stop_condition(widget, dir))
-		return con;
+	if (custom_stop_condition && custom_stop_condition(widget, dir)) {
+		widget->endpoints[dir] = 1;
+		return widget->endpoints[dir];
+	}
 
 	if ((widget->is_ep & SND_SOC_DAPM_DIR_TO_EP(dir)) && widget->connected) {
 		widget->endpoints[dir] = snd_soc_dapm_suspend_check(widget);
-- 
2.8.1
