From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 26/30] ALSA: doc: ReSTize Bt87x.txt
Date: Thu, 10 Nov 2016 22:06:37 +0100
Message-ID: <20161110210641.5907-27-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E20C42673D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 10A45AE05
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
 .../sound/{alsa/Bt87x.txt => cards/bt87x.rst}      | 23 +++++++++++++---------
 Documentation/sound/cards/index.rst                |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)
 rename Documentation/sound/{alsa/Bt87x.txt => cards/bt87x.rst} (82%)

diff --git a/Documentation/sound/alsa/Bt87x.txt b/Documentation/sound/cards/bt87x.rst
similarity index 82%
rename from Documentation/sound/alsa/Bt87x.txt
rename to Documentation/sound/cards/bt87x.rst
index f158cde8b065..912732d3ef9e 100644
--- a/Documentation/sound/alsa/Bt87x.txt
+++ b/Documentation/sound/cards/bt87x.rst
@@ -1,18 +1,23 @@
+=================
+ALSA BT87x Driver
+=================
+
 Intro
 =====
 
 You might have noticed that the bt878 grabber cards have actually
-_two_ PCI functions:
+*two* PCI functions:
+::
 
-$ lspci
-[ ... ]
-00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
-00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
-[ ... ]
+  $ lspci
+  [ ... ]
+  00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
+  00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
+  [ ... ]
 
 The first does video, it is backward compatible to the bt848.  The second
 does audio.  snd-bt87x is a driver for the second function.  It's a sound
-driver which can be used for recording sound (and _only_ recording, no
+driver which can be used for recording sound (and *only* recording, no
 playback).  As most TV cards come with a short cable which can be plugged
 into your sound card's line-in you probably don't need this driver if all
 you want to do is just watching TV...
@@ -30,9 +35,9 @@ The driver is now stable.  However, it doesn't know about many TV cards,
 and it refuses to load for cards it doesn't know.
 
 If the driver complains ("Unknown TV card found, the audio driver will
-not load"), you can specify the load_all=1 option to force the driver to
+not load"), you can specify the ``load_all=1`` option to force the driver to
 try to use the audio capture function of your card.  If the frequency of
-recorded data is not right, try to specify the digital_rate option with
+recorded data is not right, try to specify the ``digital_rate`` option with
 other values than the default 32000 (often it's 44100 or 64000).
 
 If you have an unknown card, please mail the ID and board name to
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index 0006bc547bb8..157372faae06 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -12,3 +12,4 @@ Card-Specific Information
    via82xx-mixer
    audiophile-usb
    mixart
+   bt87x
-- 
2.10.2
