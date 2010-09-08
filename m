From: Dan Carpenter <error27@gmail.com>
Subject: [patch v2] ALSA: rawmidi: fix the get next midi device
	ioctl
Date: Wed, 8 Sep 2010 21:36:41 +0200
Message-ID: <20100908193641.GA3463@bicker>
References: <20100908085308.GC32047@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CFF310383A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 21:38:13 +0200 (CEST)
Received: by yxj4 with SMTP id 4so267444yxj.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 12:38:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100908085308.GC32047@bicker>
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

If we pass in a device which is higher than SNDRV_RAWMIDI_DEVICES then
this function just returns device + 1 which isn't helpful.  I've
modified it to return -EINVAL instead.

Also Smatch complains because the "device + 1" could be an integer
overflow.  It's harmless, but we may as well silence the warning.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2:  In the first version I made negative values return -EINVAL

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index eb68326..1633bac 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -829,6 +829,8 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 		
 		if (get_user(device, (int __user *)argp))
 			return -EFAULT;
+		if (device > SNDRV_RAWMIDI_DEVICES)
+			return -EINVAL;
 		mutex_lock(&register_mutex);
 		device = device < 0 ? 0 : device + 1;
 		while (device < SNDRV_RAWMIDI_DEVICES) {
