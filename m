From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-lib conf: Add two more USB devices to
	iec958 blacklist
Date: Mon, 23 Apr 2012 10:39:13 +0200
Message-ID: <1335170353-7921-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 81F2D244C5
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 10:39:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>, 987163@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

Add "Logitech Wireless Headset" and "Logitech Speaker Lapdesk N700" to
the iec958 blacklist.
Also reorder the list in alphabetic order.

BugLink: https://bugs.launchpad.net/bugs/987163
Reported-by: Jean-Baptiste Lallement <jean-baptiste@ubuntu.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index b9148e7..0a0e374 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -38,10 +38,12 @@ USB-Audio.pcm.iec958_device {
 	# "NoiseBlaster 3000" 42
 
 	# The below don't have digital in/out, so prevent them from being opened.
-	"Sennheiser USB headset" 999
+	"Blue Snowball" 999
+	"Logitech Speaker Lapdesk N700" 999	
 	"Logitech USB Headset" 999
+	"Logitech Wireless Headset" 999
+	"Sennheiser USB headset" 999
 	"USB Device 0x46d:0x992" 999
-	"Blue Snowball" 999
 }
 
 
-- 
1.7.5.4
