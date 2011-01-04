From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] snd-usb-us122l: Fix missing NULL checks
Date: Tue, 4 Jan 2011 01:20:37 +0100
Message-ID: <201101040120.38492.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout5.freenet.de (mout5.freenet.de [195.4.92.95])
	by alsa0.perex.cz (Postfix) with ESMTP id B84B81038C5
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 01:20:44 +0100 (CET)
Received: from [195.4.92.10] (helo=0.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port
	25) (Exim 4.72 #3) id 1PZudl-0005cN-Ll
	for alsa-devel@alsa-project.org; Tue, 04 Jan 2011 01:20:41 +0100
Received: from p5dd50289.dip0.t-ipconnect.de ([93.213.2.137]:64223
	helo=a64.localdomain)
	by 0.mx.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port 25)
	(Exim 4.72 #3) id 1PZudl-0004l1-Ch
	for alsa-devel@alsa-project.org; Tue, 04 Jan 2011 01:20:41 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix missing NULL checks in usb_stream_hwdep_poll() and usb_stream_hwdep_ioctl().
Wake up poll waiters before returning from usb_stream_hwdep_ioctl().

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: stable@kernel.org
---
 sound/usb/usx2y/us122l.c |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 91bb296..7abda8d 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -269,29 +269,26 @@ static unsigned int usb_stream_hwdep_poll(struct snd_hwdep *hw,
 					  struct file *file, poll_table *wait)
 {
 	struct us122l	*us122l = hw->private_data;
-	struct usb_stream *s = us122l->sk.s;
 	unsigned	*polled;
 	unsigned int	mask;
 
 	poll_wait(file, &us122l->sk.sleep, wait);
 
-	switch (s->state) {
-	case usb_stream_ready:
-		if (us122l->first == file)
-			polled = &s->periods_polled;
-		else
-			polled = &us122l->second_periods_polled;
-		if (*polled != s->periods_done) {
-			*polled = s->periods_done;
-			mask = POLLIN | POLLOUT | POLLWRNORM;
-			break;
+	mask = POLLIN | POLLOUT | POLLWRNORM | POLLERR;
+	if (mutex_trylock(&us122l->mutex)) {
+		struct usb_stream *s = us122l->sk.s;
+		if (s && s->state == usb_stream_ready) {
+			if (us122l->first == file)
+				polled = &s->periods_polled;
+			else
+				polled = &us122l->second_periods_polled;
+			if (*polled != s->periods_done) {
+				*polled = s->periods_done;
+				mask = POLLIN | POLLOUT | POLLWRNORM;
+			} else
+				mask = 0;
 		}
-		/* Fall through */
-		mask = 0;
-		break;
-	default:
-		mask = POLLIN | POLLOUT | POLLWRNORM | POLLERR;
-		break;
+		mutex_unlock(&us122l->mutex);
 	}
 	return mask;
 }
@@ -377,6 +374,7 @@ static int usb_stream_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 {
 	struct usb_stream_config *cfg;
 	struct us122l *us122l = hw->private_data;
+	struct usb_stream *s;
 	unsigned min_period_frames;
 	int err = 0;
 	bool high_speed;
@@ -422,18 +420,18 @@ static int usb_stream_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 	snd_power_wait(hw->card, SNDRV_CTL_POWER_D0);
 
 	mutex_lock(&us122l->mutex);
+	s = us122l->sk.s;
 	if (!us122l->master)
 		us122l->master = file;
 	else if (us122l->master != file) {
-		if (memcmp(cfg, &us122l->sk.s->cfg, sizeof(*cfg))) {
+		if (!s || memcmp(cfg, &s->cfg, sizeof(*cfg))) {
 			err = -EIO;
 			goto unlock;
 		}
 		us122l->slave = file;
 	}
-	if (!us122l->sk.s ||
-	    memcmp(cfg, &us122l->sk.s->cfg, sizeof(*cfg)) ||
-	    us122l->sk.s->state == usb_stream_xrun) {
+	if (!s || memcmp(cfg, &s->cfg, sizeof(*cfg)) ||
+	    s->state == usb_stream_xrun) {
 		us122l_stop(us122l);
 		if (!us122l_start(us122l, cfg->sample_rate, cfg->period_frames))
 			err = -EIO;
@@ -444,6 +442,7 @@ unlock:
 	mutex_unlock(&us122l->mutex);
 free:
 	kfree(cfg);
+	wake_up_all(&us122l->sk.sleep);
 	return err;
 }
 
-- 
1.7.2.3
