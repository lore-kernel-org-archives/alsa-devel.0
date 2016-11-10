From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 27/30] ALSA: doc: ReSTize README.maya44
Date: Thu, 10 Nov 2016 22:06:38 +0100
Message-ID: <20161110210641.5907-28-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E33092673D6
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 08CCCAE04
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:54 +0000 (UTC)
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

Another	simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/cards/index.rst                |   1 +
 .../sound/{alsa/README.maya44 => cards/maya44.rst} | 137 ++++++++++++---------
 2 files changed, 81 insertions(+), 57 deletions(-)
 rename Documentation/sound/{alsa/README.maya44 => cards/maya44.rst} (65%)

diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index 157372faae06..6c8e4141df9a 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -13,3 +13,4 @@ Card-Specific Information
    audiophile-usb
    mixart
    bt87x
+   maya44
diff --git a/Documentation/sound/alsa/README.maya44 b/Documentation/sound/cards/maya44.rst
similarity index 65%
rename from Documentation/sound/alsa/README.maya44
rename to Documentation/sound/cards/maya44.rst
index 67b2ea1cc31d..bf09a584b443 100644
--- a/Documentation/sound/alsa/README.maya44
+++ b/Documentation/sound/cards/maya44.rst
@@ -1,10 +1,18 @@
-NOTE: The following is the original document of Rainer's patch that the
-current maya44 code based on.  Some contents might be obsoleted, but I
-keep here as reference -- tiwai
+=================================
+Notes on Maya44 USB Audio Support
+=================================
 
-----------------------------------------------------------------
+.. note::
+   The following is the original document of Rainer's patch that the
+   current maya44 code based on.  Some contents might be obsoleted, but I
+   keep here as reference -- tiwai
+
+Feb 14, 2008
+
+Rainer Zimmermann <mail@lightshed.de>
  
-STATE OF DEVELOPMENT:
+STATE OF DEVELOPMENT
+====================
 
 This driver is being developed on the initiative of Piotr Makowski (oponek@gmail.com) and financed by Lars Bergmann.
 Development is carried out by Rainer Zimmermann (mail@lightshed.de).
@@ -44,16 +52,17 @@ Things that do not seem to work:
 - Ardour 2.1 seems to work only via JACK, not using ALSA directly or via OSS. This still needs to be tracked down.
 
 
-DRIVER DETAILS:
+DRIVER DETAILS
+==============
 
 the following files were added:
 
-pci/ice1724/maya44.c        - Maya44 specific code
-pci/ice1724/maya44.h
-pci/ice1724/ice1724.patch
-pci/ice1724/ice1724.h.patch - PROPOSED patch to ice1724.h (see SAMPLING RATES)
-i2c/other/wm8776.c  - low-level access routines for Wolfson WM8776 codecs 
-include/wm8776.h
+* pci/ice1724/maya44.c - Maya44 specific code
+* pci/ice1724/maya44.h
+* pci/ice1724/ice1724.patch
+* pci/ice1724/ice1724.h.patch - PROPOSED patch to ice1724.h (see SAMPLING RATES)
+* i2c/other/wm8776.c - low-level access routines for Wolfson WM8776 codecs 
+* include/wm8776.h
 
 
 Note that the wm8776.c code is meant to be card-independent and does not actually register the codec with the ALSA infrastructure.
@@ -62,25 +71,26 @@ This is done in maya44.c, mainly because some of the WM8776 controls are used in
 
 the following files were created in pci/ice1724, simply #including the corresponding file from the alsa-kernel tree:
 
-wtm.h
-vt1720_mobo.h
-revo.h
-prodigy192.h
-pontis.h
-phase.h
-maya44.h
-juli.h
-aureon.h
-amp.h
-envy24ht.h
-se.h
-prodigy_hifi.h
+* wtm.h
+* vt1720_mobo.h
+* revo.h
+* prodigy192.h
+* pontis.h
+* phase.h
+* maya44.h
+* juli.h
+* aureon.h
+* amp.h
+* envy24ht.h
+* se.h
+* prodigy_hifi.h
 
 
 *I hope this is the correct way to do things.*
 
 
-SAMPLING RATES:
+SAMPLING RATES
+==============
 
 The Maya44 card (or more exactly, the Wolfson WM8776 codecs) allow a maximum sampling rate of 192 kHz for playback and 92 kHz for capture.
 
