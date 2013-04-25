From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-lib: conf - Add Scarlett 2i2 USB to
	S/PDIF blacklist
Date: Thu, 25 Apr 2013 14:44:06 +0200
Message-ID: <1366893846-5956-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 37A4326511F
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 14:44:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The Scarlett 2i2 USB interface does not have any S/PDIF connections.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 71c2971..0d93175 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -47,6 +47,7 @@ USB-Audio.pcm.iec958_device {
 	"Plantronics USB Headset" 999
 	"Plantronics Wireless Audio" 999
 	"SB WoW Headset" 999
+	"Scarlett 2i2 USB" 999
 	"Sennheiser USB headset" 999
 	"USB Device 0x46d:0x992" 999
 }
-- 
1.7.9.5
