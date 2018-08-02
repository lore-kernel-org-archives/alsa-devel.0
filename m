From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ALSA: usb-audio: Fix invalid use of
	sizeof in parse_uac_endpoint_attributes()
Date: Thu, 2 Aug 2018 04:31:02 +0000
Message-ID: <1533184262-148619-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 615E62676E2
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 06:23:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus
 Elfring <elfring@users.sourceforge.net>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, Michael Drake <michael.drake@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

sizeof() when applied to a pointer typed expression gives the
size of the pointer, not that of the pointed data.

Fixes: 7edf3b5e6a45 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8fe3b0e..67cf849 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1037,7 +1037,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		fp->rate_max = UAC3_BADD_SAMPLING_RATE;
 		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
 
-		pd = kzalloc(sizeof(pd), GFP_KERNEL);
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
 			kfree(fp->rate_table);
 			kfree(fp);
