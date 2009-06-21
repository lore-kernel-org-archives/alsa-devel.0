From: Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH] via82xx: add option to disable 500ms delay in snd_via82xx_codec_wait
Date: Sun, 21 Jun 2009 19:50:48 +0100
Message-ID: <4A3E8108.5010001@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755423AbZFUSvC@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There's a large 500ms delay in snd_via82xx_codec_wait() that, at least
on my hardware, appears to be unnecessary. The rest of the init of
the card works without logging any warnings or errors and both audio
and mixer settings work.

This adds an "nodelay" parameter to disable this (undocumented in the
code) large delay improving bootup time by 489-500ms.

[    1.034217] initcall alsa_card_via82xx_init+0x0/0x16 returned 0 after 505757 usecs
vs.
[    0.533136] initcall alsa_card_via82xx_init+0x0/0x16 returned 0 after 15915 usecs

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 sound/pci/via82xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 1ef58c5..949fcaf 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -85,6 +85,7 @@ static int joystick;
 static int ac97_clock = 48000;
 static char *ac97_quirk;
 static int dxs_support;
+static int nodelay;
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for VIA 82xx bridge.");
@@ -102,6 +103,8 @@ module_param(ac97_quirk, charp, 0444);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 module_param(dxs_support, int, 0444);
 MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 = auto, 1 = enable, 2 = disable, 3 = 48k only, 4 = no VRA, 5 = enable any sample rate)");
+module_param(nodelay, int, 0444);
+MODULE_PARM_DESC(nodelay, "Disable 500ms init delay");
 
 /* just for backward compatibility */
 static int enable;
@@ -549,7 +552,8 @@ static void snd_via82xx_codec_wait(struct snd_ac97 *ac97)
 	int err;
 	err = snd_via82xx_codec_ready(chip, ac97->num);
 	/* here we need to wait fairly for long time.. */
-	msleep(500);
+	if (!nodelay)
+		msleep(500);
 }
 
 static void snd_via82xx_codec_write(struct snd_ac97 *ac97,
-- 
1.6.3.1

-- 
Simon Arlott
