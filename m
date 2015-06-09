From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH/linux-next] Doc: sound:oss: Fix typo in sound/oss
Date: Wed, 10 Jun 2015 00:17:42 +0900
Message-ID: <1433863062-25715-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, corbet@lwn.net, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fix some spelling typo found in Documentations/sound/oss.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/sound/oss/PSS-updates | 2 +-
 Documentation/sound/oss/README.OSS  | 2 +-
 Documentation/sound/oss/btaudio     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/oss/PSS-updates b/Documentation/sound/oss/PSS-updates
index c84dd75..11914a1 100644
--- a/Documentation/sound/oss/PSS-updates
+++ b/Documentation/sound/oss/PSS-updates
@@ -41,7 +41,7 @@ pss_no_sound
 
 	This module parameter is a flag that can be used to tell the driver to 
 just configure non-sound components.  0 configures all components, a non-0 
-value will only attept to configure the CDROM and joystick ports.  This 
+value will only attempt to configure the CDROM and joystick ports.  This 
 parameter can be used by a user who only wished to use the builtin joystick 
 and/or CDROM port(s) of his PSS sound card.  If this driver is loaded with this 
 parameter and with the parameter below set to true then a user can safely unload 
diff --git a/Documentation/sound/oss/README.OSS b/Documentation/sound/oss/README.OSS
index 4be2594..a085ea3 100644
--- a/Documentation/sound/oss/README.OSS
+++ b/Documentation/sound/oss/README.OSS
@@ -1346,7 +1346,7 @@ implement nice real-time signal processing audio effect software and
 network telephones. The ACI mixer has to be switched into the "solo"
 mode for duplex operation in order to avoid feedback caused by the
 mixer (input hears output signal). You can de-/activate this mode
-through toggleing the record button for the wave controller with an
+through toggling the record button for the wave controller with an
 OSS-mixer.
 
 The PCM20 contains a radio tuner, which is also controlled by
diff --git a/Documentation/sound/oss/btaudio b/Documentation/sound/oss/btaudio
index 1a693e6..effdb9a 100644
--- a/Documentation/sound/oss/btaudio
+++ b/Documentation/sound/oss/btaudio
@@ -29,7 +29,7 @@ Driver Status
 
 Still somewhat experimental.  The driver should work stable, i.e. it
 should'nt crash your box.  It might not work as expected, have bugs,
-not being fully OSS API compilant, ...
+not being fully OSS API compliant, ...
 
 Latest versions are available from http://bytesex.org/bttv/, the
 driver is in the bttv tarball.  Kernel patches might be available too,
-- 
2.4.2.387.gf86f31a

