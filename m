From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: Make CONFIG_SND_OSSEMUL
	user-selectable
Date: Fri,  9 Jun 2017 17:12:48 +0200
Message-ID: <20170609151252.704-2-tiwai@suse.de>
References: <20170609151252.704-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E81926765C
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 17:12:53 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 82B6BAE18
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 15:12:53 +0000 (UTC)
In-Reply-To: <20170609151252.704-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Currently CONFIG_SND_OSSEMUL is selected by each config like
CONFIG_SND_PCM_OSS.  But, as see in the raw MIDI code that is built
conditionally with CONFIG_SND_OSSEMUL, we should rather make
CONFIG_SND_OSSEMUL user-selectable as the top kconfig item, and leave
the rest depending on it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 9749f9e8b45c..3a9afc520d4e 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -59,12 +59,14 @@ config SND_SEQ_DUMMY
 	  will be called snd-seq-dummy.
 
 config SND_OSSEMUL
+	bool "Enable OSS Emulation"
 	select SOUND_OSS_CORE
-	bool
+	help
+	  This option enables the build of OSS emulation layer.
 
 config SND_MIXER_OSS
 	tristate "OSS Mixer API"
-	select SND_OSSEMUL
+	depends on SND_OSSEMUL
 	help
 	  To enable OSS mixer API emulation (/dev/mixer*), say Y here
 	  and read <file:Documentation/sound/alsa/OSS-Emulation.txt>.
@@ -76,7 +78,7 @@ config SND_MIXER_OSS
 
 config SND_PCM_OSS
 	tristate "OSS PCM (digital audio) API"
-	select SND_OSSEMUL
+	depends on SND_OSSEMUL
 	select SND_PCM
 	help
 	  To enable OSS digital audio (PCM) emulation (/dev/dsp*), say Y
@@ -110,7 +112,7 @@ config SND_PCM_TIMER
 config SND_SEQUENCER_OSS
 	bool "OSS Sequencer API"
 	depends on SND_SEQUENCER
-	select SND_OSSEMUL
+	depends on SND_OSSEMUL
 	help
 	  Say Y here to enable OSS sequencer emulation (both
 	  /dev/sequencer and /dev/music interfaces).
-- 
2.13.1
