From: Dan Carpenter <error27@gmail.com>
Subject: [patch 1/2] OSS: soundcard: locking bug in
	sound_ioctl()
Date: Sun, 10 Oct 2010 19:33:52 +0200
Message-ID: <20101010173352.GB5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B17712455F
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 19:34:08 +0200 (CEST)
Received: by wyb32 with SMTP id 32so1283310wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 10:34:08 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

We shouldn't return directly here because we're still holding the
&soundcard_mutex.

This bug goes all the way back to the start of git.  It's strange that
no one has complained about it as a runtime bug.

CC: stable@kernel.org
Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
index 938ed94..a5ab61e 100644
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -392,11 +392,11 @@ static long sound_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case SND_DEV_DSP:
 	case SND_DEV_DSP16:
 	case SND_DEV_AUDIO:
-		return audio_ioctl(dev, file, cmd, p);
+		ret = audio_ioctl(dev, file, cmd, p);
 		break;
 
 	case SND_DEV_MIDIN:
-		return MIDIbuf_ioctl(dev, file, cmd, p);
+		ret = MIDIbuf_ioctl(dev, file, cmd, p);
 		break;
 
 	}
