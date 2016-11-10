From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/30] ALSA: doc: ReSTize CMIPCI document
Date: Thu, 10 Nov 2016 22:06:30 +0100
Message-ID: <20161110210641.5907-20-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DDE7E2673D0
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3A54ADFB
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
Put to cards subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../sound/{alsa/CMIPCI.txt => cards/cmipci.rst}    | 62 ++++++++++++++--------
 Documentation/sound/cards/index.rst                |  1 +
 2 files changed, 41 insertions(+), 22 deletions(-)
 rename Documentation/sound/{alsa/CMIPCI.txt => cards/cmipci.rst} (86%)

diff --git a/Documentation/sound/alsa/CMIPCI.txt b/Documentation/sound/cards/cmipci.rst
similarity index 86%
rename from Documentation/sound/alsa/CMIPCI.txt
rename to Documentation/sound/cards/cmipci.rst
index 4e36e6e809ca..9ea1de6ec4ce 100644
--- a/Documentation/sound/alsa/CMIPCI.txt
+++ b/Documentation/sound/cards/cmipci.rst
@@ -1,7 +1,8 @@
-         Brief Notes on C-Media 8338/8738/8768/8770 Driver
-         =================================================
+=================================================
+Brief Notes on C-Media 8338/8738/8768/8770 Driver
+=================================================
 
-                   Takashi Iwai <tiwai@suse.de>
+Takashi Iwai <tiwai@suse.de>
 
 
 Front/Rear Multi-channel Playback
@@ -30,19 +31,20 @@ The rear output can be heard only when "Four Channel Mode" switch is
 disabled.  Otherwise no signal will be routed to the rear speakers.
 As default it's turned on.
 
-*** WARNING ***
-When "Four Channel Mode" switch is off, the output from rear speakers
-will be FULL VOLUME regardless of Master and PCM volumes.
-This might damage your audio equipment.  Please disconnect speakers
-before your turn off this switch.
-*** WARNING ***
+.. WARNING::
+  When "Four Channel Mode" switch is off, the output from rear speakers
+  will be FULL VOLUME regardless of Master and PCM volumes [#]_.
+  This might damage your audio equipment.  Please disconnect speakers
+  before your turn off this switch.
 
-[ Well.. I once got the output with correct volume (i.e. same with the
+
+.. [#]
+  Well.. I once got the output with correct volume (i.e. same with the
   front one) and was so excited.  It was even with "Four Channel" bit
   on and "double DAC" mode.  Actually I could hear separate 4 channels
   from front and rear speakers!  But.. after reboot, all was gone.
   It's a very pity that I didn't save the register dump at that
-  time..  Maybe there is an unknown register to achieve this... ]
+  time..  Maybe there is an unknown register to achieve this...
 
 If your card has an extra output jack for the rear output, the rear
 playback should be routed there as default.  If not, there is a
@@ -73,12 +75,14 @@ cannot operate with full-duplex.
 
 The 4.0 and 5.1 modes are defined as the pcm "surround40" and "surround51"
 in alsa-lib.  For example, you can play a WAV file with 6 channels like
+::
 
 	% aplay -Dsurround51 sixchannels.wav
 
 For programming the 4/6 channel playback, you need to specify the PCM
 channels as you like and set the format S16LE.  For example, for playback
 with 4 channels,
+::
 
 	snd_pcm_hw_params_set_access(pcm, hw, SND_PCM_ACCESS_RW_INTERLEAVED);
 	    // or mmap if you like
@@ -89,13 +93,15 @@ and use the interleaved 4 channel data.
 
 There are some control switches affecting to the speaker connections:
 
-"Line-In Mode"	- an enum control to change the behavior of line-in
+Line-In Mode
+	an enum control to change the behavior of line-in
 	jack.  Either "Line-In", "Rear Output" or "Bass Output" can
 	be selected.  The last item is available only with model 039
 	or newer. 
 	When "Rear Output" is chosen, the surround channels 3 and 4
 	are output to line-in jack.
-"Mic-In Mode"	- an enum control to change the behavior of mic-in
+Mic-In Mode
+	an enum control to change the behavior of mic-in
 	jack.  Either "Mic-In" or "Center/LFE Output" can be
 	selected. 
 	When "Center/LFE Output" is chosen, the center and bass
@@ -111,11 +117,14 @@ The SPDIF playback and capture are done via the third PCM device
 (hw:0,2).  Usually this is assigned to the PCM device "spdif".
 The available rates are 44100 and 48000 Hz.
 For playback with aplay, you can run like below:
+::
 
 	% aplay -Dhw:0,2 foo.wav
 
 or
 
+::
+
 	% aplay -Dspdif foo.wav
 
 24bit format is also supported experimentally.
@@ -140,31 +149,40 @@ off.  (Also don't forget to turn on "IEC958 Output Switch", too.)
 
 Additionally there are relevant control switches:
 
-"IEC958 Mix Analog" - Mix analog PCM playback and FM-OPL/3 streams and
+IEC958 Mix Analog
+	Mix analog PCM playback and FM-OPL/3 streams and
 	output through SPDIF.  This switch appears only on old chip
 	models (CM8738 033 and 037).
+
 	Note: without this control you can output PCM to SPDIF.
 	This is "mixing" of streams, so e.g. it's not for AC3 output
 	(see the next section).
 
-"IEC958 In Select"  - Select SPDIF input, the internal CD-in (false)
+IEC958 In Select
+	Select SPDIF input, the internal CD-in (false)
 	and the external input (true).
 
-"IEC958 Loop"       - SPDIF input data is loop back into SPDIF
+IEC958 Loop
+	SPDIF input data is loop back into SPDIF
 	output (aka bypass)
 
-"IEC958 Copyright"  - Set the copyright bit.
+IEC958 Copyright
+	Set the copyright bit.
 
-"IEC958 5V"         - Select 0.5V (coax) or 5V (optical) interface.
+IEC958 5V
+	Select 0.5V (coax) or 5V (optical) interface.
 	On some cards this doesn't work and you need to change the
 	configuration with hardware dip-switch.
 
-"IEC958 In Monitor" - SPDIF input is routed to DAC.
+IEC958 In Monitor
+	SPDIF input is routed to DAC.
 
-"IEC958 In Phase Inverse" - Set SPDIF input format as inverse.
+IEC958 In Phase Inverse
+	Set SPDIF input format as inverse.
 	[FIXME: this doesn't work on all chips..]
 
-"IEC958 In Valid"   - Set input validity flag detection.
+IEC958 In Valid
+	Set input validity flag detection.
 
 Note: When "PCM Playback Switch" is on, you'll hear the digital output
 stream through analog line-out.
@@ -217,7 +235,7 @@ to enable MIDI support.  Valid I/O ports are 0x300, 0x310, 0x320 and
 With CMI8738 and newer chips, the MIDI interface is enabled by default
 and the driver automatically chooses a port address.
 
-There is _no_ hardware wavetable function on this chip (except for
+There is *no* hardware wavetable function on this chip (except for
 OPL3 synth below).
 What's said as MIDI synth on Windows is a software synthesizer
 emulation.  On Linux use TiMidity or other softsynth program for
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index e1f4b78c75d6..67a3073157b9 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -5,3 +5,4 @@ Card-Specific Information
    :maxdepth: 2
 
    joystick
+   cmipci
-- 
2.10.2
