From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Use the common error path in
	__snd_pcm_lib_xfer()
Date: Fri, 25 Jan 2019 17:34:54 +0100
Message-ID: <20190125163454.5199-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 996992673DD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 17:34:55 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 13B2FAEEB
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 16:34:55 +0000 (UTC)
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

An open-coded error path in __snd_pcm_lib_xfer() can be replaced with
the simple goto to the common error path.  This also makes the error
handling more consistent, i.e. when some samples have been already
processed, return that size instead of the error code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 40013b26f671..f48efce937ad 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2219,9 +2219,8 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		if (frames > cont)
 			frames = cont;
 		if (snd_BUG_ON(!frames)) {
-			runtime->twake = 0;
-			snd_pcm_stream_unlock_irq(substream);
-			return -EINVAL;
+			err = -EINVAL;
+			goto _end_unlock;
 		}
 		snd_pcm_stream_unlock_irq(substream);
 		err = writer(substream, appl_ofs, data, offset, frames,
-- 
2.16.4
