From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: [PATCH] ALSA: snd-usb-line6 depends on CONFIG_SND_HWDEP
Date: Tue, 20 Sep 2016 18:14:53 -0400
Message-ID: <86590.1474409693@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

ALSA - snd-usb-line6 depends on CONFIG_SND_HWDEP

ERROR: "snd_hwdep_new" [sound/usb/line6/snd-usb-line6.ko] undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed
make[1]: *** [__modpost] Error 1

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/sound/usb/line6/Kconfig b/sound/usb/line6/Kconfig
index 8ffcf48097d9..39b400392d71 100644
--- a/sound/usb/line6/Kconfig
+++ b/sound/usb/line6/Kconfig
@@ -2,6 +2,7 @@ config SND_USB_LINE6
 	tristate
 	select SND_RAWMIDI
 	select SND_PCM
+	select SND_HWDEP
 
 config SND_USB_POD
 	tristate "Line 6 POD USB support"
