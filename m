From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/30] ALSA: doc: ReSTize ControlNames.txt
Date: Thu, 10 Nov 2016 22:06:25 +0100
Message-ID: <20161110210641.5907-15-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9139A2673C7
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D54E2ADF8
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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

A simple conversion from a plain text file.
Put to designs subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/ControlNames.txt     | 107 -------------------
 Documentation/sound/designs/control-names.rst | 142 ++++++++++++++++++++++++++
 Documentation/sound/designs/index.rst         |   1 +
 3 files changed, 143 insertions(+), 107 deletions(-)
 delete mode 100644 Documentation/sound/alsa/ControlNames.txt
 create mode 100644 Documentation/sound/designs/control-names.rst

diff --git a/Documentation/sound/alsa/ControlNames.txt b/Documentation/sound/alsa/ControlNames.txt
deleted file mode 100644
index 3fc1cf50d28e..000000000000
--- a/Documentation/sound/alsa/ControlNames.txt
+++ /dev/null
@@ -1,107 +0,0 @@
-This document describes standard names of mixer controls.
-
-Syntax: [LOCATION] SOURCE [CHANNEL] [DIRECTION] FUNCTION
-
-DIRECTION:
-  <nothing>	(both directions)
-  Playback
-  Capture
-  Bypass Playback
-  Bypass Capture
-
-FUNCTION:
-  Switch	(on/off switch)
-  Volume
-  Route		(route control, hardware specific)
-
-CHANNEL:
-  <nothing>     (channel independent, or applies to all channels)
-  Front
-  Surround      (rear left/right in 4.0/5.1 surround)
-  CLFE
-  Center
-  LFE
-  Side          (side left/right for 7.1 surround)
-
-LOCATION:       (physical location of source)
-  Front
-  Rear
-  Dock          (docking station)
-  Internal
-
-SOURCE:
-  Master
-  Master Mono
-  Hardware Master
-  Speaker	(internal speaker)
-  Bass Speaker	(internal LFE speaker)
-  Headphone
-  Line Out
-  Beep		(beep generator)
-  Phone
-  Phone Input
-  Phone Output
-  Synth
-  FM
-  Mic
-  Headset Mic	(mic part of combined headset jack - 4-pin headphone + mic)
-  Headphone Mic	(mic part of either/or - 3-pin headphone or mic)
-  Line		(input only, use "Line Out" for output)
-  CD
-  Video
-  Zoom Video
-  Aux
-  PCM
-  PCM Pan
-  Loopback
-  Analog Loopback	(D/A -> A/D loopback)
-  Digital Loopback	(playback -> capture loopback - without analog path)
-  Mono
-  Mono Output
-  Multi
-  ADC
-  Wave
-  Music
-  I2S
-  IEC958
-  HDMI
-  SPDIF		(output only)
-  SPDIF In
-  Digital In
-  HDMI/DP	(either HDMI or DisplayPort)
-
-Exceptions (deprecated):
-  [Analogue|Digital] Capture Source
-  [Analogue|Digital] Capture Switch	(aka input gain switch)
-  [Analogue|Digital] Capture Volume	(aka input gain volume)
-  [Analogue|Digital] Playback Switch	(aka output gain switch)
-  [Analogue|Digital] Playback Volume	(aka output gain volume)
-  Tone Control - Switch
-  Tone Control - Bass
-  Tone Control - Treble
-  3D Control - Switch
-  3D Control - Center
-  3D Control - Depth
-  3D Control - Wide
-  3D Control - Space
-  3D Control - Level
-  Mic Boost [(?dB)]
-
-PCM interface:
-
-  Sample Clock Source	{ "Word", "Internal", "AutoSync" }
-  Clock Sync Status	{ "Lock", "Sync", "No Lock" }
-  External Rate		/* external capture rate */
-  Capture Rate		/* capture rate taken from external source */
-
-IEC958 (S/PDIF) interface:
-
-  IEC958 [...] [Playback|Capture] Switch	/* turn on/off the IEC958 interface */
-  IEC958 [...] [Playback|Capture] Volume	/* digital volume control */
-  IEC958 [...] [Playback|Capture] Default	/* default or global value - read/write */
-  IEC958 [...] [Playback|Capture] Mask		/* consumer and professional mask */
-  IEC958 [...] [Playback|Capture] Con Mask	/* consumer mask */
-  IEC958 [...] [Playback|Capture] Pro Mask	/* professional mask */
-  IEC958 [...] [Playback|Capture] PCM Stream	/* the settings assigned to a PCM stream */
-  IEC958 Q-subcode [Playback|Capture] Default	/* Q-subcode bits */
-  IEC958 Preamble [Playback|Capture] Default	/* burst preamble words (4*16bits) */
diff --git a/Documentation/sound/designs/control-names.rst b/Documentation/sound/designs/control-names.rst
new file mode 100644
index 000000000000..7fedd0f33cd9
--- /dev/null
+++ b/Documentation/sound/designs/control-names.rst
@@ -0,0 +1,142 @@
+===========================
+Standard ALSA Control Names
+===========================
+
+This document describes standard names of mixer controls.
+
+Standard Syntax
+---------------
+Syntax: [LOCATION] SOURCE [CHANNEL] [DIRECTION] FUNCTION
+
+
+DIRECTION
+~~~~~~~~~
+================	===============
+<nothing>		both directions
+Playback		one direction
+Capture			one direction
+Bypass Playback		one direction
+Bypass Capture		one direction
+================	===============
+
+FUNCTION
+~~~~~~~~
+========	=================================
+Switch		on/off switch
+Volume		amplifier
+Route		route control, hardware specific
+========	=================================
+
+CHANNEL
+~~~~~~~
+============	==================================================
+<nothing>	channel independent, or applies to all channels
+Front		front left/right channels
+Surround	rear left/right in 4.0/5.1 surround
+CLFE		C/LFE channels
+Center		center cannel
+LFE		LFE channel
+Side		side left/right for 7.1 surround
+============	==================================================
+
+LOCATION (Physical location of source)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+============	=====================
+Front		front position
+Rear		rear position
+Dock		on docking station
+Internal	internal
+============	=====================
+
+SOURCE
+~~~~~~
+===================	=================================================
+Master
+Master Mono
+Hardware Master
+Speaker			internal speaker
+Bass Speaker		internal LFE speaker
+Headphone
+Line Out
+Beep			beep generator
+Phone
+Phone Input
+Phone Output
+Synth
+FM
+Mic
+Headset Mic		mic part of combined headset jack - 4-pin
+			headphone + mic
+Headphone Mic		mic part of either/or - 3-pin headphone or mic
+Line			input only, use "Line Out" for output
+CD
+Video
+Zoom Video
+Aux
+PCM
+PCM Pan
+Loopback
+Analog Loopback		D/A -> A/D loopback
+Digital Loopback	playback -> capture loopback -
+			without analog path
+Mono
+Mono Output
+Multi
+ADC
+Wave
+Music
+I2S
+IEC958
+HDMI
+SPDIF			output only
+SPDIF In
+Digital In
+HDMI/DP			either HDMI or DisplayPort
+===================	=================================================
+
+Exceptions (deprecated)
+-----------------------
+
+=====================================	=======================
+[Analogue|Digital] Capture Source
+[Analogue|Digital] Capture Switch	aka input gain switch
+[Analogue|Digital] Capture Volume	aka input gain volume
+[Analogue|Digital] Playback Switch	aka output gain switch
+[Analogue|Digital] Playback Volume	aka output gain volume
+Tone Control - Switch
+Tone Control - Bass
+Tone Control - Treble
+3D Control - Switch
+3D Control - Center
+3D Control - Depth
+3D Control - Wide
+3D Control - Space
+3D Control - Level
+Mic Boost [(?dB)]
+=====================================	=======================
+
+PCM interface
+-------------
+
+===================	========================================
+Sample Clock Source	{ "Word", "Internal", "AutoSync" }
+Clock Sync Status	{ "Lock", "Sync", "No Lock" }
+External Rate		external capture rate
+Capture Rate		capture rate taken from external source
+===================	========================================
+
+IEC958 (S/PDIF) interface
+-------------------------
+
+============================================	======================================
+IEC958 [...] [Playback|Capture] Switch		turn on/off the IEC958 interface
+IEC958 [...] [Playback|Capture] Volume		digital volume control
+IEC958 [...] [Playback|Capture] Default		default or global value - read/write
+IEC958 [...] [Playback|Capture] Mask		consumer and professional mask
+IEC958 [...] [Playback|Capture] Con Mask	consumer mask
+IEC958 [...] [Playback|Capture] Pro Mask	professional mask
+IEC958 [...] [Playback|Capture] PCM Stream	the settings assigned to a PCM stream
+IEC958 Q-subcode [Playback|Capture] Default	Q-subcode bits
+
+IEC958 Preamble [Playback|Capture] Default	burst preamble words (4*16bits)
+============================================	======================================
diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
index 0ca3a6b0a5ce..e53a5fac0acf 100644
--- a/Documentation/sound/designs/index.rst
+++ b/Documentation/sound/designs/index.rst
@@ -4,6 +4,7 @@ Designs and Implementations
 .. toctree::
    :maxdepth: 2
 
+   control-names
    channel-mapping-api
    procfile
    powersave
-- 
2.10.2
