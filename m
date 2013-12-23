From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: ALSA: hiface: Fix typo in 352800 rate definition
Date: Mon, 23 Dec 2013 11:16:43 +0100
Message-ID: <20131223101643.GA24417@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D88B6260799
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 11:16:47 +0100 (CET)
Received: by mail-ee0-f43.google.com with SMTP id c13so2248684eek.30
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 02:16:47 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

The Vaughan device support the 352800 rate and not
the 352000

Cc: Takashi Iwai <tiwai@suse.de>
Cc: Antonio Ospite <ao2@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---
 sound/usb/hiface/pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index c21a3df..2c44139 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -110,7 +110,7 @@ static const struct snd_pcm_hardware pcm_hw = {
 #define HIFACE_RATE_96000  0x4a
 #define HIFACE_RATE_176400 0x40
 #define HIFACE_RATE_192000 0x48
-#define HIFACE_RATE_352000 0x58
+#define HIFACE_RATE_352800 0x58
 #define HIFACE_RATE_384000 0x68
 
 static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
@@ -141,8 +141,8 @@ static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
 	case 192000:
 		rate_value = HIFACE_RATE_192000;
 		break;
-	case 352000:
-		rate_value = HIFACE_RATE_352000;
+	case 352800:
+		rate_value = HIFACE_RATE_352800;
 		break;
 	case 384000:
 		rate_value = HIFACE_RATE_384000;
-- 
1.8.1.2


-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
