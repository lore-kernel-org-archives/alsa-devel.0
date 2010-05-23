From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 101/199] Documentation/sound/oss/README.modules: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:51 +0200
Message-ID: <1274644376-24176-9-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/README.modules:11: ERROR: trailing whitespace
Documentation/sound/oss/README.modules:13: ERROR: trailing whitespace
Documentation/sound/oss/README.modules:17: ERROR: trailing whitespace
Documentation/sound/oss/README.modules:18: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/README.modules |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/oss/README.modules b/Documentation/sound/oss/README.modules
index e691d74..a7cbf8a 100644
--- a/Documentation/sound/oss/README.modules
+++ b/Documentation/sound/oss/README.modules
@@ -8,14 +8,14 @@ making sound modular.
   First, configure your kernel. This is an idea of what you should be
 setting in the sound section:
 
-<M> Sound card support 
+<M> Sound card support
 
-<M> 100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support 
+<M> 100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support
 
   I have SoundBlaster. Select your card from the list.
 
-<M> Generic OPL2/OPL3 FM synthesizer support 
-<M> FM synthesizer (YM3812/OPL-3) support 
+<M> Generic OPL2/OPL3 FM synthesizer support
+<M> FM synthesizer (YM3812/OPL-3) support
 
   If you don't set these, you will probably find you can play .wav files
 but not .midi. As the help for them says, set them unless you know your
-- 
1.7.1.251.gf80a2

