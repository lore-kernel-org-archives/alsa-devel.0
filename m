From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cx20442: set tty->receiver_room in v253_open" to the asoc tree
Date: Fri, 17 Jun 2016 12:43:15 +0100
Message-ID: <E1bDsB9-00023E-E4@debutante>
References: <1466107475-9747-1-git-send-email-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466107475-9747-1-git-send-email-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cx20442: set tty->receiver_room in v253_open

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

>From 86c0ae7cde7a8699116b365a5e3016753f0cd92a Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Thu, 16 Jun 2016 22:04:35 +0200
Subject: [PATCH] ASoC: cx20442: set tty->receiver_room in v253_open

Commit 79901317ce80 ("n_tty: Don't flush buffer when closing ldisc"),
introduced in v3.10, revealed a bug in the cx20442 codec driver
which has never been setting tty->receive_room on line discipline
open as it should from the beginning. Fix it.

Created and tested on Amstrad Delta against Linux-4.7-rc3

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index d6f4abbbf8a7..fb3885fe0afb 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -226,6 +226,7 @@ static int v253_open(struct tty_struct *tty)
 	if (!tty->disc_data)
 		return -ENODEV;
 
+	tty->receive_room = 16;
 	if (tty->ops->write(tty, v253_init, len) != len) {
 		ret = -EIO;
 		goto err;
-- 
2.8.1
