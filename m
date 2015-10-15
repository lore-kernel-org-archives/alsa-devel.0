From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: firewire-tascam: off by one in identify_model()
Date: Thu, 15 Oct 2015 21:18:29 +0300
Message-ID: <20151015181828.GC3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the original code, we potentially put a NUL character in model[8] and
it caused a static checker warning.  We can put the NUL in model[7]
instead.

Fixes: 53b3ffee7885 ('ALSA: firewire-tascam: change device probing processing')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index c6747a4..6ef2bcc 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -51,7 +51,7 @@ static int identify_model(struct snd_tscm *tscm)
 	}
 
 	/* Pick up model name from certain addresses. */
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < 7; i++) {
 		c = config_rom[28 + i / 4] >> (24 - 8 * (i % 4));
 		if (c == '\0')
 			break;
