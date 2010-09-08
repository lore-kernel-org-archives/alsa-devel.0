From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ALSA: rawmidi: cleanup the get next midi
	device ioctl
Date: Wed, 8 Sep 2010 10:53:08 +0200
Message-ID: <20100908085308.GC32047@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6084D24433
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 10:53:21 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2739815ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 01:53:21 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, kernel-janitors@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Ulrich Drepper <drepper@redhat.com>
List-Id: alsa-devel@alsa-project.org

I'm doing an audit to find integer overflows and my static checker
complained that in the original code "device + 1" could overflow.  The
overflow is harmless, but it's still worth cleaning up.  The other thing
that I noticed is that if you pass in a device which is higher than
SNDRV_RAWMIDI_DEVICES then it doesn't return an error code but just
tells you that the next device is "device + 1".

I have rewritten it to just return -EINVAL if you pass in a bogus value
that's either too high or too low.  

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index eb68326..f944180 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -829,8 +829,12 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 		
 		if (get_user(device, (int __user *)argp))
 			return -EFAULT;
+		if (device < 0)
+			return -EINVAL;
+		if (device > SNDRV_RAWMIDI_DEVICES)
+			return -EINVAL;
 		mutex_lock(&register_mutex);
-		device = device < 0 ? 0 : device + 1;
+		device++;
 		while (device < SNDRV_RAWMIDI_DEVICES) {
 			if (snd_rawmidi_search(card, device))
 				break;
