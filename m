From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - hdspmixer 1/4] hdspmixer: retab and reindent
	code.
Date: Thu,  3 Feb 2011 22:43:34 +0100
Message-ID: <1296769417-1320-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

Something seriously was wrong, probably different patches with different
tabwidth levels. I switched to spaces to avoid ambiguity and let vim
reindent everything.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index 2a7c5c9..49a9985 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -39,18 +39,18 @@ int main(int argc, char **argv)
     char *name;
     int card;
     int cards = 0;
-    
+
     card = -1;
     printf("\nHDSPMixer %s - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>\n", VERSION);
     printf("This program comes with ABSOLUTELY NO WARRANTY\n");
     printf("HDSPMixer is free software, see the file COPYING for details\n\n");
     printf("Looking for RME cards :\n");
     while (snd_card_next(&card) >= 0) {
-	if (card < 0) {
-	    break;
-	} else {
-	    snd_card_get_longname(card, &name);
-	    printf("Card %d : %s\n", card, name);
+        if (card < 0) {
+            break;
+        } else {
+            snd_card_get_longname(card, &name);
+            printf("Card %d : %s\n", card, name);
             if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {
                 printf("Multiface found !\n");
                 hdsp_cards[cards] = new HDSPMixerCard(Multiface, card);
@@ -67,34 +67,34 @@ int main(int argc, char **argv)
                 printf("HDSP 9632 found !\n");
                 hdsp_cards[cards] = new HDSPMixerCard(H9632, card);
                 cards++;
-	    } else if (!strncmp(name, "RME MADIface", 12)) {
-		printf("RME MADIface found !\n");
-		hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
-		cards++;
-	    } else if (!strncmp(name, "RME MADI", 8)) {
-		printf("RME MADI found !\n");
-		hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
-		cards++;
-	    } else if (!strncmp(name, "RME RayDAT", 10)) {
-		printf("RME RayDAT found !\n");
-		hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
-		cards++;
-	    } else if (!strncmp(name, "RME AIO", 7)) {
-		printf("RME AIO found !\n");
-		hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card);
-		cards++;
-	    } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
-		printf("Uninitialized HDSP card found.\nUse hdsploader to upload configuration data to the card.\n");
-	    } 
-	}
+            } else if (!strncmp(name, "RME MADIface", 12)) {
+                printf("RME MADIface found !\n");
+                hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
+                cards++;
+            } else if (!strncmp(name, "RME MADI", 8)) {
+                printf("RME MADI found !\n");
+                hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
+                cards++;
+            } else if (!strncmp(name, "RME RayDAT", 10)) {
+                printf("RME RayDAT found !\n");
+                hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
+                cards++;
+            } else if (!strncmp(name, "RME AIO", 7)) {
+                printf("RME AIO found !\n");
+                hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card);
+                cards++;
+            } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
+                printf("Uninitialized HDSP card found.\nUse hdsploader to upload configuration data to the card.\n");
+            } 
+        }
     }
     free(name);
     if (!cards) {
-	printf("No RME cards found.\n");
-	exit(EXIT_FAILURE);
+        printf("No RME cards found.\n");
+        exit(EXIT_FAILURE);
     }
     for (int i = cards; i < 3; ++i) {
-	hdsp_cards[i] = NULL;
+        hdsp_cards[i] = NULL;
     }
     printf("%d RME cards %s found.\n", cards, (cards > 1) ? "cards" : "card");
     window = new HDSPMixerWindow(0, 0, hdsp_cards[0]->window_width, hdsp_cards[0]->window_height, "HDSPMixer", hdsp_cards[0], hdsp_cards[1], hdsp_cards[2]);
-- 
1.7.2.3
