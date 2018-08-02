From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: usb-audio: Fix wrong sizeof argument
Date: Thu, 2 Aug 2018 09:17:23 -0500
Message-ID: <20180802141723.GA7258@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.148.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A4672677D8
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 16:18:17 +0200 (CEST)
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 12E895337B
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 09:18:17 -0500 (CDT)
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
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

The correct argument to be passed to kzalloc is sizeof(*pd)

Addresses-Coverity-ID: 1472224 ("Wrong sizeof argument")
Fixes: 7edf3b5e6a45 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8fe3b0e..67cf849 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1037,7 +1037,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		fp->rate_max = UAC3_BADD_SAMPLING_RATE;
 		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
 
-		pd = kzalloc(sizeof(pd), GFP_KERNEL);
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
 			kfree(fp->rate_table);
 			kfree(fp);
-- 
2.7.4
