From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: Fireface: Use common error handling code
	in pcm_open()
Date: Tue, 22 Aug 2017 21:51:26 +0200
Message-ID: <05f76303-7370-ea37-20c2-116c04b850db@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 30240266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 21:51:36 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 21:45:42 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/firewire/fireface/ff-pcm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/fireface/ff-pcm.c b/sound/firewire/fireface/ff-pcm.c
index d12a0e3a4219..40975395a64a 100644
--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -138,16 +138,12 @@ static int pcm_open(struct snd_pcm_substream *substream)
 		return err;
 
 	err = pcm_init_hw_params(ff, substream);
-	if (err < 0) {
-		snd_ff_stream_lock_release(ff);
-		return err;
-	}
+	if (err < 0)
+		goto release_lock;
 
 	err = ff->spec->protocol->get_clock(ff, &rate, &src);
-	if (err < 0) {
-		snd_ff_stream_lock_release(ff);
-		return err;
-	}
+	if (err < 0)
+		goto release_lock;
 
 	if (src != SND_FF_CLOCK_SRC_INTERNAL) {
 		for (i = 0; i < CIP_SFC_COUNT; ++i) {
@@ -177,6 +173,10 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_set_sync(substream);
 
 	return 0;
+
+release_lock:
+	snd_ff_stream_lock_release(ff);
+	return err;
 }
 
 static int pcm_close(struct snd_pcm_substream *substream)
-- 
2.14.0
