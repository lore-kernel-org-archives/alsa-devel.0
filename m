From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 03/27] ALSA: dummy: Convert to new PCM copy
	ops
Date: Thu,  1 Jun 2017 22:58:26 +0200
Message-ID: <20170601205850.24993-4-tiwai@suse.de>
References: <20170601205850.24993-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FA44266C87
 for <alsa-devel@alsa-project.org>; Thu,  1 Jun 2017 22:59:04 +0200 (CEST)
In-Reply-To: <20170601205850.24993-1-tiwai@suse.de>
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
Cc: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

It's a dummy ops, so just replacing it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 172dacd925f5..dd5ed037adf2 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -644,15 +644,22 @@ static int alloc_fake_buffer(void)
 }
 
 static int dummy_pcm_copy(struct snd_pcm_substream *substream,
-			  int channel, snd_pcm_uframes_t pos,
-			  void __user *dst, snd_pcm_uframes_t count)
+			  int channel, unsigned long pos,
+			  void __user *dst, unsigned long bytes)
+{
+	return 0; /* do nothing */
+}
+
+static int dummy_pcm_copy_kernel(struct snd_pcm_substream *substream,
+				 int channel, unsigned long pos,
+				 void *dst, unsigned long bytes)
 {
 	return 0; /* do nothing */
 }
 
 static int dummy_pcm_silence(struct snd_pcm_substream *substream,
-			     int channel, snd_pcm_uframes_t pos,
-			     snd_pcm_uframes_t count)
+			     int channel, unsigned long pos,
+			     unsigned long bytes)
 {
 	return 0; /* do nothing */
 }
@@ -683,8 +690,9 @@ static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
-	.copy =		dummy_pcm_copy,
-	.silence =	dummy_pcm_silence,
+	.copy_user =	dummy_pcm_copy,
+	.copy_kernel =	dummy_pcm_copy_kernel,
+	.fill_silence =	dummy_pcm_silence,
 	.page =		dummy_pcm_page,
 };
 
-- 
2.13.0
