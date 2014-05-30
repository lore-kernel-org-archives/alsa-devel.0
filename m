From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: firewire: Fix dependency on PCM and
	rawmidi
Date: Fri, 30 May 2014 10:22:03 +0200
Message-ID: <1401438123-32192-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D2F0261685
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 10:22:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>, Jim Davis <jim.epost@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Now snd-firewire-lib supports rawmidi in addition to PCM, thus we need
to give a proper dependency.  For fixing and simplification, move the
selections of SND_PCM and SND_RAWMIDI into SND_FIREWIRE_LIB section.
Then each driver doesn't have to select them but only
SND_FIREWIRE_LIB.

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/firewire/Kconfig | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 9f363fac7688..775ef2efc296 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -9,12 +9,12 @@ if SND_FIREWIRE && FIREWIRE
 
 config SND_FIREWIRE_LIB
 	tristate
-	depends on SND_PCM
+	select SND_PCM
+	select SND_RAWMIDI
 
 config SND_DICE
 	tristate "DICE-based DACs (EXPERIMENTAL)"
 	select SND_HWDEP
-	select SND_PCM
 	select SND_FIREWIRE_LIB
 	help
 	  Say Y here to include support for many DACs based on the DICE
@@ -28,7 +28,6 @@ config SND_DICE
 
 config SND_FIREWIRE_SPEAKERS
 	tristate "FireWire speakers"
-	select SND_PCM
 	select SND_FIREWIRE_LIB
 	help
 	  Say Y here to include support for the Griffin FireWave Surround
@@ -39,7 +38,6 @@ config SND_FIREWIRE_SPEAKERS
 
 config SND_ISIGHT
 	tristate "Apple iSight microphone"
-	select SND_PCM
 	select SND_FIREWIRE_LIB
 	help
 	  Say Y here to include support for the front and rear microphones
@@ -50,8 +48,6 @@ config SND_ISIGHT
 
 config SND_SCS1X
 	tristate "Stanton Control System 1 MIDI"
-	select SND_PCM
-	select SND_RAWMIDI
 	select SND_FIREWIRE_LIB
 	help
 	  Say Y here to include support for the MIDI ports of the Stanton
@@ -64,8 +60,6 @@ config SND_SCS1X
 config SND_FIREWORKS
 	tristate "Echo Fireworks board module support"
 	select SND_FIREWIRE_LIB
-	select SND_RAWMIDI
-	select SND_PCM
 	select SND_HWDEP
 	help
 	  Say Y here to include support for FireWire devices based
@@ -82,8 +76,6 @@ config SND_FIREWORKS
 config SND_BEBOB
 	tristate "BridgeCo DM1000/DM1100/DM1500 with BeBoB firmware"
 	select SND_FIREWIRE_LIB
-	select SND_RAWMIDI
-	select SND_PCM
 	select SND_HWDEP
         help
 	 Say Y here to include support for FireWire devices based
-- 
1.9.3
