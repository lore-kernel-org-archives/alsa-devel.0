From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sound: oss: use strlcpy() in sound_timer_init()
Date: Thu, 29 Sep 2011 09:10:48 +0300
Message-ID: <20110929061048.GC4104@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 4669E103A84
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 08:11:02 +0200 (CEST)
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

sound_timer.info.name is a 32 character buffer.  This function only
has one caller (in sound/oss/ad1848.c) and it passes as 128 character
buffer as "name".  I don't know if this is a problem in real life,
and I doubt we're going to add more OSS drivers so it's unlikely to
become an issue.  But we may as well take care of it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/oss/sound_timer.c b/sound/oss/sound_timer.c
index 48cda6c..8021c85 100644
--- a/sound/oss/sound_timer.c
+++ b/sound/oss/sound_timer.c
@@ -320,7 +320,7 @@ void  sound_timer_init(struct sound_lowlev_timer *t, char *name)
 	n = sound_alloc_timerdev();
 	if (n == -1)
 		n = 0;		/* Overwrite the system timer */
-	strcpy(sound_timer.info.name, name);
+	strlcpy(sound_timer.info.name, name, sizeof(sound_timer.info.name));
 	sound_timer_devs[n] = &sound_timer;
 }
 EXPORT_SYMBOL(sound_timer_init);
