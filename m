From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - hdspmixer 4/4] hdspmixer: Break overlong line
	and don't plenken.
Date: Thu,  3 Feb 2011 22:43:37 +0100
Message-ID: <1296769417-1320-5-git-send-email-adi@drcomp.erfurt.thur.de>
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

Pure code beautification, just in case somebody ever needs to touch this
again.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index 6d85062..866afda 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -44,7 +44,7 @@ int main(int argc, char **argv)
     printf("\nHDSPMixer %s - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>\n", VERSION);
     printf("This program comes with ABSOLUTELY NO WARRANTY\n");
     printf("HDSPMixer is free software, see the file COPYING for details\n\n");
-    printf("Looking for RME cards :\n");
+    printf("Looking for RME cards:\n");
 
     while (snd_card_next(&card) >= 0) {
         if (card < 0) {
@@ -52,37 +52,37 @@ int main(int argc, char **argv)
         }
 
         snd_card_get_longname(card, &name);
-        printf("Card %d : %s\n", card, name);
+        printf("Card %d: %s\n", card, name);
         if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {
-            printf("Multiface found !\n");
+            printf("Multiface found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(Multiface, card);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall DSP + Digiface", 29)) {
-            printf("Digiface found !\n");
+            printf("Digiface found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(Digiface, card);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall HDSP 9652", 24)) {
-            printf("HDSP 9652 found !\n");
+            printf("HDSP 9652 found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(H9652, card);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall HDSP 9632", 24)) {
-            printf("HDSP 9632 found !\n");
+            printf("HDSP 9632 found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(H9632, card);
             cards++;
         } else if (!strncmp(name, "RME MADIface", 12)) {
-            printf("RME MADIface found !\n");
+            printf("RME MADIface found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
             cards++;
         } else if (!strncmp(name, "RME MADI", 8)) {
-            printf("RME MADI found !\n");
+            printf("RME MADI found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
             cards++;
         } else if (!strncmp(name, "RME RayDAT", 10)) {
-            printf("RME RayDAT found !\n");
+            printf("RME RayDAT found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
             cards++;
         } else if (!strncmp(name, "RME AIO", 7)) {
-            printf("RME AIO found !\n");
+            printf("RME AIO found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
@@ -101,7 +101,9 @@ int main(int argc, char **argv)
     }
 
     printf("%d RME cards %s found.\n", cards, (cards > 1) ? "cards" : "card");
-    window = new HDSPMixerWindow(0, 0, hdsp_cards[0]->window_width, hdsp_cards[0]->window_height, "HDSPMixer", hdsp_cards[0], hdsp_cards[1], hdsp_cards[2]);
+    window = new HDSPMixerWindow(0, 0, hdsp_cards[0]->window_width,
+            hdsp_cards[0]->window_height, "HDSPMixer", hdsp_cards[0],
+            hdsp_cards[1], hdsp_cards[2]);
     Fl::visual(FL_DOUBLE|FL_INDEX);
     window->show(argc, argv);
 
-- 
1.7.2.3
