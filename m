From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 7/8] hdspmixer: [cosmetics] Break code into
	logic blocks
Date: Mon,  7 Mar 2011 19:03:08 +0100
Message-ID: <1299520989-14273-8-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert the if-then-else-if chain into standalone if-then blocks to
improve readability. A switch-case statement would also do the trick,
but it's less readable.

No (intended) semantic change.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index bf7009f..b754b20 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -229,7 +229,9 @@ void HDSPMixerCard::adjustSettings() {
             /* should never happen */
             break;
         }
-    } else if (type == Digiface) {
+    }
+    
+    if (type == Digiface) {
         switch (speed_mode) {
         case 0:
             channels_input = channels_playback = 26;
@@ -249,7 +251,9 @@ void HDSPMixerCard::adjustSettings() {
             /* should never happen */
             break;
         }
-    } else if (type == H9652) {
+    }
+
+    if (type == H9652) {
         switch (speed_mode) {
         case 0:
             channels_input = channels_playback = 26;
@@ -269,7 +273,9 @@ void HDSPMixerCard::adjustSettings() {
             /* should never happen */
             break;
         }
-    } else if (type == H9632) {
+    }
+
+    if (type == H9632) {
         switch (speed_mode) {
         case 0:
             channels_input = channels_playback = 12 + ((h9632_aeb.aebi || h9632_aeb.aebo) ? 4 : 0);
@@ -293,7 +299,9 @@ void HDSPMixerCard::adjustSettings() {
             meter_map_input = meter_map_playback = channel_map_h9632_qs;
             break;
         }
-    } else if (HDSPeMADI == type) {
+    }
+
+    if (HDSPeMADI == type) {
         playbacks_offset = 64;
 
         switch (speed_mode) {
@@ -320,7 +328,9 @@ void HDSPMixerCard::adjustSettings() {
             break;
         }
 
-    } else if (HDSPeAIO == type) {
+    }
+
+    if (HDSPeAIO == type) {
         playbacks_offset = 64;
 
         switch (speed_mode) {
@@ -356,7 +366,9 @@ void HDSPMixerCard::adjustSettings() {
             break;
         }
 
-    } else if (HDSP_AES == type) {
+    }
+
+    if (HDSP_AES == type) {
         playbacks_offset = 64; /* not sure about this one? */
 
         /* 16 channels for all modes */
@@ -369,7 +381,9 @@ void HDSPMixerCard::adjustSettings() {
         meter_map_input = channel_map_aes32;
         meter_map_playback = channel_map_aes32;
 
-    } else if (HDSPeRayDAT == type) {
+    }
+
+    if (HDSPeRayDAT == type) {
         playbacks_offset = 64;
 
         switch (speed_mode) {
-- 
1.7.4.1
