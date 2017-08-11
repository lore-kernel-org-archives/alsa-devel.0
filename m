From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: usx2y: Delete an error message for a
 failed memory allocation in two functions
Date: Fri, 11 Aug 2017 18:02:15 +0200
Message-ID: <5ca1485e-5aaf-3c42-a24e-fb834239182e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id D2A5D26768D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 18:02:52 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 17:40:57 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/usb/usx2y/usbusx2yaudio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index dd40ca9d858a..612aa7ff7e18 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -422,7 +422,5 @@ static int usX2Y_urbs_allocate(struct snd_usX2Y_substream *subs)
-		if (NULL == subs->tmpbuf) {
-			snd_printk(KERN_ERR "cannot malloc tmpbuf\n");
+		if (!subs->tmpbuf)
 			return -ENOMEM;
-		}
 	}
 	/* allocate and initialize data urbs */
 	for (i = 0; i < NRURBS; i++) {
@@ -952,7 +950,6 @@ static int usX2Y_audio_stream_new(struct snd_card *card, int playback_endpoint,
-		if (NULL == usX2Y_substream[i]) {
-			snd_printk(KERN_ERR "cannot malloc\n");
+		if (!usX2Y_substream[i])
 			return -ENOMEM;
-		}
+
 		usX2Y_substream[i]->usX2Y = usX2Y(card);
 	}
 
-- 
2.14.0
