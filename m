From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/5] hdspmixer: Lower nesting depth in label
	assignment
Date: Tue,  1 Mar 2011 10:42:26 +0100
Message-ID: <1298972547-8759-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

This fix is mostly cosmetic, the long if-then-else-if-chain was rather
confusing. To improve code readability, use simple if-then statements
and leave the function as soon as a match is found.

Clear code would probably use a two-dimensional map, but it seems rather
overengineered.

Last but not least, the non-matching case was augmented by assigning a
generic "1", "2", "3" .. channel naming schema to prevent hdspmixer from
crashing.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 05a126c..b0064c2 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -198,71 +198,92 @@ void HDSPMixerOutput::setLabels()
     int sm = basew->cards[basew->current_card]->speed_mode;
 
     if (type == H9632) {
-	switch (sm) {
-	case 0:
-	    labels_input = labels_playback = labels_9632_ss;
-	    break;
-	case 1:
-	    labels_input = labels_playback = labels_9632_ds;
-	    break;	
-	case 2:
-	    labels_input = labels_playback = labels_9632_qs;
-	    break;
-	}
-    } else if (type == Multiface) {
-	if (sm)
-	    labels_input = labels_playback = labels_mf_ds;
-	else 
-	    labels_input = labels_playback = labels_mf_ss;
-	} else if (type == Digiface) {
-	if (sm)
-	    labels_input = labels_playback = labels_df_ds;
-	else
-	    labels_input = labels_playback = labels_df_ss;
-    } else if (HDSPeMADI == type) {
-      switch (sm) {
-	case 0:
-	    labels_input = labels_playback = labels_madi_ss;
-	    break;
-	case 1:
-	    labels_input = labels_playback = labels_madi_ds;
-	    break;	
-	case 2:
-	    labels_input = labels_playback = labels_madi_qs;
-	    break;
-	}
-    } else if (HDSP_AES == type) {
-      labels_input = labels_playback = labels_aes32;
-    } else if (HDSPeAIO == type) {
-      	switch (sm) {
-	case 0:
-	    labels_input = labels_aio_ss_input;
-	    labels_playback = labels_aio_ss_playback;
-	    break;
-	case 1:
-	    labels_input = labels_aio_ds_input;
-	    labels_playback = labels_aio_ds_playback;
-	    break;	
-	case 2:
-	    labels_input = labels_aio_qs_input;
-	    labels_playback = labels_aio_ds_playback;
-	    break;
-	}
-    } else if (HDSPeRayDAT == type) {
-      switch (sm) {
-      case 0:
-	labels_input = labels_playback = labels_raydat_ss;
-	break;
-      case 1:
-	labels_input = labels_playback = labels_raydat_ds;
-	break;	
-      case 2:
-	labels_input = labels_playback = labels_raydat_qs;
-	break;
-      }
-    } else {
-      fprintf(stderr, "Unknown card type for output labels\n");
+        switch (sm) {
+            case 0:
+                labels_input = labels_playback = labels_9632_ss;
+                break;
+            case 1:
+                labels_input = labels_playback = labels_9632_ds;
+                break;	
+            case 2:
+                labels_input = labels_playback = labels_9632_qs;
+                break;
+        }
+        return;
+    }
+    
+    if (type == Multiface) {
+        if (sm)
+            labels_input = labels_playback = labels_mf_ds;
+        else 
+            labels_input = labels_playback = labels_mf_ss;
+        return;
+    };
+    
+    if (type == Digiface) {
+        if (sm)
+            labels_input = labels_playback = labels_df_ds;
+        else
+            labels_input = labels_playback = labels_df_ss;
+        return;
+    }
+    
+    
+    if (HDSPeMADI == type) {
+        switch (sm) {
+            case 0:
+                labels_input = labels_playback = labels_madi_ss;
+                break;
+            case 1:
+                labels_input = labels_playback = labels_madi_ds;
+                break;	
+            case 2:
+                labels_input = labels_playback = labels_madi_qs;
+                break;
+        }
+        return;
+    }
+
+    if (HDSP_AES == type) {
+        labels_input = labels_playback = labels_aes32;
+        return;
+    }
+    
+    if (HDSPeAIO == type) {
+        switch (sm) {
+            case 0:
+                labels_input = labels_aio_ss_input;
+                labels_playback = labels_aio_ss_playback;
+                break;
+            case 1:
+                labels_input = labels_aio_ds_input;
+                labels_playback = labels_aio_ds_playback;
+                break;	
+            case 2:
+                labels_input = labels_aio_qs_input;
+                labels_playback = labels_aio_ds_playback;
+                break;
+        }
+        return;
+    }
+    
+    if (HDSPeRayDAT == type) {
+        switch (sm) {
+            case 0:
+                labels_input = labels_playback = labels_raydat_ss;
+                break;
+            case 1:
+                labels_input = labels_playback = labels_raydat_ds;
+                break;	
+            case 2:
+                labels_input = labels_playback = labels_raydat_qs;
+                break;
+        }
+        return;
     }
+    
+    fprintf(stderr, "Unknown card type for output labels, assigning defaults\n");
+    labels_input = labels_playback = labels_madi_ss;
 }
 
 void HDSPMixerOutput::draw_background()
-- 
1.7.4.1
