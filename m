From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: xen-front: fix unintention integer overflow on left shifts
Date: Thu, 27 Jun 2019 17:58:53 +0100
Message-ID: <20190627165853.21864-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Shifting the integer value 1 is evaluated using 32-bit
arithmetic and then used in an expression that expects a 64-bit
value, so there is potentially an integer overflow. Fix this
by using the BIT_ULL macro to perform the shift.

Addresses-Coverity: ("Unintentional integer overflow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/xen/xen_snd_front_alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index b14ab512c2ce..e01631959ed8 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -196,7 +196,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
 		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
-			mask |= 1 << ALSA_SNDIF_FORMATS[i].sndif;
+			mask |= BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif);
 
 	return mask;
 }
@@ -208,7 +208,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
 
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
-		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
+		if (BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif) & sndif_formats)
 			mask |= pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
 
 	return mask;
-- 
2.20.1
