From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 29/30] ALSA: doc: ReSTize serial-u16550.txt
Date: Thu, 10 Nov 2016 22:06:40 +0100
Message-ID: <20161110210641.5907-30-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DEAD62673D2
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DBA4CADF9
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

Yet another simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/cards/index.rst                 |  1 +
 .../serial-u16550.txt => cards/serial-u16550.rst}   | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)
 rename Documentation/sound/{alsa/serial-u16550.txt => cards/serial-u16550.rst} (92%)

diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index b143eff93c87..976ef5eb8f89 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -15,3 +15,4 @@ Card-Specific Information
    bt87x
    maya44
    hdspm
+   serial-u16550
diff --git a/Documentation/sound/alsa/serial-u16550.txt b/Documentation/sound/cards/serial-u16550.rst
similarity index 92%
rename from Documentation/sound/alsa/serial-u16550.txt
rename to Documentation/sound/cards/serial-u16550.rst
index c1919559d509..197aeacea3da 100644
--- a/Documentation/sound/alsa/serial-u16550.txt
+++ b/Documentation/sound/cards/serial-u16550.rst
@@ -1,14 +1,14 @@
-
-			Serial UART 16450/16550 MIDI driver
-			===================================
+===================================
+Serial UART 16450/16550 MIDI driver
+===================================
 
 The adaptor module parameter allows you to select either:
 
-  0 - Roland Soundcanvas support (default)
-  1 - Midiator MS-124T support (1)
-  2 - Midiator MS-124W S/A mode (2)
-  3 - MS-124W M/B mode support (3)
-  4 - Generic device with multiple input support (4)
+* 0 - Roland Soundcanvas support (default)
+* 1 - Midiator MS-124T support (1)
+* 2 - Midiator MS-124W S/A mode (2)
+* 3 - MS-124W M/B mode support (3)
+* 4 - Generic device with multiple input support (4)
 
 For the Midiator MS-124W, you must set the physical M-S and A-B
 switches on the Midiator to match the driver mode you select.
@@ -22,11 +22,13 @@ substream. The driver provides no way to send F5 00 (no selection) or to not
 send the F5 NN command sequence at all; perhaps it ought to.
 
 Usage example for simple serial converter:
+::
 
 	/sbin/setserial /dev/ttyS0 uart none
 	/sbin/modprobe snd-serial-u16550 port=0x3f8 irq=4 speed=115200
 
 Usage example for Roland SoundCanvas with 4 MIDI ports:
+::
 
 	/sbin/setserial /dev/ttyS0 uart none
 	/sbin/modprobe snd-serial-u16550 port=0x3f8 irq=4 outs=4
@@ -37,6 +39,7 @@ all four MIDI Out connectors.  Set the A-B switch and the speed module
 parameter to match (A=19200, B=9600).
 
 Usage example for MS-124T, with A-B switch in A position:
+::
 
 	/sbin/setserial /dev/ttyS0 uart none
 	/sbin/modprobe snd-serial-u16550 port=0x3f8 irq=4 adaptor=1 \
@@ -47,6 +50,7 @@ the outs module parameter is automatically set to 1. The driver sends
 the same data to all four MIDI Out connectors at full MIDI speed.
 
 Usage example for S/A mode:
+::
 
 	/sbin/setserial /dev/ttyS0 uart none
 	/sbin/modprobe snd-serial-u16550 port=0x3f8 irq=4 adaptor=2
@@ -63,6 +67,7 @@ at most one byte every 520 us, as compared with the full MIDI data rate of
 one byte every 320 us per port.
 
 Usage example for M/B mode:
+::
 
 	/sbin/setserial /dev/ttyS0 uart none
 	/sbin/modprobe snd-serial-u16550 port=0x3f8 irq=4 adaptor=3
-- 
2.10.2
