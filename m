From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar: remove unused variable" to the
	asoc tree
Date: Mon, 23 Nov 2015 11:41:02 +0000
Message-ID: <E1a0pUU-0005Sc-Hg@debutante>
References: <4929159.b95vLdVRYU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05EEE2652D7
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 12:41:10 +0100 (CET)
In-Reply-To: <4929159.b95vLdVRYU@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar: remove unused variable

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

>From ccae40fa973f5b0eec5d5ad27e81c5a2b95f7b7c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Nov 2015 10:35:54 +0100
Subject: [PATCH] ASoC: rcar: remove unused variable

After a recent cleanup, the soc_card variable became unused
and now produces a warning:

soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
soc/sh/rcar/core.c:801:23: warning: unused variable 'soc_card' [-Wunused-variable]

This removes the variable.

Fixes: 1a497983a5ae ("ASoC: Change the PCM runtime array to a list")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 81a6bdb6848c..247c3d248257 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -798,7 +798,6 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 			    void (*update)(struct rsnd_dai_stream *io,
 					   struct rsnd_mod *mod))
 {
-	struct snd_soc_card *soc_card = rtd->card;
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_kcontrol *kctrl;
 	struct snd_kcontrol_new knew = {
-- 
2.6.2
