From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Don't treat NULL chmap as a fatal
	error
Date: Wed, 14 Jun 2017 16:25:33 +0200
Message-ID: <20170614142533.16729-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC102671E6
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 16:25:35 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 74197AC2F
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 14:25:35 +0000 (UTC)
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

The standard PCM chmap helper callbacks treat the NULL info->chmap as
a fatal error and spews the kernel warning with stack trace when
CONFIG_SND_DEBUG is on.  This was OK, originally it was supposed to be
always static and non-NULL.  But, as the recent addition of Intel LPE
audio driver shows, the chmap content may vary dynamically, and it can
be even NULL when disconnected.  The user still sees the kernel
warning unnecessarily.

For clearing such a confusion, this patch simply removes the
snd_BUG_ON() in each place, just returns an error without warning.

Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 5088d4b8db22..009e6c98754e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2492,7 +2492,7 @@ static int pcm_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_pcm_substream *substream;
 	const struct snd_pcm_chmap_elem *map;
 
-	if (snd_BUG_ON(!info->chmap))
+	if (!info->chmap)
 		return -EINVAL;
 	substream = snd_pcm_chmap_substream(info, idx);
 	if (!substream)
@@ -2524,7 +2524,7 @@ static int pcm_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	unsigned int __user *dst;
 	int c, count = 0;
 
-	if (snd_BUG_ON(!info->chmap))
+	if (!info->chmap)
 		return -EINVAL;
 	if (size < 8)
 		return -ENOMEM;
-- 
2.13.1
