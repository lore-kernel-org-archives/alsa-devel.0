From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/2] ALSA: usb: Fix wrong mapping of RLC and
	RRC channels
Date: Sun, 10 Nov 2013 21:24:05 +0200
Message-ID: <1384111445-16751-2-git-send-email-anssi.hannula@iki.fi>
References: <527FB20E.2010606@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id BE65E261B23
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 20:24:11 +0100 (CET)
In-Reply-To: <527FB20E.2010606@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

According to USB Audio spec v2 bits 25 and 26 of bmChannelConfig are
"Back Left of Center - BLC" and "Back Right of Center - BRC",
respectively.

They are currently assigned to ALSA channels BLC/BRC. However, the ALSA
BLC/BRC are actually the rather nonsensical "bottom left center" and
"bottom right center", so the channels will be assigned wrongly. The
comments in the USB code are also similarly wrong, so this is not
readily apparent without looking at the actual specification.

Fix the channel mapping by mapping bits 25 and 26 to RLC (Rear Left
Center) and RRC (Rear Right Center), respectively, instead.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/usb/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d737d0e6e558..2fb71be5e100 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -273,8 +273,8 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 		SNDRV_CHMAP_TSL,	/* top side left */
 		SNDRV_CHMAP_TSR,	/* top side right */
 		SNDRV_CHMAP_BC,		/* bottom center */
-		SNDRV_CHMAP_BLC,	/* bottom left center */
-		SNDRV_CHMAP_BRC,	/* bottom right center */
+		SNDRV_CHMAP_RLC,	/* back left of center */
+		SNDRV_CHMAP_RRC,	/* back right of center */
 		0 /* terminator */
 	};
 	struct snd_pcm_chmap_elem *chmap;
-- 
1.8.1.5
