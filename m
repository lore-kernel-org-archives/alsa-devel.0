From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 25/30] ALSA: doc: ReSTize MIXART.txt
Date: Thu, 10 Nov 2016 22:06:36 +0100
Message-ID: <20161110210641.5907-26-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BCF312673CE
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 06F64AE02
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

Another simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/cards/index.rst                |  1 +
 .../sound/{alsa/MIXART.txt => cards/mixart.rst}    | 26 +++++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)
 rename Documentation/sound/{alsa/MIXART.txt => cards/mixart.rst} (83%)

diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index e92a4f7e86fc..0006bc547bb8 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -11,3 +11,4 @@ Card-Specific Information
    emu10k1-jack
    via82xx-mixer
    audiophile-usb
+   mixart
diff --git a/Documentation/sound/alsa/MIXART.txt b/Documentation/sound/cards/mixart.rst
similarity index 83%
rename from Documentation/sound/alsa/MIXART.txt
rename to Documentation/sound/cards/mixart.rst
index 4ee35b4fbe4a..48aba98b088f 100644
--- a/Documentation/sound/alsa/MIXART.txt
+++ b/Documentation/sound/cards/mixart.rst
@@ -1,5 +1,8 @@
-    Alsa driver for Digigram miXart8 and miXart8AES/EBU soundcards
-	    Digigram <alsa@digigram.com>
+==============================================================
+Alsa driver for Digigram miXart8 and miXart8AES/EBU soundcards
+==============================================================
+
+Digigram <alsa@digigram.com>
 
 
 GENERAL
@@ -48,11 +51,15 @@ formats are supported.
 
 Mixer
 -----
-<Master> and <Master Capture> : analog volume control of playback and capture PCM.
-<PCM 0-3> and <PCM Capture> : digital volume control of each analog substream.
-<AES 0-3> and <AES Capture> : digital volume control of each AES/EBU substream.
-<Monitoring> : Loopback from 'pcm0c' to 'pcm0p' with digital volume
-and mute control.
+<Master> and <Master Capture>
+	analog volume control of playback and capture PCM.
+<PCM 0-3> and <PCM Capture>
+	digital volume control of each analog substream.
+<AES 0-3> and <AES Capture>
+	digital volume control of each AES/EBU substream.
+<Monitoring>
+	Loopback from 'pcm0c' to 'pcm0p' with digital volume
+	and mute control.
 
 Rem : for best audio quality try to keep a 0 attenuation on the PCM
 and AES volume controls which is set by 219 in the range from 0 to 255
@@ -79,11 +86,14 @@ FIRMWARE
 For loading the firmware automatically after the module is loaded, use a
 install command.  For example, add the following entry to
 /etc/modprobe.d/mixart.conf for miXart driver:
+::
 
 	install snd-mixart /sbin/modprobe --first-time -i snd-mixart && \
 			   /usr/bin/mixartloader
+
+
 (for 2.2/2.4 kernels, add "post-install snd-mixart /usr/bin/vxloader" to
- /etc/modules.conf, instead.)
+/etc/modules.conf, instead.)
 
 The firmware binaries are installed on /usr/share/alsa/firmware
 (or /usr/local/share/alsa/firmware, depending to the prefix option of
-- 
2.10.2
