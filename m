From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Use nested lock for
	snd_soc_dapm_mutex_lock" to the asoc tree
Date: Wed, 30 Dec 2015 18:05:18 +0000
Message-ID: <E1aEL7e-0007MM-P2@debutante>
References: <1451406314-13973-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC560265A1A
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:05:25 +0100 (CET)
In-Reply-To: <1451406314-13973-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: Use nested lock for snd_soc_dapm_mutex_lock

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

>From 783513eec3209542fcd6ac0cbcb030b3c17a4827 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 29 Dec 2015 16:25:13 +0000
Subject: [PATCH] ASoC: Use nested lock for snd_soc_dapm_mutex_lock

snd_soc_dapm_mutex_lock currently uses the un-nested call which can
cause lockdep warnings when called from control handlers (a relatively
common usage) and using modules. As creating the control causes a
potential mutex inversion with the handler, creating the control will
take the controls_rwsem under the dapm_mutex and accessing the control
will take the dapm_mutex under controls_rwsem.

All the users look like they want to be using the runtime class of the
lock anyway, so this patch just changes snd_soc_dapm_mutex_lock to use
the nested call, with the SND_SOC_DAPM_CLASS_RUNTIME class.

Fixes: f6d5e586b416 ("ASoC: dapm: Add helpers to lock/unlock DAPM mutex")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a8b4b9c8b1d2..fb955e69a78e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1655,7 +1655,7 @@ extern const struct dev_pm_ops snd_soc_pm_ops;
 /* Helper functions */
 static inline void snd_soc_dapm_mutex_lock(struct snd_soc_dapm_context *dapm)
 {
-	mutex_lock(&dapm->card->dapm_mutex);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 }
 
 static inline void snd_soc_dapm_mutex_unlock(struct snd_soc_dapm_context *dapm)
-- 
2.6.2
