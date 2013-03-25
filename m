From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] USB-audio: Add "HP Digital Stereo Headset" to
	SPDIF blacklist
Date: Mon, 25 Mar 2013 06:41:57 +0100
Message-ID: <1364190117-5592-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BAFB26157F
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 06:41:54 +0100 (CET)
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

Yet another headset without digital I/O.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 177a7af..71c2971 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -39,7 +39,8 @@ USB-Audio.pcm.iec958_device {
 
 	# The below don't have digital in/out, so prevent them from being opened.
 	"Blue Snowball" 999
-	"Logitech Speaker Lapdesk N700" 999	
+	"HP Digital Stereo Headset" 999
+	"Logitech Speaker Lapdesk N700" 999
 	"Logitech USB Headset" 999
 	"Logitech Wireless Headset" 999
 	"Plantronics GameCom 780" 999
-- 
1.7.9.5
