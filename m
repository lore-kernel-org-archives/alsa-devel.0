From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - hdspmixer 3/4] hdspmixer: Beautification;
	Lower nesting depth
Date: Thu,  3 Feb 2011 22:43:36 +0100
Message-ID: <1296769417-1320-4-git-send-email-adi@drcomp.erfurt.thur.de>
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

Exit the loop if card < 0. No need to nest the actual code in the else
branch.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index 7e83c23..6d85062 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -49,45 +49,45 @@ int main(int argc, char **argv)
     while (snd_card_next(&card) >= 0) {
         if (card < 0) {
             break;
-        } else {
-            snd_card_get_longname(card, &name);
-            printf("Card %d : %s\n", card, name);
-            if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {
-                printf("Multiface found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(Multiface, card);
-                cards++;
-            } else if (!strncmp(name, "RME Hammerfall DSP + Digiface", 29)) {
-                printf("Digiface found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(Digiface, card);
-                cards++;
-            } else if (!strncmp(name, "RME Hammerfall HDSP 9652", 24)) {
-                printf("HDSP 9652 found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(H9652, card);
-                cards++;
-            } else if (!strncmp(name, "RME Hammerfall HDSP 9632", 24)) {
-                printf("HDSP 9632 found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(H9632, card);
-                cards++;
-            } else if (!strncmp(name, "RME MADIface", 12)) {
-                printf("RME MADIface found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
-                cards++;
-            } else if (!strncmp(name, "RME MADI", 8)) {
-                printf("RME MADI found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
-                cards++;
-            } else if (!strncmp(name, "RME RayDAT", 10)) {
-                printf("RME RayDAT found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
-                cards++;
-            } else if (!strncmp(name, "RME AIO", 7)) {
-                printf("RME AIO found !\n");
-                hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card);
-                cards++;
-            } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
-                printf("Uninitialized HDSP card found.\nUse hdsploader to upload configuration data to the card.\n");
-            } 
         }
+
+        snd_card_get_longname(card, &name);
+        printf("Card %d : %s\n", card, name);
+        if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {
+            printf("Multiface found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(Multiface, card);
+            cards++;
+        } else if (!strncmp(name, "RME Hammerfall DSP + Digiface", 29)) {
+            printf("Digiface found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(Digiface, card);
+            cards++;
+        } else if (!strncmp(name, "RME Hammerfall HDSP 9652", 24)) {
+            printf("HDSP 9652 found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(H9652, card);
+            cards++;
+        } else if (!strncmp(name, "RME Hammerfall HDSP 9632", 24)) {
+            printf("HDSP 9632 found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(H9632, card);
+            cards++;
+        } else if (!strncmp(name, "RME MADIface", 12)) {
+            printf("RME MADIface found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
+            cards++;
+        } else if (!strncmp(name, "RME MADI", 8)) {
+            printf("RME MADI found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
+            cards++;
+        } else if (!strncmp(name, "RME RayDAT", 10)) {
+            printf("RME RayDAT found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
+            cards++;
+        } else if (!strncmp(name, "RME AIO", 7)) {
+            printf("RME AIO found !\n");
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card);
+            cards++;
+        } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
+            printf("Uninitialized HDSP card found.\nUse hdsploader to upload configuration data to the card.\n");
+        } 
     }
 
     free(name);
-- 
1.7.2.3
