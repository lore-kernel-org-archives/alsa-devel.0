From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ALSA: ice1724: remove unused array
Date: Sun, 17 Jun 2018 15:46:29 +0200
Message-ID: <20180617134632.1479-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Stefan Agner <stefan@agner.ch>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This fixes a warning seen with clang:

sound/pci/ice1712/prodigy_hifi.c:321:28: warning: variable 'wm_vol' is not
      needed and will not be emitted [-Wunneeded-internal-declaration]
static const unsigned char wm_vol[256] = {
                           ^

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/pci/ice1712/prodigy_hifi.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index d7366ade5a25..c97b5528e4b8 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -314,26 +314,7 @@ static struct snd_kcontrol_new prodigy_hd2_controls[] = {
 
 /* --------------- */
 
-/*
- * Logarithmic volume values for WM87*6
- * Computed as 20 * Log10(255 / x)
- */
-static const unsigned char wm_vol[256] = {
-	127, 48, 42, 39, 36, 34, 33, 31, 30, 29, 28, 27, 27, 26, 25, 25, 24, 24, 23,
-	23, 22, 22, 21, 21, 21, 20, 20, 20, 19, 19, 19, 18, 18, 18, 18, 17, 17, 17,
-	17, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 14, 14, 14, 14, 14, 13, 13, 13,
-	13, 13, 13, 13, 12, 12, 12, 12, 12, 12, 12, 11, 11, 11, 11, 11, 11, 11, 11,
-	11, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 8, 8,
-	8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 6, 6, 6,
-	6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
-	5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3,
-	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
-	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
-	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0
-};
-
-#define WM_VOL_MAX	(sizeof(wm_vol) - 1)
+#define WM_VOL_MAX	255
 #define WM_VOL_MUTE	0x8000
 
 
-- 
2.17.1
