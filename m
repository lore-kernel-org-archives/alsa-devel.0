From: s.jansen@gmail.com
Subject: [PATCH] pulse_pcm_poll_revents should return 0 on
	success
Date: Mon, 25 Feb 2013 22:24:12 -0600
Message-ID: <512c3904.6259ec0a.512c.5fa7@mx.google.com>
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

According to the DOCS, poll_revents should return 0 on success. Fix 
the pulse plugin to do so.

Sander Jansen (1):
  Fix: pulse_pcm_poll_revents should return 0 on success

 pulse/pcm_pulse.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
1.8.1.4
