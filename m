From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: Extend chmap definitions for UAC2
Date: Mon, 26 Nov 2012 16:36:32 +0100
Message-ID: <1353944193-16190-2-git-send-email-tiwai@suse.de>
References: <1353944193-16190-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F0EE72650F6
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:36:45 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C4C34A43B9
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:36:45 +0100 (CET)
In-Reply-To: <1353944193-16190-1-git-send-email-tiwai@suse.de>
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

USB audio class 2 has more channel map positions than we currently
have.  Let's add missing definitions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 515b8fc..1774a5c 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -492,7 +492,17 @@ enum {
 	SNDRV_CHMAP_TRL,	/* top rear left */
 	SNDRV_CHMAP_TRR,	/* top rear right */
 	SNDRV_CHMAP_TRC,	/* top rear center */
-	SNDRV_CHMAP_LAST = SNDRV_CHMAP_TRC,
+	/* new definitions for UAC2 */
+	SNDRV_CHMAP_TFLC,	/* top front left center */
+	SNDRV_CHMAP_TFRC,	/* top front right center */
+	SNDRV_CHMAP_TSL,	/* top side left */
+	SNDRV_CHMAP_TSR,	/* top side right */
+	SNDRV_CHMAP_LLFE,	/* left LFE */
+	SNDRV_CHMAP_RLFE,	/* right LFE */
+	SNDRV_CHMAP_BC,		/* bottom center */
+	SNDRV_CHMAP_BLC,	/* bottom left center */
+	SNDRV_CHMAP_BRC,	/* bottom right center */
+	SNDRV_CHMAP_LAST = SNDRV_CHMAP_BRC,
 };
 
 #define SNDRV_CHMAP_POSITION_MASK	0xffff
-- 
1.8.0
