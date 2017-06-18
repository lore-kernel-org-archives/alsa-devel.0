From: Alexander Tsoy <alexander@tsoy.me>
Subject: [PATCH alsa-lib 2/2] USB-Audio: allow custom
	definitions for "default" devices
Date: Sun, 18 Jun 2017 23:23:03 +0300
Message-ID: <20170618202303.29269-2-alexander@tsoy.me>
References: <20170618202303.29269-1-alexander@tsoy.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from puleglot.ru (puleglot.ru [78.47.112.147])
 by alsa0.perex.cz (Postfix) with ESMTP id E9EEF266E56
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 22:23:07 +0200 (CEST)
In-Reply-To: <20170618202303.29269-1-alexander@tsoy.me>
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Fixes: a9b129955659 ("USB-Audio.conf: fix definition for M-Audio AudioP...")
Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---
 src/conf/cards/USB-Audio.conf | 77 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index f72ef121..cc8c718c 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -67,7 +67,7 @@ USB-Audio.pcm.iec958_2_device {
 }
 
 
-# If a device requires non-standard definitions for front, surround40,
+# If a device requires non-standard definitions for front, default, surround40,
 # surround51, surround71 or iec958, they can be defined here.
 
 # M-Audio AudioPhile USB:
@@ -125,13 +125,13 @@ USB-Audio."Audio Advantage MicroII".pcm.iec958 {
 	@args.AES2 { type integer }
 	@args.AES3 { type integer }
 
-    type hooks
-    slave.pcm {
+	type hooks
+	slave.pcm {
 		type hw
 		card $CARD
-    }
+	}
 
-    hooks.0 {
+	hooks.0 {
 		type ctl_elems
 		hook_args [
 			{
@@ -174,41 +174,52 @@ USB-Audio.pcm.front.0 {
 		card $CARD
 		device 0
 	}
-}	
+}
 
 USB-Audio.pcm.default {
 	@args [ CARD ]
 	@args.CARD { type string }
-	type asym
-	playback.pcm {
-		type plug
-		slave.pcm {
-			@func refer
-			name {
-				@func concat
-				strings [
-					"cards.USB-Audio.pcm.default_playback_dmix_"
-					{
-						@func refer
-						name {
-							@func concat
-							strings [
-								"cards.USB-Audio.pcm.use_dmix."
-								{ @func card_name card $CARD }
-							]
+	@func refer
+	name {
+		@func concat
+		strings [
+			"cards.USB-Audio."
+			{ @func card_name card $CARD }
+			".pcm.default:CARD=" $CARD
+		]
+	}
+	default {
+		type asym
+		playback.pcm {
+			type plug
+			slave.pcm {
+				@func refer
+				name {
+					@func concat
+					strings [
+						"cards.USB-Audio.pcm.default_playback_dmix_"
+						{
+							@func refer
+							name {
+								@func concat
+								strings [
+									"cards.USB-Audio.pcm.use_dmix."
+									{ @func card_name card $CARD }
+								]
+							}
+							default yes
 						}
-						default yes
-					}
-					":CARD=" $CARD
-				]
+						":CARD=" $CARD
+					]
+				}
 			}
 		}
-	}
-	capture.pcm {
-		type plug
-		slave.pcm {
-			@func concat
-			strings [ "dsnoop:" $CARD ]
+		capture.pcm {
+			type plug
+			slave.pcm {
+				@func concat
+				strings [ "dsnoop:" $CARD ]
+			}
 		}
 	}
 }
-- 
2.13.0
