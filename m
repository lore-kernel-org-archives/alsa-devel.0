From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/34] pcm: change code formatting for
	softvol_load_control()
Date: Thu, 14 Jul 2016 23:07:36 +0900
Message-ID: <1468505271-5769-20-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2D6672659CE
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:09 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit applies code format according to typical and moderate rule,
for softvol_load_control().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_softvol.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index a667c85..4d2c62a 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -734,7 +734,8 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 	else if (svol->max_dB < 0)
 		svol->zero_dB_val = 0; /* there is no 0 dB setting */
 	else
-		svol->zero_dB_val = (min_dB / (min_dB - max_dB)) * svol->max_val;
+		svol->zero_dB_val = (min_dB / (min_dB - max_dB)) *
+								svol->max_val;
 		
 	snd_ctl_elem_info_alloca(&cinfo);
 	snd_ctl_elem_info_set_id(cinfo, ctl_id);
@@ -758,11 +759,13 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 			   cinfo->count != (unsigned int)cchannels ||
 			   cinfo->value.integer.min != 0 ||
 			   cinfo->value.integer.max != resolution - 1) {
-			if ((err = snd_ctl_elem_remove(svol->ctl, &cinfo->id)) < 0) {
+			err = snd_ctl_elem_remove(svol->ctl, &cinfo->id);
+			if (err < 0) {
 				SNDERR("Control %s mismatch", tmp_name);
 				return err;
 			}
-			snd_ctl_elem_info_set_id(cinfo, ctl_id); /* reset numid */
+			/* reset numid */
+			snd_ctl_elem_info_set_id(cinfo, ctl_id);
 			if ((err = add_user_ctl(svol, cinfo, cchannels)) < 0) {
 				SNDERR("Cannot add a control");
 				return err;
@@ -770,7 +773,8 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 		} else if (svol->max_val > 1) {
 			/* check TLV availability */
 			unsigned int tlv[4];
-			err = snd_ctl_elem_tlv_read(svol->ctl, &cinfo->id, tlv, sizeof(tlv));
+			err = snd_ctl_elem_tlv_read(svol->ctl, &cinfo->id, tlv,
+						    sizeof(tlv));
 			if (err < 0)
 				add_tlv_info(svol, cinfo);
 		}
@@ -780,7 +784,8 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 		return 0;
 
 	/* set up dB table */
-	if (min_dB == PRESET_MIN_DB && max_dB == ZERO_DB && resolution == PRESET_RESOLUTION)
+	if (min_dB == PRESET_MIN_DB && max_dB == ZERO_DB &&
+						resolution == PRESET_RESOLUTION)
 		svol->dB_value = (unsigned int*)preset_dB_value;
 	else {
 #ifndef HAVE_SOFT_FLOAT
@@ -792,8 +797,11 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 		svol->min_dB = min_dB;
 		svol->max_dB = max_dB;
 		for (i = 0; i <= svol->max_val; i++) {
-			double db = svol->min_dB + (i * (svol->max_dB - svol->min_dB)) / svol->max_val;
-			double v = (pow(10.0, db / 20.0) * (double)(1 << VOL_SCALE_SHIFT));
+			double db = svol->min_dB +
+				(i * (svol->max_dB - svol->min_dB)) /
+					svol->max_val;
+			double v = (pow(10.0, db / 20.0) *
+					(double)(1 << VOL_SCALE_SHIFT));
 			svol->dB_value[i] = (unsigned int)v;
 		}
 		if (svol->zero_dB_val)
-- 
2.7.4
