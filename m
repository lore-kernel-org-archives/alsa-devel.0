From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] conf/ucm/Dell-WD15-Dock: Fix incorrect device
	names
Date: Thu, 18 Oct 2018 15:11:06 +0200
Message-ID: <20181018131106.12050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E662675B5
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 15:11:21 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1DC9FAEDC
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 13:11:21 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The device name string for Dell WD15 (and its variants) dock is set as
"WD15Dock", while the actual device name to be used is "Dock".

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1112292
Fixes: 8ebb40c96970 ("conf/ucm: Add a UCM profile for Dell WD15 Dock USB-audio")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/conf/ucm/Dell-WD15-Dock/HiFi.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
index b07f34400086..1b6bd21237f1 100644
--- a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
+++ b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
@@ -3,7 +3,7 @@ SectionDevice."Headphone" {
 
 	Value {
 		PlaybackChannels "2"
-		PlaybackPCM "hw:WD15Dock,0"
+		PlaybackPCM "hw:Dock,0"
 	}
 }
 
@@ -12,7 +12,7 @@ SectionDevice."LineOut" {
 
 	Value {
 		PlaybackChannels "2"
-		PlaybackPCM "hw:WD15Dock,1"
+		PlaybackPCM "hw:Dock,1"
 	}
 }
 
@@ -21,6 +21,6 @@ SectionDevice."Mic" {
 
 	Value {
 		CaptureChannels "2"
-		CapturePCM "hw:WD15Dock,0"
+		CapturePCM "hw:Dock,0"
 	}
 }
-- 
2.19.0
