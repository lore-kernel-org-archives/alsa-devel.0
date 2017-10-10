From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: mark 'snd_soc_dapm_free_kcontrol'
	as static" to the asoc tree
Date: Tue, 10 Oct 2017 10:30:54 +0100
Message-ID: <E1e1qsI-0004pK-DJ@debutante>
References: <20171010092052.2551973-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 508F826727C
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 11:31:03 +0200 (CEST)
In-Reply-To: <20171010092052.2551973-2-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, anish kumar <yesanishhere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: mark 'snd_soc_dapm_free_kcontrol' as static

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

>From c42c5ac4269bf8c0aa7ef2f4bdf328a12b03f65f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Oct 2017 11:20:11 +0200
Subject: [PATCH] ASoC: dapm: mark 'snd_soc_dapm_free_kcontrol' as static

The newly introduced function is declared as globally visible,
but is not declared in a header, causing a warning 'make W=1'
or 'make C=1':

sound/soc/soc-dapm.c:3782:1: warning: symbol 'snd_soc_dapm_free_kcontrol' was not declared. Should it be static?

The suggestion to make it static seems appropriate here, so let's
do that.

Fixes: 19ad683abc85 ("ASoC: dapm: Avoid creating kcontrol for params")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 12eb74d5f5c1..d674589e82e5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3778,7 +3778,7 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-void
+static void
 snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
 			unsigned long *private_value,
 			int num_params,
-- 
2.14.1
