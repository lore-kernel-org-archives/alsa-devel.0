From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/4] hdspmixer: Initialize headphones out in
	presets
Date: Mon,  4 Apr 2011 14:34:30 +0200
Message-ID: <1301920470-4615-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1301920470-4615-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1301920470-4615-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Cards like the multiface/digiface have additional headphones out. Those
were not initialized in the presets due to wrong loop boundaries:
maxdest represents the amount of physical stereo pairs, and chnls is
either equal or less, so the output fader array needs more iterations
than the playback section.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 hdspmixer/src/HDSPMixerWindow.cxx |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 5a7dac0..75fbc4f 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -734,7 +734,7 @@ void HDSPMixerWindow::restoreDefaults(int card)
 
     for (int preset = 0; preset < 8; ++preset) {
 	for (int speed = 0; speed < num_modes; ++speed) {
-	    for (int i = 0; i < chnls[speed]; i+=2) {
+	    for (int i = 0; i < 2*maxdest[speed]; i+=2) {
     		for (int z = 0; z < maxdest[speed]; ++z) {
 		    /* Gain setup */
 		    if (cards[card]->type == H9632) {
-- 
1.7.4.1
