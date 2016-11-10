From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/30] ALSA: doc: ReSTize Joystick document
Date: Thu, 10 Nov 2016 22:06:29 +0100
Message-ID: <20161110210641.5907-19-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 924182673C9
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D02A1ADF6
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

A conversion from a simple text file.
A new subdirectory, cards, was created to contain the card-specific
information like this one.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/cards/index.rst                |  7 +++
 .../{alsa/Joystick.txt => cards/joystick.rst}      | 71 ++++++++++++----------
 Documentation/sound/index.rst                      |  1 +
 3 files changed, 46 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/sound/cards/index.rst
 rename Documentation/sound/{alsa/Joystick.txt => cards/joystick.rst} (56%)

diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
new file mode 100644
index 000000000000..e1f4b78c75d6
--- /dev/null
+++ b/Documentation/sound/cards/index.rst
@@ -0,0 +1,7 @@
+Card-Specific Information
+=========================
+
+.. toctree::
+   :maxdepth: 2
+
+   joystick
diff --git a/Documentation/sound/alsa/Joystick.txt b/Documentation/sound/cards/joystick.rst
similarity index 56%
rename from Documentation/sound/alsa/Joystick.txt
rename to Documentation/sound/cards/joystick.rst
index ccda41b10f8a..a6e468c81d02 100644
--- a/Documentation/sound/alsa/Joystick.txt
+++ b/Documentation/sound/cards/joystick.rst
@@ -1,7 +1,10 @@
+=======================================
 Analog Joystick Support on ALSA Drivers
 =======================================
-                          Oct. 14, 2003
-           Takashi Iwai <tiwai@suse.de>
+
+Oct. 14, 2003
+
+Takashi Iwai <tiwai@suse.de>
 
 General
 -------
@@ -34,44 +37,46 @@ stability and the resource management.
 
 The following PCI drivers support the joystick natively.
 
-    Driver	Module Option	Available Values
-    ---------------------------------------------------------------------------
-    als4000	joystick_port	0 = disable (default), 1 = auto-detect,
-                                manual: any address (e.g. 0x200)
-    au88x0	N/A		N/A
-    azf3328	joystick	0 = disable, 1 = enable, -1 = auto (default)
-    ens1370	joystick	0 = disable (default), 1 = enable
-    ens1371	joystick_port	0 = disable (default), 1 = auto-detect,
-                                manual: 0x200, 0x208, 0x210, 0x218
-    cmipci	joystick_port	0 = disable (default), 1 = auto-detect,
-                                manual: any address (e.g. 0x200)
-    cs4281	N/A		N/A
-    cs46xx	N/A		N/A
-    es1938	N/A		N/A
-    es1968	joystick	0 = disable (default), 1 = enable
-    sonicvibes	N/A		N/A
-    trident	N/A		N/A
-    via82xx(*1)	joystick	0 = disable (default), 1 = enable
-    ymfpci	joystick_port	0 = disable (default), 1 = auto-detect,
-                                manual: 0x201, 0x202, 0x204, 0x205(*2)
-    ---------------------------------------------------------------------------
-
-    *1)  VIA686A/B only
-    *2)  With YMF744/754 chips, the port address can be chosen arbitrarily
+==============	=============	============================================
+Driver		Module Option	Available Values
+==============	=============	============================================
+als4000		joystick_port	0 = disable (default), 1 = auto-detect,
+	                        manual: any address (e.g. 0x200)
+au88x0		N/A		N/A
+azf3328		joystick	0 = disable, 1 = enable, -1 = auto (default)
+ens1370		joystick	0 = disable (default), 1 = enable
+ens1371		joystick_port	0 = disable (default), 1 = auto-detect,
+	                        manual: 0x200, 0x208, 0x210, 0x218
+cmipci		joystick_port	0 = disable (default), 1 = auto-detect,
+	                        manual: any address (e.g. 0x200)
+cs4281		N/A		N/A
+cs46xx		N/A		N/A
+es1938		N/A		N/A
+es1968		joystick	0 = disable (default), 1 = enable
+sonicvibes	N/A		N/A
+trident		N/A		N/A
+via82xx [#f1]_	joystick	0 = disable (default), 1 = enable
+ymfpci		joystick_port	0 = disable (default), 1 = auto-detect,
+	                        manual: 0x201, 0x202, 0x204, 0x205 [#f2]_
+==============	=============	============================================
+
+.. [#f1] VIA686A/B only
+.. [#f2] With YMF744/754 chips, the port address can be chosen arbitrarily
 
 The following drivers don't support gameport natively, but there are
 additional modules.  Load the corresponding module to add the gameport
 support.
 
-    Driver	Additional Module
-    -----------------------------
-    emu10k1	emu10k1-gp
-    fm801	fm801-gp
-    -----------------------------
+=======	=================
+Driver	Additional Module
+=======	=================
+emu10k1	emu10k1-gp
+fm801	fm801-gp
+=======	=================
 
 Note: the "pcigame" and "cs461x" modules are for the OSS drivers only.
-      These ALSA drivers (cs46xx, trident and au88x0) have the
-      built-in gameport support.
+These ALSA drivers (cs46xx, trident and au88x0) have the
+built-in gameport support.
 
 As mentioned above, ALSA PCI drivers have the built-in gameport
 support, so you don't have to load ns558 module.  Just load "joydev"
diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index e9fbbfff9d0d..1f5d166f81c4 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -9,6 +9,7 @@ Linux Sound Subsystem Documentation
    designs/index
    alsa-configuration
    hd-audio/index
+   cards/index
 
 .. only::  subproject
 
-- 
2.10.2
