From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/8] hdspmixer: Fix preset activation segfault
	on AES(32)
Date: Mon,  7 Mar 2011 19:03:03 +0100
Message-ID: <1299520989-14273-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

When selecting preset 6 or 7 on AES(32), hdspmixer has caused a segfault
due to indirect out of bound access on the destination label array.

The amount of destinations is the number of physical stereo
pairs, so it's usually half the channel count, in some cases one more if
there are additional headphone jacks.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index f52470f..8c057e0 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -582,9 +582,9 @@ void HDSPMixerWindow::restoreDefaults(int card)
       chnls[0] = 16;
       chnls[1] = 16;
       chnls[2] = 16;
-      maxdest[0] = 16;
-      maxdest[1] = 16;
-      maxdest[2] = 16;
+      maxdest[0] = 8;
+      maxdest[1] = 8;
+      maxdest[2] = 8;
       num_modes = 3;
       break;
      case HDSPeAIO:
@@ -610,6 +610,7 @@ void HDSPMixerWindow::restoreDefaults(int card)
 	/* should never happen */
 	return;
     }
+
     for (int preset = 0; preset < 8; ++preset) {
 	for (int speed = 0; speed < num_modes; ++speed) {
 	    for (int i = 0; i < chnls[speed]; i+=2) {
-- 
1.7.4.1
