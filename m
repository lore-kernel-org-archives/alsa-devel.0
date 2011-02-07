From: Dan Carpenter <error27@gmail.com>
Subject: [patch] USB: 6fire: signedness bug in
	usb6fire_pcm_prepare()
Date: Mon, 7 Feb 2011 20:25:19 +0300
Message-ID: <20110207172519.GI4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 26154244AE
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 18:25:37 +0100 (CET)
Received: by fxm5 with SMTP id 5so5116700fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Feb 2011 09:25:36 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Torsten Schenk <torsten.schenk@zoho.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

rt->rate is an unsigned char so it's never equal to -1.  It's not a huge
problem because the invalid rate is caught inside the call to
usb6fire_pcm_set_rate() which returns -EINVAL.  But if we fix the test
then it prints out the correct error message so that's good.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 705c88e..ba62c74 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -493,13 +493,12 @@ static int usb6fire_pcm_prepare(struct snd_pcm_substream *alsa_sub)
 	sub->period_off = 0;
 
 	if (rt->stream_state == STREAM_DISABLED) {
-		rt->rate = -1;
 		for (i = 0; i < ARRAY_SIZE(rates); i++)
 			if (alsa_rt->rate == rates[i]) {
 				rt->rate = i;
 				break;
 			}
-		if (rt->rate == -1) {
+		if (i == ARRAY_SIZE(rates)) {
 			mutex_unlock(&rt->stream_mutex);
 			snd_printk("invalid rate %d in prepare.\n",
 					alsa_rt->rate);
