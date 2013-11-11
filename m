From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] sparc: fix missing unlock on error in
	snd_cs4231_playback_prepare()
Date: Mon, 11 Nov 2013 22:21:33 +0800
Message-ID: <CAPgLHd-XQs-+NgMDjhF+Q4F4P5OSfPXXkBrNKWJJQNWkv_U37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id CA9EF2608D9
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 15:21:33 +0100 (CET)
Received: by mail-bk0-f42.google.com with SMTP id w16so1746154bkz.29
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 06:21:33 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock before return from function
snd_cs4231_playback_prepare() in the error handling
case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/sparc/cs4231.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index b47f6fe..dbb1b625 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -907,19 +907,24 @@ static int snd_cs4231_playback_prepare(struct snd_pcm_substream *substream)
 	struct snd_cs4231 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned long flags;
+	int ret = 0;
 
 	spin_lock_irqsave(&chip->lock, flags);
 
 	chip->image[CS4231_IFACE_CTRL] &= ~(CS4231_PLAYBACK_ENABLE |
 					    CS4231_PLAYBACK_PIO);
 
-	if (WARN_ON(runtime->period_size > 0xffff + 1))
-		return -EINVAL;
+	if (WARN_ON(runtime->period_size > 0xffff + 1)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	chip->p_periods_sent = 0;
+
+out:
 	spin_unlock_irqrestore(&chip->lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int snd_cs4231_capture_hw_params(struct snd_pcm_substream *substream,
