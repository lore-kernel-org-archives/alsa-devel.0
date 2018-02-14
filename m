From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9712: Use empty struct initializer"
	to the asoc tree
Date: Wed, 14 Feb 2018 13:29:38 +0000
Message-ID: <E1elx7y-00077F-EE@debutante>
References: <1518550536-16279-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F985267B2F
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:29:40 +0100 (CET)
In-Reply-To: <1518550536-16279-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9712: Use empty struct initializer

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

>From 60edb2006030894a4e45c84b04369cb70939d695 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 13 Feb 2018 17:37:50 -0200
Subject: [PATCH] ASoC: wm9712: Use empty struct initializer

{ 0 } only clears the first member of the structure.

The first member of the snd_soc_dapm_update struct is a pointer,
and writing 0 to a pointer results in the following sparse warning:

sound/soc/codecs/wm9712.c:229:47: warning: Using plain integer as NULL pointer

Use the empty struct initializer that clears all the struct members
and fixes the sparse warning.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 4f6d1a442bc4..c672d5d88827 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -226,7 +226,7 @@ static int wm9712_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mixer, mask, shift, old;
-	struct snd_soc_dapm_update update = { 0 };
+	struct snd_soc_dapm_update update = {};
 	bool change;
 
 	mixer = mc->shift >> 8;
-- 
2.16.1
