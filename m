From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 5/6] ALSA: timer: Fix broken compat timer
	user status ioctl
Date: Mon, 29 Feb 2016 17:16:44 +0100
Message-ID: <1456762605-2451-6-git-send-email-tiwai@suse.de>
References: <1456762605-2451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90E7426167D
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:16:50 +0100 (CET)
In-Reply-To: <1456762605-2451-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

The timer user status compat ioctl returned the bogus struct used for
64bit architectures instead of the 32bit one.  This patch addresses
it to return the proper struct.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer_compat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index e05802ae6e1b..8e7eddf35c6a 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -70,13 +70,14 @@ static int snd_timer_user_status_compat(struct file *file,
 					struct snd_timer_status32 __user *_status)
 {
 	struct snd_timer_user *tu;
-	struct snd_timer_status status;
+	struct snd_timer_status32 status;
 	
 	tu = file->private_data;
 	if (snd_BUG_ON(!tu->timeri))
 		return -ENXIO;
 	memset(&status, 0, sizeof(status));
-	status.tstamp = tu->tstamp;
+	status.tstamp.tv_sec = tu->tstamp.tv_sec;
+	status.tstamp.tv_nsec = tu->tstamp.tv_nsec;
 	status.resolution = snd_timer_resolution(tu->timeri);
 	status.lost = tu->timeri->lost;
 	status.overrun = tu->overrun;
-- 
2.7.2
