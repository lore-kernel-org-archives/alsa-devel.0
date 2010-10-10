From: Dan Carpenter <error27@gmail.com>
Subject: [patch 2/2] OSS: soundcard: fix return value of
	sound_open()
Date: Sun, 10 Oct 2010 19:34:22 +0200
Message-ID: <20101010173422.GC5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 128B42455F
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Oct 2010 19:34:32 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 32so1283310wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 10:34:32 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
index a5ab61e..46c0d03 100644
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -249,7 +249,7 @@ static int sound_open(struct inode *inode, struct file *file)
 	}
 
 	mutex_unlock(&soundcard_mutex);
-	return 0;
+	return retval;
 }
 
 static int sound_release(struct inode *inode, struct file *file)
