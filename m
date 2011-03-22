From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/5] hdspmixer: Update NEWS file.
Date: Tue, 22 Mar 2011 11:53:48 +0100
Message-ID: <1300791228-11427-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1300791228-11427-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1300791228-11427-1-git-send-email-adi@drcomp.erfurt.thur.de>
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


Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/NEWS b/hdspmixer/NEWS
index cbe95d8..f4900d0 100644
--- a/hdspmixer/NEWS
+++ b/hdspmixer/NEWS
@@ -1,3 +1,17 @@
+Version 1.11 (2011-03-22):
+    * Fix ALSA snd_ctl_open error when running with three cards.
+    * Fix metering for non-MADI cards
+    * Fix labels on H9652
+    * Fix preset activation segfault on AES(32)
+    * Adjust playback channel count on Multiface
+    * Provide headphones out on Multiface/Digiface
+    * Update pixmaps
+    * Save and restore level meter settings
+      WARNING: New mix files cannot be read by older versions of hdspmixers
+
+Version 1.10 (2011-02-24):
+    * Add support for RME MADI, RayDAT, AES, AES32 and AIO
+
 Version 1.6 (24/11/2003):
     * Fixes compilation warnings
     * AutoSync sample rate detection scheme changed
-- 
1.7.4.1
