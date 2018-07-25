From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/10] ALSA: ad1816a: Fix sparse warning wrt
	PCM format type
Date: Wed, 25 Jul 2018 23:19:39 +0200
Message-ID: <20180725211945.19222-5-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 572C426776E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:54 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CFFFEB0A5
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
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

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of snd_ad1816a_get_format() with the proper snd_pcm_format_t
type.

This fixes the sparse warning like:
  sound/isa/ad1816a/ad1816a_lib.c:93:14: warning: restricted snd_pcm_format_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/ad1816a/ad1816a_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 923201414469..fba6d22f7f4b 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -85,7 +85,8 @@ static void snd_ad1816a_write_mask(struct snd_ad1816a *chip, unsigned char reg,
 
 
 static unsigned char snd_ad1816a_get_format(struct snd_ad1816a *chip,
-					    unsigned int format, int channels)
+					    snd_pcm_format_t format,
+					    int channels)
 {
 	unsigned char retval = AD1816A_FMT_LINEAR_8;
 
-- 
2.18.0
