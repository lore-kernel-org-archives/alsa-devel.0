From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 3/5] Only use F_SETSIG fcntl where it exists.
Date: Thu,  3 Mar 2016 15:08:02 +0100
Message-ID: <1457014084-27694-3-git-send-email-tk@giga.or.at>
References: <1457014084-27694-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-2.mx.upcmail.net
 (vie01a-dmta-pe02-2.mx.upcmail.net [62.179.121.158])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F89B26066B
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 15:08:50 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1abTvu-0004eG-IQ
 for alsa-devel@alsa-project.org; Thu, 03 Mar 2016 15:08:50 +0100
In-Reply-To: <1457014084-27694-1-git-send-email-tk@giga.or.at>
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
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

---
 src/timer/timer_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/timer/timer_hw.c b/src/timer/timer_hw.c
index e61b994..ddaebd3 100644
--- a/src/timer/timer_hw.c
+++ b/src/timer/timer_hw.c
@@ -85,10 +85,12 @@ static int snd_timer_hw_async(snd_timer_t *timer, int sig, pid_t pid)
 	}
 	if (sig < 0)
 		return 0;
+#ifdef F_SETSIG
 	if (fcntl(fd, F_SETSIG, (long)sig) < 0) {
 		SYSERR("F_SETSIG failed");
 		return -errno;
 	}
+#endif
 	if (fcntl(fd, F_SETOWN, (long)pid) < 0) {
 		SYSERR("F_SETOWN failed");
 		return -errno;
-- 
2.7.1
