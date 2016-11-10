From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/30] ALSA: doc: ReSTize Procfile document
Date: Thu, 10 Nov 2016 22:06:20 +0100
Message-ID: <20161110210641.5907-10-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A3172673B4
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8BBF2ADE2
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

A simple conversion from a text file.

A new subidrectory, Documentation/sound/designs, was created to put
this document.  The other API design and implementation docuemnts
will be put to that directory in later commits.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/designs/index.rst              |   7 ++
 .../{alsa/Procfile.txt => designs/procfile.rst}    | 106 +++++++++++----------
 Documentation/sound/index.rst                      |   1 +
 3 files changed, 63 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/sound/designs/index.rst
 rename Documentation/sound/{alsa/Procfile.txt => designs/procfile.rst} (71%)

diff --git a/Documentation/sound/designs/index.rst b/Documentation/sound/designs/index.rst
new file mode 100644
index 000000000000..82d19fe3c380
--- /dev/null
+++ b/Documentation/sound/designs/index.rst
@@ -0,0 +1,7 @@
+Designs and Implementations
+===========================
+
+.. toctree::
+   :maxdepth: 2
+
+   procfile
diff --git a/Documentation/sound/alsa/Procfile.txt b/Documentation/sound/designs/procfile.rst
similarity index 71%
rename from Documentation/sound/alsa/Procfile.txt
rename to Documentation/sound/designs/procfile.rst
index 7f8a0d325905..29a466851fd2 100644
--- a/Documentation/sound/alsa/Procfile.txt
+++ b/Documentation/sound/designs/procfile.rst
@@ -1,20 +1,22 @@
-		Proc Files of ALSA Drivers
-		==========================
-		Takashi Iwai <tiwai@suse.de>
+==========================
+Proc Files of ALSA Drivers
+==========================
+
+Takashi Iwai <tiwai@suse.de>
 
 General
--------
+=======
 
 ALSA has its own proc tree, /proc/asound.  Many useful information are
 found in this tree.  When you encounter a problem and need debugging,
 check the files listed in the following sections.
 
 Each card has its subtree cardX, where X is from 0 to 7. The
-card-specific files are stored in the card* subdirectories.
+card-specific files are stored in the ``card*`` subdirectories.
 
 
 Global Information
-------------------
+==================
 
 cards
 	Shows the list of currently configured ALSA drivers,
@@ -31,15 +33,15 @@ devices
 
 meminfo
 	Shows the status of allocated pages via ALSA drivers.
-	Appears only when CONFIG_SND_DEBUG=y.
+	Appears only when ``CONFIG_SND_DEBUG=y``.
 
 hwdep
 	Lists the currently available hwdep devices in format of
-	<card>-<device>: <name>
+	``<card>-<device>: <name>``
 
 pcm
 	Lists the currently available PCM devices in format of
-	<card>-<device>: <id>: <name> : <sub-streams>
+	``<card>-<device>: <id>: <name> : <sub-streams>``
 
 timer
 	Lists the currently available timer devices
@@ -54,23 +56,23 @@ oss/sndstat
 
 
 Card Specific Files
--------------------
+===================
 
-The card-specific files are found in /proc/asound/card* directories.
+The card-specific files are found in ``/proc/asound/card*`` directories.
 Some drivers (e.g. cmipci) have their own proc entries for the
-register dump, etc (e.g. /proc/asound/card*/cmipci shows the register
+register dump, etc (e.g. ``/proc/asound/card*/cmipci`` shows the register
 dump).  These files would be really helpful for debugging.
 
 When PCM devices are available on this card, you can see directories
 like pcm0p or pcm1c.  They hold the PCM information for each PCM
-stream.  The number after 'pcm' is the PCM device number from 0, and
-the last 'p' or 'c' means playback or capture direction.  The files in
+stream.  The number after ``pcm`` is the PCM device number from 0, and
+the last ``p`` or ``c`` means playback or capture direction.  The files in
 this subtree is described later.
 
-The status of MIDI I/O is found in midi* files.  It shows the device
+The status of MIDI I/O is found in ``midi*`` files.  It shows the device
 name and the received/transmitted bytes through the MIDI device.
 
-When the card is equipped with AC97 codecs, there are codec97#*
+When the card is equipped with AC97 codecs, there are ``codec97#*``
 subdirectories (described later).
 
 When the OSS mixer emulation is enabled (and the module is loaded),
@@ -81,26 +83,27 @@ details.
 
 
 PCM Proc Files
---------------
+==============
 
-card*/pcm*/info
+``card*/pcm*/info``
 	The general information of this PCM device: card #, device #,
 	substreams, etc.
 
-card*/pcm*/xrun_debug
-	This file appears when CONFIG_SND_DEBUG=y and
-	CONFIG_PCM_XRUN_DEBUG=y.
+``card*/pcm*/xrun_debug``
+	This file appears when ``CONFIG_SND_DEBUG=y`` and
+	``CONFIG_PCM_XRUN_DEBUG=y``.
 	This shows the status of xrun (= buffer overrun/xrun) and
 	invalid PCM position debug/check of ALSA PCM middle layer.
 	It takes an integer value, can be changed by writing to this
-	file, such as
+	file, such as::
 
 		 # echo 5 > /proc/asound/card0/pcm0p/xrun_debug
 
 	The value consists of the following bit flags:
-	  bit 0 = Enable XRUN/jiffies debug messages
-	  bit 1 = Show stack trace at XRUN / jiffies check
-	  bit 2 = Enable additional jiffies check
+
+	* bit 0 = Enable XRUN/jiffies debug messages
+	* bit 1 = Show stack trace at XRUN / jiffies check
+	* bit 2 = Enable additional jiffies check
 
 	When the bit 0 is set, the driver will show the messages to
 	kernel log when an xrun is detected.  The debug message is
@@ -117,72 +120,74 @@ card*/pcm*/xrun_debug
 	buggy) hardware that doesn't give smooth pointer updates.
 	This feature is enabled via the bit 2.
 
