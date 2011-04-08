From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/3] hdspmixer: Handle preset files used in
	1.0.24 and 1.0.24.1
Date: Fri,  8 Apr 2011 19:58:37 +0200
Message-ID: <1302285517-11127-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1302285517-11127-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1302285517-11127-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

As an addition to the previous commit, let's also cover the 3rd case
when a preset file was written with hdspmixer v1.0.24 or v1.0.24.1.

In this case, no magic header will be present, but the file size would
differ from the pre 1.0.24 format.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index fb41721..74b5630 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -499,7 +499,24 @@ void HDSPMixerWindow::load()
         pan_array_size = HDSP_MAX_DEST;
         channels_per_card = HDSP_MAX_CHANNELS;
     } else {
-        /* old format, rewind to the start and simply read all data */
+        /* There are two different kinds of old format: pre 1.0.24 and
+         * the one used for 1.0.24/1.0.24.1. We can distinguish between
+         * these two by checking the file size, becase HDSP_MAX_CHANNELS
+         * was bumped right before the 1.0.24 release.
+         */
+        fseek (file, 0, SEEK_END);
+        long filesize = ftell (file);
+        
+        if (1163808 == filesize) {
+            /* file written by hdspmixer v1.0.24 or v1.0.24.1 with
+             * HDSP_MAX_CHANNELS set to 64, but pan_array_size still at
+             * 14, so setting channels_per_card should get the correct
+             * mapping.
+             */
+            channels_per_card = 64; /* HDSP_MAX_CHANNELS */
+        }
+
+        /* rewind to the start and simply read all data */
         rewind(file);
     }
 
-- 
1.7.4.1
