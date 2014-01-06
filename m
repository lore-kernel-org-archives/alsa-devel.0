From: Olivier Langlois <olivier@trillion01.com>
Subject: [PATCH] alsa-lib: minor typo in pcm doc
Date: Sun,  5 Jan 2014 23:12:44 -0500
Message-ID: <1388981564-30708-1-git-send-email-olivier@trillion01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy1.mail.unifiedlayer.com
 (alt-proxy1.mail.unifiedlayer.com [70.40.203.67])
 by alsa0.perex.cz (Postfix) with SMTP id 65A0626163C
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 05:13:29 +0100 (CET)
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

Added a missing 'f' in the word 'diferent'

Signed-off-by: Olivier Langlois <olivier@trillion01.com>
---
 src/pcm/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index c54fa06..7e46014 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -105,7 +105,7 @@ The poll or select functions (see 'man 2 poll' or 'man 2 select' for further
 details) allows to receive requests/events from the device while
 an application is waiting on events from other sources (like keyboard, screen,
 network etc.), too. \ref snd_pcm_poll_descriptors can be used to get file
-descriptors to poll or select on (note that wait direction might be diferent
+descriptors to poll or select on (note that wait direction might be different
 than expected - do not use only returned file descriptors, but handle
 events member as well - see \ref snd_pcm_poll_descriptors function
 description for more details and \ref snd_pcm_poll_descriptors_revents for
-- 
1.8.5.2
