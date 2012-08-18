From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] oss/sb_audio: prevent divide by zero bug
Date: Sat, 18 Aug 2012 18:55:15 +0300
Message-ID: <20120818155515.GA22424@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 by alsa0.perex.cz (Postfix) with ESMTP id A8F8A265CDC
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 17:25:41 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Speed comes from get_user() in audio_ioctl().  We use it to set the "s"
variable before clamping it to valid values so it could lead to a divide
by zero bug.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/oss/sb_audio.c b/sound/oss/sb_audio.c
index 733b014..b2b3c01 100644
--- a/sound/oss/sb_audio.c
+++ b/sound/oss/sb_audio.c
@@ -575,13 +575,15 @@ static int jazz16_audio_set_speed(int dev, int speed)
 	if (speed > 0)
 	{
 		int tmp;
-		int s = speed * devc->channels;
+		int s;
 
 		if (speed < 5000)
 			speed = 5000;
 		if (speed > 44100)
 			speed = 44100;
 
+		s = speed * devc->channels;
+
 		devc->tconst = (256 - ((1000000 + s / 2) / s)) & 0xff;
 
 		tmp = 256 - devc->tconst;
