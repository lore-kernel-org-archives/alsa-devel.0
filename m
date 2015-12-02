From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Make enable/disable_pin work with
	always on widgets" to the asoc tree
Date: Wed, 02 Dec 2015 20:10:45 +0000
Message-ID: <E1a4Djh-0008M3-Nz@debutante>
References: <1449051736-26338-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C09E2650F5
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 21:10:53 +0100 (CET)
In-Reply-To: <1449051736-26338-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Make enable/disable_pin work with always on widgets

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

>From 20bb0184f24df64d1ed4fa07c8feeeffda9b7721 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 2 Dec 2015 10:22:16 +0000
Subject: [PATCH] ASoC: dapm: Make enable/disable_pin work with always on
 widgets

Always on widgets currently have some odd interactions with DAPM.
Enabling/disabling a widget (snd_soc_dapm_enable_pin) then connecting
it to a path works as expected, ie. when the widget is disabled the
path doesn't power up and it does when the widget is enabled. However
once in a path enabling the widget does not cause anything to power
up, dapm_widget_set_power will return the current power state of the
widget as 1, meaning we never check peer power states.

This patch updates dapm_always_on_check_power to return w->connected
such that it is effected by snd_soc_dapm_enable_pin and the like.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6760044f6aae..4ecacdcba484 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1300,7 +1300,7 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 
 static int dapm_always_on_check_power(struct snd_soc_dapm_widget *w)
 {
-	return 1;
+	return w->connected;
 }
 
 static int dapm_seq_compare(struct snd_soc_dapm_widget *a,
-- 
2.6.2
