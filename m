From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: us122l: Use common error handling
 code in us122l_create_card()
Date: Wed, 6 Sep 2017 15:16:29 +0200
Message-ID: <cc84d72e-1474-2eb9-30cf-28034155bcc3@users.sourceforge.net>
References: <6743b977-4293-42d2-6c1b-cb83b687bd66@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 639BF266B60
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 15:16:40 +0200 (CEST)
In-Reply-To: <6743b977-4293-42d2-6c1b-cb83b687bd66@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Jaroslav Kysela <perex@perex.cz>, Johan Hovold <johan@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 14:45:09 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/usb/usx2y/us122l.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index b49d6e953d52..159da1f3924e 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -508,8 +508,7 @@ static bool us122l_create_card(struct snd_card *card)
 		err = us122l_create_usbmidi(card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "us122l_create_usbmidi error %i \n", err);
-		us122l_stop(us122l);
-		return false;
+		goto stop;
 	}
 	err = usb_stream_hwdep_new(card);
 	if (err < 0) {
@@ -518,10 +517,13 @@ static bool us122l_create_card(struct snd_card *card)
 		list_for_each(p, &us122l->midi_list)
 			snd_usbmidi_disconnect(p);
 
-		us122l_stop(us122l);
-		return false;
+		goto stop;
 	}
 	return true;
+
+stop:
+	us122l_stop(us122l);
+	return false;
 }
 
 static void snd_us122l_free(struct snd_card *card)
-- 
2.14.1
