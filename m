From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/4] hdspmixer: Recall 1st preset on all cards,
	not just on the first
Date: Mon,  4 Apr 2011 14:34:29 +0200
Message-ID: <1301920470-4615-4-git-send-email-adi@drcomp.erfurt.thur.de>
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

With the new "store current settings to the virtual 9th preset" before
switching cards code, one needs to make sure the actual mixer state is
loaded with sane values, either from the preset file or a generic
builtin preset.

Calling preset_change(1) is sufficient, setting all the required data.
However, in case of more than one RME card in the system, one needs to
call this function for each card, otherwise, some of the cards store
uninitialized data to the 9th preset, resulting in a weird mixer state
afterwards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 hdspmixer/src/HDSPMixerWindow.cxx |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 7848190..5a7dac0 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -877,9 +877,10 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
 	printf("Initializing default presets\n");
 	i = 0;
 	while (i < MAX_CARDS && cards[i] != NULL) {
+	    current_card = i;
 	    restoreDefaults(i++);
+	    inputs->buttons->presets->preset_change(1);
 	}
-	inputs->buttons->presets->preset_change(1);
     }
     Fl::atclose = atclose_cb;
     Fl::add_handler(handler_cb);
-- 
1.7.4.1
