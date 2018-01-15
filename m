From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound/pci/hda: depends on instead of select for INPUT
Date: Sun, 14 Jan 2018 21:11:56 -0800
Message-ID: <254bab8e-5629-0dc0-5a4e-9a010abf9ad8@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Drivers should not 'select' a subsystem. Instead they should depend
on it. If the subsystem is disabled, the user probably did that for
a purpose and one driver shouldn't be changing that.

This also makes all sound/ drivers consistent w.r.t depending on INPUT
instead of selecting it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org (moderated for non-subscribers)
---
 sound/pci/hda/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-415-rc8.orig/sound/pci/hda/Kconfig
+++ lnx-415-rc8/sound/pci/hda/Kconfig
@@ -87,8 +87,8 @@ config SND_HDA_PATCH_LOADER
 
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
+	depends on INPUT
 	select SND_HDA_GENERIC
-	select INPUT
 	help
 	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
