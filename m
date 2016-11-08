From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ALSA: hda - Fix typo
Date: Tue,  8 Nov 2016 15:48:06 +0100
Message-ID: <1478616486-22760-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EF242657A6
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 15:48:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

EPAD -> EAPD

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2f909dd..47224c6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -420,7 +420,7 @@ static void alc_auto_setup_eapd(struct hda_codec *codec, bool on)
 }
 
 /* generic shutup callback;
- * just turning off EPAD and a little pause for avoiding pop-noise
+ * just turning off EAPD and a little pause for avoiding pop-noise
  */
 static void alc_eapd_shutup(struct hda_codec *codec)
 {
-- 
2.1.4
