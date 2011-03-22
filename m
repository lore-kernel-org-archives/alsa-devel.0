From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/5] hdspmixer: Use constant instead of
	hardcoded number of cards.
Date: Tue, 22 Mar 2011 11:53:46 +0100
Message-ID: <1300791228-11427-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

Again, use MAX_CARDS instead of "3", just in case MAX_CARDS should
change some day.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerOutput.h b/hdspmixer/src/HDSPMixerOutput.h
index f38d263..2bc3d5c 100644
--- a/hdspmixer/src/HDSPMixerOutput.h
+++ b/hdspmixer/src/HDSPMixerOutput.h
@@ -52,7 +52,7 @@ private:
     HDSPMixerWindow *basew;    
     void update_child(Fl_Widget& widget);
 public:
-    HDSPMixerOutputData *data[3][3][8]; /* data[card][mode(ss/ds/qs)][preset number] */
+    HDSPMixerOutputData *data[MAX_CARDS][3][8]; /* data[card][mode(ss/ds/qs)][preset number] */
     HDSPMixerFader *fader;
     HDSPMixerGain *gain;
     HDSPMixerMeter *meter;
-- 
1.7.4.1
