From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-lib conf: block S/PDIF access for
	Sennheiser USB headset
Date: Sat, 14 Apr 2012 01:14:09 +0200
Message-ID: <1334358849-2503-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 369FA243D5
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Apr 2012 01:14:16 +0200 (CEST)
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
Cc: tiwai@suse.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The Sennheiser USB headset has no S/PDIF input or output, so make
sure we can't open it that way.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 966172f..b9148e7 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -38,6 +38,7 @@ USB-Audio.pcm.iec958_device {
 	# "NoiseBlaster 3000" 42
 
 	# The below don't have digital in/out, so prevent them from being opened.
+	"Sennheiser USB headset" 999
 	"Logitech USB Headset" 999
 	"USB Device 0x46d:0x992" 999
 	"Blue Snowball" 999
-- 
1.7.9.5
