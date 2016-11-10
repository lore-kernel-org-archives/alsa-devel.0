From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/30] ALSA: doc: ReSTize HD-Audio-Controls
	document
Date: Thu, 10 Nov 2016 22:06:17 +0100
Message-ID: <20161110210641.5907-7-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C11A2673BC
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 90B23ADE3
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:52 +0000 (UTC)
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

A conversion from a simple text file.
Put to hd-audio subdirectory with a rename.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../controls.rst}                                  | 33 +++++++++++++---------
 Documentation/sound/hd-audio/index.rst             |  1 +
 2 files changed, 20 insertions(+), 14 deletions(-)
 rename Documentation/sound/{alsa/HD-Audio-Controls.txt => hd-audio/controls.rst} (92%)

diff --git a/Documentation/sound/alsa/HD-Audio-Controls.txt b/Documentation/sound/hd-audio/controls.rst
similarity index 92%
rename from Documentation/sound/alsa/HD-Audio-Controls.txt
rename to Documentation/sound/hd-audio/controls.rst
index e9621e349e17..f2ebc4f79b44 100644
--- a/Documentation/sound/alsa/HD-Audio-Controls.txt
+++ b/Documentation/sound/hd-audio/controls.rst
@@ -1,16 +1,21 @@
+======================================
+HD-Audio Codec-Specific Mixer Controls
+======================================
+
+
 This file explains the codec-specific mixer controls.
 
 Realtek codecs
 --------------
 
-* Channel Mode
+Channel Mode
   This is an enum control to change the surround-channel setup,
   appears only when the surround channels are available.
   It gives the number of channels to be used, "2ch", "4ch", "6ch",
   and "8ch".  According to the configuration, this also controls the
   jack-retasking of multi-I/O jacks.
 
-* Auto-Mute Mode
+Auto-Mute Mode
   This is an enum control to change the auto-mute behavior of the
   headphone and line-out jacks.  If built-in speakers and headphone
   and/or line-out jacks are available on a machine, this controls
@@ -30,24 +35,24 @@ Realtek codecs
 IDT/Sigmatel codecs
 -------------------
 
-* Analog Loopback
+Analog Loopback
   This control enables/disables the analog-loopback circuit.  This
   appears only when "loopback" is set to true in a codec hint
   (see HD-Audio.txt).  Note that on some codecs the analog-loopback
   and the normal PCM playback are exclusive, i.e. when this is on, you
   won't hear any PCM stream.
 
-* Swap Center/LFE
+Swap Center/LFE
   Swaps the center and LFE channel order.  Normally, the left
   corresponds to the center and the right to the LFE.  When this is
   ON, the left to the LFE and the right to the center.
 
-* Headphone as Line Out
+Headphone as Line Out
   When this control is ON, treat the headphone jacks as line-out
   jacks.  That is, the headphone won't auto-mute the other line-outs,
   and no HP-amp is set to the pins.
 
-* Mic Jack Mode, Line Jack Mode, etc
+Mic Jack Mode, Line Jack Mode, etc
   These enum controls the direction and the bias of the input jack
   pins.  Depending on the jack type, it can set as "Mic In" and "Line 
   In", for determining the input bias, or it can be set to "Line Out"
@@ -57,19 +62,19 @@ IDT/Sigmatel codecs
 VIA codecs
 ----------
 
-* Smart 5.1
+Smart 5.1
   An enum control to re-task the multi-I/O jacks for surround outputs.
   When it's ON, the corresponding input jacks (usually a line-in and a
   mic-in) are switched as the surround and the CLFE output jacks.
 
-* Independent HP
+Independent HP
   When this enum control is enabled, the headphone output is routed
   from an individual stream (the third PCM such as hw:0,2) instead of
   the primary stream.  In the case the headphone DAC is shared with a
   side or a CLFE-channel DAC, the DAC is switched to the headphone
   automatically.
 
-* Loopback Mixing
+Loopback Mixing
   An enum control to determine whether the analog-loopback route is
   enabled or not.  When it's enabled, the analog-loopback is mixed to
   the front-channel.  Also, the same route is used for the headphone
@@ -78,7 +83,7 @@ VIA codecs
   headphones and speakers because there is only one DAC connected to a
   mixer widget.
 
-* Dynamic Power-Control
+Dynamic Power-Control
   This control determines whether the dynamic power-control per jack
   detection is enabled or not.  When enabled, the widgets power state
   (D0/D3) are changed dynamically depending on the jack plugging
@@ -86,7 +91,7 @@ VIA codecs
   doesn't provide a proper jack-detection, this won't work; in such a
   case, turn this control OFF.
 
-* Jack Detect
+Jack Detect
   This control is provided only for VT1708 codec which gives no proper
   unsolicited event per jack plug.  When this is on, the driver polls
   the jack detection so that the headphone auto-mute can work, while 
@@ -96,21 +101,21 @@ VIA codecs
 Conexant codecs
 ---------------
 
-* Auto-Mute Mode
+Auto-Mute Mode
   See Reatek codecs.
 
 
 Analog codecs
 --------------
 
-* Channel Mode
+Channel Mode
   This is an enum control to change the surround-channel setup,
   appears only when the surround channels are available.
   It gives the number of channels to be used, "2ch", "4ch" and "6ch".
   According to the configuration, this also controls the
   jack-retasking of multi-I/O jacks.
 
-* Independent HP
+Independent HP
   When this enum control is enabled, the headphone output is routed
   from an individual stream (the third PCM such as hw:0,2) instead of
   the primary stream.
diff --git a/Documentation/sound/hd-audio/index.rst b/Documentation/sound/hd-audio/index.rst
index 1e8376b0066c..c6efd55a219f 100644
--- a/Documentation/sound/hd-audio/index.rst
+++ b/Documentation/sound/hd-audio/index.rst
@@ -6,3 +6,4 @@ HD-Audio
 
    notes
    models
+   controls
-- 
2.10.2
