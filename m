From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 094/199] Documentation/sound/oss/ESS: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:44 +0200
Message-ID: <1274644376-24176-2-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/ESS:4: ERROR: trailing whitespace
Documentation/sound/oss/ESS:15: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/ESS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/oss/ESS b/Documentation/sound/oss/ESS
index bba93b4..e21c21c 100644
--- a/Documentation/sound/oss/ESS
+++ b/Documentation/sound/oss/ESS
@@ -1,7 +1,7 @@
 Documentation for the ESS AudioDrive chips
 
 In 2.4 kernels the SoundBlaster driver not only tries to detect an ESS chip, it
-tries to detect the type of ESS chip too. The correct detection of the chip 
+tries to detect the type of ESS chip too. The correct detection of the chip
 doesn't always succeed however, so unless you use the kernel isapnp facilities
 (and you chip is pnp capable) the default behaviour is 2.0 behaviour which
 means: only detect ES688 and ES1688.
@@ -12,7 +12,7 @@ people who want to use their ESS for recording sound.
 Every chip that's detected as a later-than-es1688 chip has a 6 bits logarithmic
 master volume control.
 
-Every chip that's detected as a ES1887 now has Full Duplex support. Made a 
+Every chip that's detected as a ES1887 now has Full Duplex support. Made a
 little testprogram that shows that is works, haven't seen a real program that
 needs this however.
 
-- 
1.7.1.251.gf80a2

