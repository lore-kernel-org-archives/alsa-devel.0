From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - hdspmixer 2/4] hdspmixer: Improve readability.
Date: Thu,  3 Feb 2011 22:43:35 +0100
Message-ID: <1296769417-1320-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1296769417-1320-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1296769417-1320-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Group the statements into logical blocks.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index 49a9985..7e83c23 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -45,6 +45,7 @@ int main(int argc, char **argv)
     printf("This program comes with ABSOLUTELY NO WARRANTY\n");
     printf("HDSPMixer is free software, see the file COPYING for details\n\n");
     printf("Looking for RME cards :\n");
+
     while (snd_card_next(&card) >= 0) {
         if (card < 0) {
             break;
@@ -88,17 +89,21 @@ int main(int argc, char **argv)
             } 
         }
     }
+
     free(name);
     if (!cards) {
         printf("No RME cards found.\n");
         exit(EXIT_FAILURE);
     }
+
     for (int i = cards; i < 3; ++i) {
         hdsp_cards[i] = NULL;
     }
+
     printf("%d RME cards %s found.\n", cards, (cards > 1) ? "cards" : "card");
     window = new HDSPMixerWindow(0, 0, hdsp_cards[0]->window_width, hdsp_cards[0]->window_height, "HDSPMixer", hdsp_cards[0], hdsp_cards[1], hdsp_cards[2]);
     Fl::visual(FL_DOUBLE|FL_INDEX);
     window->show(argc, argv);
+
     return Fl::run();    
 }
-- 
1.7.2.3
