From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: update Kconfig description about
	SoundScape cards
Date: Thu, 29 Jan 2009 11:44:24 +0100
Message-ID: <20090129114424.79ca641b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id E6921103851
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 11:40:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The SoundScape driver handles more cards then described.
---
 sound/isa/Kconfig |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index cf6c01d..7d80186 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -378,14 +378,17 @@ config SND_SGALAXY
 	  will be called snd-sgalaxy.
 
 config SND_SSCAPE
-	tristate "Ensoniq SoundScape PnP driver"
+	tristate "Ensoniq SoundScape driver"
 	select SND_HWDEP
 	select SND_MPU401_UART
 	select SND_WSS_LIB
 	help
-	  Say Y here to include support for Ensoniq SoundScape PnP
+	  Say Y here to include support for Ensoniq SoundScape 
 	  soundcards.
 
+	  The PCM audio is supported on SoundScape Classic, Elite, PnP
+	  and VIVO cards. The MIDI support is very experimental.
+
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sscape.
 
-- 
1.5.2.2


----------------------------------------------------------------------
Promocja w Speak Up. 3 miesiace angielskiego gratis.
Sprawdz teraz i wypelnij formularz! >> http://link.interia.pl/f2019
