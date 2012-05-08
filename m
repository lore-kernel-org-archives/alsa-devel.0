From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-lib conf: Add "Plantronics USB Headset"
	to S/PDIF blacklist
Date: Tue,  8 May 2012 15:31:25 -0700
Message-ID: <1336516285-10131-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A4031044D9
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 00:31:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Unsurprisingly, Plantronics does not have S/PDIF connections
on their headsets.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 0a0e374..db18dad 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -43,6 +43,7 @@ USB-Audio.pcm.iec958_device {
 	"Logitech USB Headset" 999
 	"Logitech Wireless Headset" 999
 	"Sennheiser USB headset" 999
+	"Plantronics USB Headset" 999
 	"USB Device 0x46d:0x992" 999
 }
 
-- 
1.7.9.5
