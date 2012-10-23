From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] sound: ice1712 build errors
Date: Tue, 23 Oct 2012 10:34:16 -0700
Message-ID: <5086D518.7050606@xenotime.net>
References: <20121023151951.d5573eb8990a372754f29bf3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20121023151951.d5573eb8990a372754f29bf3@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix build errors by using correct kconfig symbol name:

sound/pci/ice1712/psc724.c:417:5: error: 'struct snd_ice1712' has no member named 'pm_resume'
sound/pci/ice1712/psc724.c:418:5: error: 'struct snd_ice1712' has no member named 'pm_suspend_enabled'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: Ondrej Zary <linux@rainbow-software.org>
Cc:	Jaroslav Kysela <perex@perex.cz>
Cc:	Takashi Iwai <tiwai@suse.de>
Cc:	alsa-devel@alsa-project.org
---
 sound/pci/ice1712/psc724.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20121023.orig/sound/pci/ice1712/psc724.c
+++ linux-next-20121023/sound/pci/ice1712/psc724.c
@@ -413,7 +413,7 @@ static int __devinit psc724_init(struct
 	snd_wm8776_init(&spec->wm8776);
 	spec->wm8766.ops.write = psc724_wm8766_write;
 	spec->wm8766.card = ice->card;
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	ice->pm_resume = psc724_resume;
 	ice->pm_suspend_enabled = 1;
 #endif
