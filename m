From: s.jansen@gmail.com
Subject: [PATCH - alsa-lib/mixer 1/1]
	snd_mixer_poll_descriptors_revents should loop over pollfd
Date: Mon, 25 Feb 2013 10:41:40 -0600
Message-ID: <512b944d.1317b60a.47ee.ffffe8ac@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Sander Jansen <s.jansen@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Sander Jansen <s.jansen@gmail.com>


Signed-off-by: Sander Jansen <s.jansen@gmail.com>

diff --git a/src/mixer/mixer.c b/src/mixer/mixer.c
index 85d843f..8deceac 100644
--- a/src/mixer/mixer.c
+++ b/src/mixer/mixer.c
@@ -743,7 +743,7 @@ int snd_mixer_poll_descriptors_revents(snd_mixer_t *mixer, struct pollfd *pfds,
 	if (nfds == 0)
 		return -EINVAL;
 	res = 0;
-	for (idx = 0; idx < nfds; idx++)
+	for (idx = 0; idx < nfds; idx++, pfds++)
 		res |= pfds->revents & (POLLIN|POLLERR|POLLNVAL);
 	*revents = res;
 	return 0;
-- 
1.8.1.3
