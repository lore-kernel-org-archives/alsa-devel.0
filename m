From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ALSA: xen: Use standard
	pcm_format_to_bits() for ALSA format bits
Date: Wed, 25 Jul 2018 23:19:45 +0200
Message-ID: <20180725211945.19222-11-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB2126779C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:55 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 16849B382
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:54 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
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

The open codes with the bit shift in xen_snd_front_alsa.c give sparse
warnings as the PCM format type is with __bitwise.
There is already a standard macro to get the format bits, so let's use
it instead.

This fixes sparse warnings like:
  sound/xen/xen_snd_front_alsa.c:191:47: warning: restricted snd_pcm_format_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/xen/xen_snd_front_alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index 5a2bd70a2fa1..129180e17db1 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -188,7 +188,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
 
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
-		if (1 << ALSA_SNDIF_FORMATS[i].alsa & alsa_formats)
+		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
 			mask |= 1 << ALSA_SNDIF_FORMATS[i].sndif;
 
 	return mask;
@@ -202,7 +202,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
 		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
-			mask |= 1 << ALSA_SNDIF_FORMATS[i].alsa;
+			mask |= pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
 
 	return mask;
 }
-- 
2.18.0