@@ -98,66 +108,79 @@ I propose some additional code for limiting the sampling rate when setting on a
 The proposed code (currently deactivated) is in ice1712.h.patch, ice1724.c and maya44.c (in pci/ice1712).
 
 
-SOUND DEVICES:
+SOUND DEVICES
+=============
 
 PCM devices correspond to inputs/outputs as follows (assuming Maya44 is card #0):
 
-hw:0,0 input - stereo, analog input 1+2
-hw:0,0 output - stereo, analog output 1+2
-hw:0,1 input - stereo, analog input 3+4 OR S/PDIF input
-hw:0,1 output - stereo, analog output 3+4 (and SPDIF out)
+* hw:0,0 input - stereo, analog input 1+2
+* hw:0,0 output - stereo, analog output 1+2
+* hw:0,1 input - stereo, analog input 3+4 OR S/PDIF input
+* hw:0,1 output - stereo, analog output 3+4 (and SPDIF out)
 
 
-NAMING OF MIXER CONTROLS:
+NAMING OF MIXER CONTROLS
+========================
 
 (for more information about the signal flow, please refer to the block diagram on p.24 of the ESI Maya44 manual, or in the ESI windows software).
 
 
-PCM: (digital) output level for channel 1+2
-PCM 1: same for channel 3+4
+PCM
+    (digital) output level for channel 1+2
+PCM 1
+    same for channel 3+4
+
+Mic Phantom+48V
+    switch for +48V phantom power for electrostatic microphones on input 1/2.
 
-Mic Phantom+48V: switch for +48V phantom power for electrostatic microphones on input 1/2.
     Make sure this is not turned on while any other source is connected to input 1/2.
     It might damage the source and/or the maya44 card.
 
-Mic/Line input: if switch is on, input jack 1/2 is microphone input (mono), otherwise line input (stereo).
+Mic/Line input
+    if switch is on, input jack 1/2 is microphone input (mono), otherwise line input (stereo).
+
+Bypass
+    analogue bypass from ADC input to output for channel 1+2. Same as "Monitor" in the windows driver.
+Bypass 1
+    same for channel 3+4.
 
-Bypass: analogue bypass from ADC input to output for channel 1+2. Same as "Monitor" in the windows driver.
-Bypass 1: same for channel 3+4.
+Crossmix
+    cross-mixer from channels 1+2 to channels 3+4
+Crossmix 1
+    cross-mixer from channels 3+4 to channels 1+2
 
-Crossmix: cross-mixer from channels 1+2 to channels 3+4
-Crossmix 1: cross-mixer from channels 3+4 to channels 1+2
+IEC958 Output
+    switch for S/PDIF output.
 
-IEC958 Output: switch for S/PDIF output.
     This is not supported by the ESI windows driver.
     S/PDIF should output the same signal as channel 3+4. [untested!]
 
 
-Digitial output selectors:
-
+Digitial output selectors
     These switches allow a direct digital routing from the ADCs to the DACs.
     Each switch determines where the digital input data to one of the DACs comes from.
     They are not supported by the ESI windows driver.
     For normal operation, they should all be set to "PCM out".
 
-H/W: Output source channel 1
-H/W 1: Output source channel 2
-H/W 2: Output source channel 3
-H/W 3: Output source channel 4
+H/W
+    Output source channel 1
+H/W 1
+    Output source channel 2
+H/W 2
+    Output source channel 3
+H/W 3
+    Output source channel 4
+
+H/W 4 ... H/W 9
+    unknown function, left in to enable testing.
 
-H/W 4 ... H/W 9: unknown function, left in to enable testing.
     Possibly some of these control S/PDIF output(s).
     If these turn out to be unused, they will go away in later driver versions.
 
 Selectable values for each of the digital output selectors are:
-   "PCM out" -> DAC output of the corresponding channel (default setting)
-   "Input 1"...
-   "Input 4" -> direct routing from ADC output of the selected input channel
-
 
---------
-
-Feb 14, 2008
-Rainer Zimmermann
-mail@lightshed.de
+PCM out
+	DAC output of the corresponding channel (default setting)
+Input 1 ... Input 4
+	direct routing from ADC output of the selected input channel
 
-- 
2.10.2
