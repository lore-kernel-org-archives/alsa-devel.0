From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2] USB-Audio: Blacklist iec958 for some USB
	devices
Date: Fri,  9 Mar 2012 11:46:06 +0100
Message-ID: <1331289966-3979-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DD39104115
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 11:46:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Andy Whitcroft <andy.whitcroft@canonical.com>, tiwai@suse.de, clemens@ladisch.de, Raymond Yau <superquad.vortex2@gmail.com>, 940145@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Some common USB devices are analog only, so prevent the digital
devices from being opened. This simplifies probing the device
in PulseAudio.

I have a "Logitech USB Headset" myself, the "Logitech Web Camera"
was reported by Raymond Yau, and the "Blue Snowball" was reported by
Andy Whitcroft.

Cc: Andy Whitcroft <andy.whitcroft@canonical.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>
BugLink: https://bugs.launchpad.net/bugs/940145
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 0726c34..d7c121e 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -36,6 +36,11 @@ USB-Audio.pcm.surround40_type {
 # number for the iec958 device can be changed here.
 USB-Audio.pcm.iec958_device {
 	# "NoiseBlaster 3000" 42
+
+	# The below don't have digital in/out, so prevent them from being opened.
+	"Logitech USB Headset" 999
+	"Logitech Web Camera" 999
+	"Blue Snowball" 999
 }
 
 
-- 
1.7.9
