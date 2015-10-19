From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] ALSA: firewire-tascam: off by one in identify_model()
Date: Mon, 19 Oct 2015 14:29:27 +0300
Message-ID: <20151019112927.GA31691@mwanda>
References: <5622EF20.6010708@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5622EF20.6010708@sakamocchi.jp>
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Let's leave space for the NUL char otherwise the static checkers
complain that we go beyond the end of the array.

Fixes: 53b3ffee7885 ('ALSA: firewire-tascam: change device probing processing') 
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: I truncated the last char in v1 instead of making the buffer larger

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index c6747a4..79cb9e9 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -40,7 +40,7 @@ static int identify_model(struct snd_tscm *tscm)
 {
 	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
 	const u32 *config_rom = fw_dev->config_rom;
-	char model[8];
+	char model[9];
 	unsigned int i;
 	u8 c;
 
