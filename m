From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] remove SND_GUS_SYNTH
Date: Thu, 5 Jun 2008 21:22:25 +0300
Message-ID: <20080605182223.GA1469@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1B224366
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 20:23:02 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org, "Robert P. J. Day" <rpjday@crashcourse.ca>
List-Id: alsa-devel@alsa-project.org

After the removal of the sequencer instrument layer SND_GUS_SYNTH was 
no longer used.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 sound/isa/Kconfig |    8 --------
 1 file changed, 8 deletions(-)

9f6d64c22381f740863d4460acb037620b591ed4 diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 2639a6a..ecbf42a 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -204,15 +204,11 @@ config SND_SC6000
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-sc6000.
 
-config SND_GUS_SYNTH
-	tristate
-
 config SND_GUSCLASSIC
 	tristate "Gravis UltraSound Classic"
 	depends on SND
 	select SND_RAWMIDI
 	select SND_PCM
-	select SND_GUS_SYNTH
 	help
 	  Say Y here to include support for Gravis UltraSound Classic
 	  soundcards.
@@ -226,7 +222,6 @@ config SND_GUSEXTREME
 	select SND_HWDEP
 	select SND_MPU401_UART
 	select SND_PCM
-	select SND_GUS_SYNTH
 	help
 	  Say Y here to include support for Gravis UltraSound Extreme
 	  soundcards.
@@ -239,7 +234,6 @@ config SND_GUSMAX
 	depends on SND
 	select SND_RAWMIDI
 	select SND_CS4231_LIB
-	select SND_GUS_SYNTH
 	help
 	  Say Y here to include support for Gravis UltraSound MAX
 	  soundcards.
@@ -252,7 +246,6 @@ config SND_INTERWAVE
 	depends on SND && PNP && ISA
 	select SND_RAWMIDI
 	select SND_CS4231_LIB
-	select SND_GUS_SYNTH
 	help
 	  Say Y here to include support for AMD InterWave based
 	  soundcards (Gravis UltraSound Plug & Play, STB SoundRage32,
@@ -266,7 +259,6 @@ config SND_INTERWAVE_STB
 	depends on SND && PNP && ISA
 	select SND_RAWMIDI
 	select SND_CS4231_LIB
-	select SND_GUS_SYNTH
 	help
 	  Say Y here to include support for AMD InterWave based
 	  soundcards with a TEA6330T bass and treble regulator
