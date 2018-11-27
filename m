From: Hui Wang <hui.wang@canonical.com>
Subject: [alsa-lib][PATCH 2/2] conf: USB-Audio: Add Dell WD19
	Dock in the IEC958 blacklist
Date: Tue, 27 Nov 2018 09:36:29 +0800
Message-ID: <20181127013629.7620-2-hui.wang@canonical.com>
References: <20181127013629.7620-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C6826784E
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 02:36:46 +0100 (CET)
In-Reply-To: <20181127013629.7620-1-hui.wang@canonical.com>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This Dock doesn't have IEC958 physical output, so add it to the
blacklist to prevent it being opened.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 src/conf/cards/USB-Audio.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index 05779c47..3a12a729 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -60,6 +60,7 @@ USB-Audio.pcm.iec958_device {
 	"SWTOR Gaming Headset by Razer" 999
 	"USB Device 0x46d_0x821" 999
 	"USB Device 0x46d_0x992" 999
+	"WD19 Dock" 999
 }
 
 # Second iec958 device number, if any.
-- 
2.17.1
