From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Bail out when chmap is already
	present
Date: Tue, 10 May 2016 16:47:49 +0200
Message-ID: <1462891669-28673-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E97C9261600
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 16:47:51 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DD461AB5D
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 14:47:50 +0000 (UTC)
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

When snd_pcm_add_chmap_ctls() is called to the PCM stream to which a
chmap has been already assigned, it returns as an error due to the
conflicting snd_ctl_add() result.  However, this also clears the
already assigned chmap_kctl field via pcm_chmap_ctl_private_free(),
and becomes inconsistent in the later operation.

This patch adds the check of the conflicting chmap kctl before
actually trying to allocate / assign.  The check failure is treated as
a kernel warning, as the double call of snd_pcm_add_chmap_ctls() is
basically a driver bug and having the stack trace would help
developers to figure out the bad code path.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 0aca39762ed0..bb1261591a1f 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2595,6 +2595,8 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 	};
 	int err;
 
+	if (WARN_ON(pcm->streams[stream].chmap_kctl))
+		return -EBUSY;
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.8.2
