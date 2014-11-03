From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: [PATCH] USB-Audio: Add Scarlett 2i4 USB to S/PDIF
	blacklist
Date: Mon,  3 Nov 2014 17:42:44 +0200
Message-ID: <1415029364-9337-1-git-send-email-pmatilai@laiskiainen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a92.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id D351926050B
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 16:42:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Panu Matilainen <pmatilai@laiskiainen.org>
List-Id: alsa-devel@alsa-project.org

Like Scarlett 2i2, the 2i4 does not have any S/PDIF connections.

Signed-off-by: Panu Matilainen <pmatilai@laiskiainen.org>
---
 src/conf/cards/USB-Audio.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 77a48b9..a6754d9 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -48,6 +48,7 @@ USB-Audio.pcm.iec958_device {
 	"Plantronics Wireless Audio" 999
 	"SB WoW Headset" 999
 	"Scarlett 2i2 USB" 999
+	"Scarlett 2i4 USB" 999
 	"Sennheiser USB headset" 999
 	"USB Device 0x46d:0x992" 999
 }
-- 
1.9.3
