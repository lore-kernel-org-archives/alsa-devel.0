From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] USB-Audio: Disable "Logitech USB Headset"
	iec958 device
Date: Wed,  7 Mar 2012 11:23:04 +0100
Message-ID: <1331115784-3541-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 465F01045B6
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 11:23:14 +0100 (CET)
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
Cc: clemens@ladish.de, 940145@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Because Logitech USB Headsets do not have any digital devices,
prevent them from being opened. This simplifies probing the
device in PulseAudio.

BugLink: https://bugs.launchpad.net/bugs/940145
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

I did not get any responses to my "digital profile" mail sent to alsa-devel
Feb 24th, but it seems the easiest workaround is the below patch for alsa-lib.
Alsa-info at:
https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/940145/+attachment/2778111/+files/alsa-info.txt.xWdouSRV4Z

 src/conf/cards/USB-Audio.conf |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 0726c34..f488284 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -36,6 +36,8 @@ USB-Audio.pcm.surround40_type {
 # number for the iec958 device can be changed here.
 USB-Audio.pcm.iec958_device {
 	# "NoiseBlaster 3000" 42
+	# Make sure we can't open this device digitally, because it does not exist
+	"Logitech USB Headset" 999 
 }
 
 
-- 
1.7.9
