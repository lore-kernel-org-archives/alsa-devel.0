From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] a52: Ignore start request if we're already
	running
Date: Wed, 12 Nov 2014 15:55:43 +0100
Message-ID: <1415804143-11519-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C90D92656EE
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 15:55:42 +0100 (CET)
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
Cc: tiwai@suse.de, hyperair@ubuntu.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When trying to start a PCM that's already running, the result is EBADFD.
We might have implicitly started the buffer by filling it up,
so just ignore this request if we're already running.

Reported-by: Chow Loong Jin <hyperair@ubuntu.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 a52/pcm_a52.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index b467ec8..59e25cb 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -482,6 +482,12 @@ static int a52_start(snd_pcm_ioplug_t *io)
 {
 	struct a52_ctx *rec = io->private_data;
 
+	/* When trying to start a PCM that's already running, the result is
+	   EBADFD. We might have implicitly started the buffer by filling it
+	   up, so just ignore this request if we're already running. */
+	if (snd_pcm_state(rec->slave) == SND_PCM_STATE_RUNNING)
+		return 0;
+
 	return snd_pcm_start(rec->slave);
 }
 
-- 
1.9.1
