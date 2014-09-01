From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH alsa-lib] pcm: fix return value of
	snd_pcm_share_slave_avail
Date: Tue,  2 Sep 2014 01:29:36 +0600
Message-ID: <1409599776-5150-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 715B726516D
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 21:30:13 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id n15so6436777lbi.16
 for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2014 12:30:12 -0700 (PDT)
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
Cc: tiwai@suse.de, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

The return value was wrong for playback if slave->hw_ptr was near the
boundary and *pcm->appl.ptr was near zero. The wrong result was greater
than the boundary.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_share.c | 2 ++
 1 file changed, 2 insertions(+)

Only compile-tested, as I don't know how to setup the "share" pcm.

diff --git a/src/pcm/pcm_share.c b/src/pcm/pcm_share.c
index 9770544..c301c7a 100644
--- a/src/pcm/pcm_share.c
+++ b/src/pcm/pcm_share.c
@@ -128,6 +128,8 @@ static snd_pcm_uframes_t snd_pcm_share_slave_avail(snd_pcm_share_slave_t *slave)
 		avail += pcm->buffer_size;
 	if (avail < 0)
 		avail += pcm->boundary;
+	else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
+		avail -= pcm->boundary;
 	return avail;
 }
 
-- 
2.1.0
