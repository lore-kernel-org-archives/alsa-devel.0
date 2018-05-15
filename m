From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 5/6] pcm: softvol: use position
	offset macro of TLV data
Date: Tue, 15 May 2018 21:36:38 +0900
Message-ID: <20180515123639.18255-6-o-takashi@sakamocchi.jp>
References: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id DEBE62672BA
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:23 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id i5-v6so9360245plt.2
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:23 -0700 (PDT)
In-Reply-To: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_softvol.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 0eaeacef..f08208f8 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -31,6 +31,8 @@
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
+#include <sound/tlv.h>
+
 #ifndef PIC
 /* entry for static linking */
 const char *_snd_module_pcm_softvol = "";
@@ -708,10 +710,11 @@ static void snd_pcm_softvol_dump(snd_pcm_t *pcm, snd_output_t *out)
 static int add_tlv_info(snd_pcm_softvol_t *svol, snd_ctl_elem_info_t *cinfo)
 {
 	unsigned int tlv[4];
-	tlv[0] = SND_CTL_TLVT_DB_SCALE;
-	tlv[1] = 2 * sizeof(int);
-	tlv[2] = (int)(svol->min_dB * 100);
-	tlv[3] = (int)((svol->max_dB - svol->min_dB) * 100 / svol->max_val);
+	tlv[SNDRV_CTL_TLVO_TYPE] = SND_CTL_TLVT_DB_SCALE;
+	tlv[SNDRV_CTL_TLVO_LEN] = 2 * sizeof(int);
+	tlv[SNDRV_CTL_TLVO_DB_SCALE_MIN] = (int)(svol->min_dB * 100);
+	tlv[SNDRV_CTL_TLVO_DB_SCALE_MUTE_AND_STEP] =
+		(int)((svol->max_dB - svol->min_dB) * 100 / svol->max_val);
 	return snd_ctl_elem_tlv_write(svol->ctl, &cinfo->id, tlv);
 }
 
-- 
2.14.1
