From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/6] hdspmixer: Increase height of about window.
Date: Thu, 24 Feb 2011 21:33:28 +0100
Message-ID: <1298579611-16573-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

The copyright list got longer, so we need more vertical space.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 5ac3794..38e7b61 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -716,7 +716,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
     scroll->end();
     end();
     setup = new HDSPMixerSetup(400, 260, "Level Meters Setup", this);
-    about = new HDSPMixerAbout(360, 260, "About HDSPMixer", this);
+    about = new HDSPMixerAbout(360, 300, "About HDSPMixer", this);
     i = 0;
     while (cards[i] != NULL) {
 	cards[i++]->initializeCard(this);
-- 
1.7.2.3