-card*/pcm*/sub*/info
+``card*/pcm*/sub*/info``
 	The general information of this PCM sub-stream.
 
-card*/pcm*/sub*/status
+``card*/pcm*/sub*/status``
 	The current status of this PCM sub-stream, elapsed time,
 	H/W position, etc.
 
-card*/pcm*/sub*/hw_params
+``card*/pcm*/sub*/hw_params``
 	The hardware parameters set for this sub-stream.
 
-card*/pcm*/sub*/sw_params
+``card*/pcm*/sub*/sw_params``
 	The soft parameters set for this sub-stream.
 
-card*/pcm*/sub*/prealloc
+``card*/pcm*/sub*/prealloc``
 	The buffer pre-allocation information.
 
-card*/pcm*/sub*/xrun_injection
+``card*/pcm*/sub*/xrun_injection``
 	Triggers an XRUN to the running stream when any value is
 	written to this proc file.  Used for fault injection.
 	This entry is write-only.
 
 AC97 Codec Information
-----------------------
+======================
 
-card*/codec97#*/ac97#?-?
+``card*/codec97#*/ac97#?-?``
 	Shows the general information of this AC97 codec chip, such as
 	name, capabilities, set up.
 
-card*/codec97#0/ac97#?-?+regs
+``card*/codec97#0/ac97#?-?+regs``
 	Shows the AC97 register dump.  Useful for debugging.
 
 	When CONFIG_SND_DEBUG is enabled, you can write to this file for
 	changing an AC97 register directly.  Pass two hex numbers.
 	For example,
 
+::
+
 	# echo 02 9f1f > /proc/asound/card0/codec97#0/ac97#0-0+regs
 
 
 USB Audio Streams
------------------
+=================
 
-card*/stream*
+``card*/stream*``
 	Shows the assignment and the current status of each audio stream
 	of the given card.  This information is very useful for debugging.
 
 
 HD-Audio Codecs
----------------
+===============
 
-card*/codec#*
+``card*/codec#*``
 	Shows the general codec information and the attribute of each
 	widget node.
 
-card*/eld#*
+``card*/eld#*``
 	Available for HDMI or DisplayPort interfaces.
 	Shows ELD(EDID Like Data) info retrieved from the attached HDMI sink,
 	and describes its audio capabilities and configurations.
 
-	Some ELD fields may be modified by doing `echo name hex_value > eld#*`.
+	Some ELD fields may be modified by doing ``echo name hex_value > eld#*``.
 	Only do this if you are sure the HDMI sink provided value is wrong.
 	And if that makes your HDMI audio work, please report to us so that we
 	can fix it in future kernel releases.
 
 
 Sequencer Information
----------------------
+=====================
 
 seq/drivers
 	Lists the currently available ALSA sequencer drivers.
@@ -203,7 +208,7 @@ seq/oss
 
 
 Help For Debugging?
--------------------
+===================
 
 When the problem is related with PCM, first try to turn on xrun_debug
 mode.  This will give you the kernel messages when and where xrun
@@ -211,24 +216,23 @@ happened.
 
 If it's really a bug, report it with the following information:
 
-  - the name of the driver/card, show in /proc/asound/cards
-  - the register dump, if available (e.g. card*/cmipci)
+- the name of the driver/card, show in ``/proc/asound/cards``
+- the register dump, if available (e.g. ``card*/cmipci``)
 
 when it's a PCM problem,
 
-  - set-up of PCM, shown in hw_parms, sw_params, and status in the PCM
-    sub-stream directory
+- set-up of PCM, shown in hw_parms, sw_params, and status in the PCM
+  sub-stream directory
 
 when it's a mixer problem,
 
-  - AC97 proc files, codec97#*/* files
+- AC97 proc files, ``codec97#*/*`` files
 
 for USB audio/midi,
 
-  - output of lsusb -v
-  - stream* files in card directory
+- output of ``lsusb -v``
+- ``stream*`` files in card directory
 
 
 The ALSA bug-tracking system is found at:
-
-    https://bugtrack.alsa-project.org/alsa-bug/
+https://bugtrack.alsa-project.org/alsa-bug/
diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 64fe47af05b6..e9fbbfff9d0d 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -6,6 +6,7 @@ Linux Sound Subsystem Documentation
    :maxdepth: 2
 
    kernel-api/index
+   designs/index
    alsa-configuration
    hd-audio/index
 
-- 
2.10.2
