From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] snd: soc: cx20442 codec: set tty->receiver_room in v253_open
Date: Thu, 16 Jun 2016 22:04:35 +0200
Message-ID: <1466107475-9747-1-git-send-email-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 79901317ce80 ("n_tty: Don't flush buffer when closing ldisc"),
introduced in v3.10, revealed a bug in the cx20442 codec driver
which has never been setting tty->receive_room on line discipline
open as it should from the beginning. Fix it.

Created and tested on Amstrad Delta against Linux-4.7-rc3

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 sound/soc/codecs/cx20442.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index d6f4abb..fb3885f 100644
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
2.7.3
