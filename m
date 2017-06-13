From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: pcm: Skip ack callback without
	actual appl_ptr update
Date: Tue, 13 Jun 2017 16:18:12 +0200
Message-ID: <20170613141812.21220-7-tiwai@suse.de>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18990266F06
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:16 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5BE40AE82
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 14:18:14 +0000 (UTC)
In-Reply-To: <20170613141812.21220-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

We call ack callback whenever appl_ptr gets updated via
pcm_lib_apply_appl_ptr().  There are various code paths to call this
function.  A part of them are for read/write/forward/rewind, where the
appl_ptr is always changed and thus the call of ack is mandatory.
OTOH, another part of code paths are from the explicit user call,
e.g. via SYNC_PTR ioctl.  There, we may receive the same appl_ptr
value, and in such a case, calling ack is obviously superfluous.

This patch adds the check of the given appl_ptr value, and returns
immediately if it's no real update.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index e73b6e4135f6..75308ddc54ca 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2112,6 +2112,9 @@ int pcm_lib_apply_appl_ptr(struct snd_pcm_substream *substream,
 	snd_pcm_uframes_t old_appl_ptr = runtime->control->appl_ptr;
 	int ret;
 
+	if (old_appl_ptr == appl_ptr)
+		return 0;
+
 	runtime->control->appl_ptr = appl_ptr;
 	if (substream->ops->ack) {
 		ret = substream->ops->ack(substream);
-- 
2.13.1
