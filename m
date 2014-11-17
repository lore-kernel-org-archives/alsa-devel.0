From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH (alsa-lib)] USB-audio: Add five more cards to
	IEC958 blacklist
Date: Mon, 17 Nov 2014 11:29:34 +0100
Message-ID: <1416220174-4073-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 38742261A57
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 11:29:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: 1002952@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

These devices do not have any IEC958 outputs, so prevent them from
being opened.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index a6754d9..05e5d09 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -38,10 +38,14 @@ USB-Audio.pcm.iec958_device {
 	# "NoiseBlaster 3000" 42
 
 	# The below don't have digital in/out, so prevent them from being opened.
+	"Andrea PureAudio USB-SA Headset" 999
 	"Blue Snowball" 999
 	"HP Digital Stereo Headset" 999
+	"GN 9330" 999
 	"Logitech Speaker Lapdesk N700" 999
+	"Logitech G35 Headset" 999
 	"Logitech USB Headset" 999
+	"Logitech USB Headset H540" 999
 	"Logitech Wireless Headset" 999
 	"Plantronics GameCom 780" 999
 	"Plantronics USB Headset" 999
@@ -50,6 +54,7 @@ USB-Audio.pcm.iec958_device {
 	"Scarlett 2i2 USB" 999
 	"Scarlett 2i4 USB" 999
 	"Sennheiser USB headset" 999
+	"SWTOR Gaming Headset by Razer" 999
 	"USB Device 0x46d:0x992" 999
 }
 
-- 
1.9.1
