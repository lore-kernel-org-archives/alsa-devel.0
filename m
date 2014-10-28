From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Zero-clear reserved fields of PCM
	status ioctl in compat mode
Date: Tue, 28 Oct 2014 12:54:30 +0100
Message-ID: <1414497270-15765-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DE5D265979
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 13:00:27 +0100 (CET)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

In compat mode, we copy each field of snd_pcm_status struct but don't
touch the reserved fields, and this leaves uninitialized values
there.  Meanwhile the native ioctl does zero-clear the whole
structure, so we should follow the same rule in compat mode, too.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_compat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 102e8fd1d450..2d957ba63557 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -210,6 +210,8 @@ static int snd_pcm_status_user_compat(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
+	if (clear_user(src, sizeof(*src)))
+		return -EFAULT;
 	if (put_user(status.state, &src->state) ||
 	    compat_put_timespec(&status.trigger_tstamp, &src->trigger_tstamp) ||
 	    compat_put_timespec(&status.tstamp, &src->tstamp) ||
-- 
2.1.2
