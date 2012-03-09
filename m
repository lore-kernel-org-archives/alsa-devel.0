From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] USB-Audio: Fixup card name for Logitech web
	camera
Date: Fri,  9 Mar 2012 14:06:04 +0100
Message-ID: <1331298364-12791-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id CC42A10BBD0
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 14:06:09 +0100 (CET)
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Raymond Yau <superquad.vortex2@gmail.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/USB-Audio.conf |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index d7c121e..966172f 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -39,7 +39,7 @@ USB-Audio.pcm.iec958_device {
 
 	# The below don't have digital in/out, so prevent them from being opened.
 	"Logitech USB Headset" 999
-	"Logitech Web Camera" 999
+	"USB Device 0x46d:0x992" 999
 	"Blue Snowball" 999
 }
 
-- 
1.7.9
