From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ALSA: pcm: add more format names
Date: Fri, 27 Aug 2010 22:02:15 +0200
Message-ID: <20100827200215.GA15220@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 038C41038B6
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 22:02:52 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3782890wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 13:02:52 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, markgross <mgross@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, kernel-janitors@vger.kernel.org, Ben Collins <bcollins@bluecherry.net>
List-Id: alsa-devel@alsa-project.org

There were some new formats added in commit 15c0cee6c809 "ALSA: pcm:
Define G723 3-bit and 5-bit formats".  That commit increased
SNDRV_PCM_FORMAT_LAST as well.  My concern is that there are a couple
places which do:

        for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
                if (dummy->pcm_hw.formats & (1ULL << i))
                        snd_iprintf(buffer, " %s", snd_pcm_format_name(i));
        }

I haven't tested these but it looks like if "i" were equal to
SNDRV_PCM_FORMAT_G723_24 or higher then we might read past the end of
the array. 

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Resending because I screwed up the CC lis on my first mail.

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index cbe815d..204af48 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -203,10 +203,16 @@ static char *snd_pcm_format_names[] = {
 	FORMAT(S18_3BE),
 	FORMAT(U18_3LE),
 	FORMAT(U18_3BE),
+	FORMAT(G723_24),
+	FORMAT(G723_24_1B),
+	FORMAT(G723_40),
+	FORMAT(G723_40_1B),
 };
 
 const char *snd_pcm_format_name(snd_pcm_format_t format)
 {
+	if (format >= ARRAY_SIZE(snd_pcm_format_names))
+		return "Unknown";
 	return snd_pcm_format_names[format];
 }
 EXPORT_SYMBOL_GPL(snd_pcm_format_name);
