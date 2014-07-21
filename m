From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/2] ALSA: pcm: Add tstamp_type and proto to
	sw_params compat layer
Date: Mon, 21 Jul 2014 13:51:37 +0200
Message-ID: <1405943497-3482-2-git-send-email-tiwai@suse.de>
References: <1405943497-3482-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D5F5B265327
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 13:51:37 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 98466AD77
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 11:51:37 +0000 (UTC)
In-Reply-To: <1405943497-3482-1-git-send-email-tiwai@suse.de>
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

I forgot to add the new fields in sw_params to 32bit compat layer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: rearrange the order of proto and tstamp_type fields

 sound/core/pcm_compat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index af49721ba0e3..102e8fd1d450 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -101,7 +101,9 @@ struct snd_pcm_sw_params32 {
 	u32 silence_threshold;
 	u32 silence_size;
 	u32 boundary;
-	unsigned char reserved[64];
+	u32 proto;
+	u32 tstamp_type;
+	unsigned char reserved[56];
 };
 
 /* recalcuate the boundary within 32bit */
@@ -133,7 +135,9 @@ static int snd_pcm_ioctl_sw_params_compat(struct snd_pcm_substream *substream,
 	    get_user(params.start_threshold, &src->start_threshold) ||
 	    get_user(params.stop_threshold, &src->stop_threshold) ||
 	    get_user(params.silence_threshold, &src->silence_threshold) ||
-	    get_user(params.silence_size, &src->silence_size))
+	    get_user(params.silence_size, &src->silence_size) ||
+	    get_user(params.tstamp_type, &src->tstamp_type) ||
+	    get_user(params.proto, &src->proto))
 		return -EFAULT;
 	/*
 	 * Check silent_size parameter.  Since we have 64bit boundary,
-- 
2.0.1
