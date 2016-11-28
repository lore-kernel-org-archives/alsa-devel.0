From: jeeja.kp@intel.com
Subject: [PATCH] aplay: Fix to handle pause when system is
	suspended/Resumed
Date: Mon, 28 Nov 2016 22:02:00 +0530
Message-ID: <1480350720-13441-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8451D266DAA
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 17:21:59 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

If PCM is paused and then we do system supend-resume, the stream throws
error(EBADF) when stream is paused released.

Check the pcm state before pause/release and if stream is suspended,
call snd_pcm_resume to resume the stream.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 aplay/aplay.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 2da7dda..ee480f2 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -166,6 +166,8 @@ static void end_wave(int fd);
 static void begin_au(int fd, size_t count);
 static void end_au(int fd);
 
+static void suspend(void);
+
 static const struct fmt_capture {
 	void (*start) (int fd, size_t count);
 	void (*end) (int fd);
@@ -1487,6 +1489,9 @@ static void do_pause(void)
 		fprintf(stderr, _("\rPAUSE command ignored (no hw support)\n"));
 		return;
 	}
+	if (snd_pcm_state(handle) == SND_PCM_STATE_SUSPENDED)
+		suspend();
+
 	err = snd_pcm_pause(handle, 1);
 	if (err < 0) {
 		error(_("pause push error: %s"), snd_strerror(err));
@@ -1496,6 +1501,8 @@ static void do_pause(void)
 		while (read(fileno(stdin), &b, 1) != 1);
 		if (b == ' ' || b == '\r') {
 			while (read(fileno(stdin), &b, 1) == 1);
+			if (snd_pcm_state(handle) == SND_PCM_STATE_SUSPENDED)
+				suspend();
 			err = snd_pcm_pause(handle, 0);
 			if (err < 0)
 				error(_("pause release error: %s"), snd_strerror(err));
-- 
2.5.0
