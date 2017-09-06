From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: usx2y: Use common error handling
 code in submit_urbs()
Date: Wed, 6 Sep 2017 15:17:38 +0200
Message-ID: <aa96b0c6-09cf-16c6-91e2-7fb490b815f3@users.sourceforge.net>
References: <6743b977-4293-42d2-6c1b-cb83b687bd66@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 34335266B60
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 15:17:49 +0200 (CEST)
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
Date: Wed, 6 Sep 2017 15:00:08 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/usb/usx2y/usb_stream.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index fe926cb9192e..4dab49080700 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -352,20 +352,22 @@ static int submit_urbs(struct usb_stream_kernel *sk,
 	int err;
 	prepare_inurb(sk->idle_outurb->number_of_packets, sk->idle_inurb);
 	err = usb_submit_urb(sk->idle_inurb, GFP_ATOMIC);
-	if (err < 0) {
-		snd_printk(KERN_ERR "%i\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_failure;
+
 	sk->idle_inurb = sk->completed_inurb;
 	sk->completed_inurb = inurb;
 	err = usb_submit_urb(sk->idle_outurb, GFP_ATOMIC);
-	if (err < 0) {
-		snd_printk(KERN_ERR "%i\n", err);
-		return err;
-	}
+	if (err < 0)
+		goto report_failure;
+
 	sk->idle_outurb = sk->completed_outurb;
 	sk->completed_outurb = outurb;
 	return 0;
+
+report_failure:
+	snd_printk(KERN_ERR "%i\n", err);
+	return err;
 }
 
 #ifdef DEBUG_LOOP_BACK
-- 
2.14.1
