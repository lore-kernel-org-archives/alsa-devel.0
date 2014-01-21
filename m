From: Olivier Langlois <olivier@trillion01.com>
Subject: [PATCH] alsa-utils: fix timespec to msec conversion
Date: Tue, 21 Jan 2014 15:25:12 -0500
Message-ID: <1390335912-18261-1-git-send-email-olivier@trillion01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy9-pub.mail.unifiedlayer.com
 (oproxy9-pub.mail.unifiedlayer.com [69.89.24.6])
 by alsa0.perex.cz (Postfix) with SMTP id C773C2619F3
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 21:25:58 +0100 (CET)
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
Cc: Olivier Langlois <olivier@trillion01.com>
List-Id: alsa-devel@alsa-project.org

There is 1M nsec in a msec.

Signed-off-by: Olivier Langlois <olivier@trillion01.com>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 69e8bda..33a8ed5 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1509,7 +1509,7 @@ static void xrun(void)
 			timermsub(&now, &tstamp, &diff);
 			fprintf(stderr, _("%s!!! (at least %.3f ms long)\n"),
 				stream == SND_PCM_STREAM_PLAYBACK ? _("underrun") : _("overrun"),
-				diff.tv_sec * 1000 + diff.tv_nsec / 10000000.0);
+				diff.tv_sec * 1000 + diff.tv_nsec / 1000000.0);
 #else
 			fprintf(stderr, "%s !!!\n", _("underrun"));
 #endif
-- 
1.8.5.3
