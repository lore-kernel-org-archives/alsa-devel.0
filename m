From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-lib: Conf: Fix channels of ICE1712 to
	10/12
Date: Mon, 28 Mar 2011 10:35:29 +0200
Message-ID: <4D904851.7090602@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000103060007030806090305"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 65172103839
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 10:35:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000103060007030806090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I know this issue has been brought up before, without resolution. 
Basically PulseAudio cannot open cards such as M-Audio 2496 and M-Audio 
Delta 1010LT because it does not try to open "front" with 10 channels, 
only with 2.

I think it is reasonable to assume that a front:x stream should be able 
to open with 2 channels only, therefore I'm proposing this fix, and I'm 
applying it to Ubuntu as well, unless you have a better idea.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------000103060007030806090305
Content-Type: text/x-patch;
 name="0001-Conf-Fix-channels-of-ICE1712-to-10-12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Conf-Fix-channels-of-ICE1712-to-10-12.patch"

>From caf7ba000b5d09bd073028392235c14f34e63b97 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 28 Mar 2011 10:19:16 +0200
Subject: [PATCH] Conf: Fix channels of ICE1712 to 10/12

The ICE1712 kernel driver accepts 10 playback channels and
12 recording channels only. Therefore fix this channel count
in alsa-lib.

BugLink: http://bugs.launchpad.net/bugs/178442
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/cards/ICE1712.conf |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index 01e50d2..f5b8add 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -32,12 +32,26 @@ ICE1712.pcm.front.0 {
 	@args.CARD {
 		type string
 	}
-	type route
-	ttable.0.0 1
-	ttable.1.1 1
-	slave.pcm {
-		type hw
-		card $CARD
+	type asym
+	playback.pcm {
+		type route
+		ttable.0.0 1
+		ttable.1.1 1
+		slave.pcm {
+			type hw
+			card $CARD
+		}
+		slave.channels 10
+	}
+	capture.pcm {
+		type route
+		ttable.0.0 1
+		ttable.1.1 1
+		slave.pcm {
+			type hw
+			card $CARD
+		}
+		slave.channels 12
 	}
 }	
 
@@ -57,6 +71,7 @@ ICE1712.pcm.surround40.0 {
 		type hw
 		card $CARD
 	}
+	slave.channels 10
 }	
 
 <confdir:pcm/surround41.conf>
@@ -79,6 +94,7 @@ ICE1712.pcm.surround51.0 {
 		type hw
 		card $CARD
 	}
+	slave.channels 10
 }
 
 <confdir:pcm/iec958.conf>
-- 
1.7.4.1


--------------000103060007030806090305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000103060007030806090305--
