From: s.jansen@gmail.com
Subject: [PATCH] Fix: pulse_pcm_poll_revents should return 0 on
	success
Date: Mon, 25 Feb 2013 22:24:13 -0600
Message-ID: <512c3911.6259ec0a.512c.5fb1@mx.google.com>
References: <1361852653-6656-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1361852653-6656-1-git-send-email-me>
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

---
 pulse/pcm_pulse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 4226d30..0d3704b 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -651,6 +651,8 @@ static int pulse_pcm_poll_revents(snd_pcm_ioplug_t * io,
 	else
 		*revents = 0;
 
+	err = 0;
+
 finish:
 
 	pa_threaded_mainloop_unlock(pcm->p->mainloop);
-- 
1.8.1.4
