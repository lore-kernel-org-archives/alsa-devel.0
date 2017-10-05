From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] sound/pci/asihpi: Convert timers to use
	timer_setup()
Date: Wed, 4 Oct 2017 17:53:40 -0700
Message-ID: <20171005005340.GA23810@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f54.google.com (mail-pg0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 83044267428
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 02:53:43 +0200 (CEST)
Received: by mail-pg0-f54.google.com with SMTP id b11so7406177pgn.12
 for <alsa-devel@alsa-project.org>; Wed, 04 Oct 2017 17:53:43 -0700 (PDT)
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
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 sound/pci/asihpi/asihpi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 70d023a85bf5..614322171c79 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -749,9 +749,9 @@ static inline unsigned int modulo_min(unsigned int a, unsigned int b,
 
 /** Timer function, equivalent to interrupt service routine for cards
 */
-static void snd_card_asihpi_timer_function(unsigned long data)
+static void snd_card_asihpi_timer_function(struct timer_list *t)
 {
-	struct snd_card_asihpi_pcm *dpcm = (struct snd_card_asihpi_pcm *)data;
+	struct snd_card_asihpi_pcm *dpcm = from_timer(dpcm, t, timer);
 	struct snd_pcm_substream *substream = dpcm->substream;
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime;
@@ -948,7 +948,7 @@ static void snd_card_asihpi_int_task(unsigned long data)
 	asihpi = (struct snd_card_asihpi *)a->snd_card->private_data;
 	if (asihpi->llmode_streampriv)
 		snd_card_asihpi_timer_function(
-			(unsigned long)asihpi->llmode_streampriv);
+			&asihpi->llmode_streampriv->timer);
 }
 
 static void snd_card_asihpi_isr(struct hpi_adapter *a)
@@ -1059,8 +1059,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	    If internal and other stream playing, can't switch
 	*/
 
-	setup_timer(&dpcm->timer, snd_card_asihpi_timer_function,
-		    (unsigned long) dpcm);
+	timer_setup(&dpcm->timer, snd_card_asihpi_timer_function, 0);
 	dpcm->substream = substream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
@@ -1240,8 +1239,7 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	if (err)
 		return -EIO;
 
-	setup_timer(&dpcm->timer, snd_card_asihpi_timer_function,
-		    (unsigned long) dpcm);
+	timer_setup(&dpcm->timer, snd_card_asihpi_timer_function, 0);
 	dpcm->substream = substream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
