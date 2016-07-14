From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/34] pcm: remove alloca() from
	softvol_load_control()
Date: Thu, 14 Jul 2016 23:07:37 +0900
Message-ID: <1468505271-5769-21-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id B7788265AE8
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

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_softvol.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 4d2c62a..fc45d6d 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -702,17 +702,16 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 				int resolution)
 {
 	char tmp_name[32];
-	snd_pcm_info_t *info;
-	snd_ctl_elem_info_t *cinfo;
+	snd_pcm_info_t info = {0};
+	snd_ctl_elem_info_t cinfo = {0};
 	int err;
 	unsigned int i;
 
 	if (ctl_card < 0) {
-		snd_pcm_info_alloca(&info);
-		err = snd_pcm_info(pcm, info);
+		err = snd_pcm_info(pcm, &info);
 		if (err < 0)
 			return err;
-		ctl_card = snd_pcm_info_get_card(info);
+		ctl_card = snd_pcm_info_get_card(&info);
 		if (ctl_card < 0) {
 			SNDERR("No card defined for softvol control");
 			return -EINVAL;
@@ -737,46 +736,45 @@ static int softvol_load_control(snd_pcm_t *pcm, snd_pcm_softvol_t *svol,
 		svol->zero_dB_val = (min_dB / (min_dB - max_dB)) *
 								svol->max_val;
 		
-	snd_ctl_elem_info_alloca(&cinfo);
-	snd_ctl_elem_info_set_id(cinfo, ctl_id);
-	if ((err = snd_ctl_elem_info(svol->ctl, cinfo)) < 0) {
+	snd_ctl_elem_info_set_id(&cinfo, ctl_id);
+	if ((err = snd_ctl_elem_info(svol->ctl, &cinfo)) < 0) {
 		if (err != -ENOENT) {
 			SNDERR("Cannot get info for CTL %s", tmp_name);
 			return err;
 		}
-		err = add_user_ctl(svol, cinfo, cchannels);
+		err = add_user_ctl(svol, &cinfo, cchannels);
 		if (err < 0) {
 			SNDERR("Cannot add a control");
 			return err;
 		}
 	} else {
-		if (! (cinfo->access & SNDRV_CTL_ELEM_ACCESS_USER)) {
+		if (! (cinfo.access & SNDRV_CTL_ELEM_ACCESS_USER)) {
 			/* hardware control exists */
 			return 1; /* notify */
 
-		} else if ((cinfo->type != SND_CTL_ELEM_TYPE_INTEGER &&
-			    cinfo->type != SND_CTL_ELEM_TYPE_BOOLEAN) ||
-			   cinfo->count != (unsigned int)cchannels ||
-			   cinfo->value.integer.min != 0 ||
-			   cinfo->value.integer.max != resolution - 1) {
-			err = snd_ctl_elem_remove(svol->ctl, &cinfo->id);
+		} else if ((cinfo.type != SND_CTL_ELEM_TYPE_INTEGER &&
+			    cinfo.type != SND_CTL_ELEM_TYPE_BOOLEAN) ||
+			   cinfo.count != (unsigned int)cchannels ||
+			   cinfo.value.integer.min != 0 ||
+			   cinfo.value.integer.max != resolution - 1) {
+			err = snd_ctl_elem_remove(svol->ctl, &cinfo.id);
 			if (err < 0) {
 				SNDERR("Control %s mismatch", tmp_name);
 				return err;
 			}
 			/* reset numid */
-			snd_ctl_elem_info_set_id(cinfo, ctl_id);
-			if ((err = add_user_ctl(svol, cinfo, cchannels)) < 0) {
+			snd_ctl_elem_info_set_id(&cinfo, ctl_id);
+			if ((err = add_user_ctl(svol, &cinfo, cchannels)) < 0) {
 				SNDERR("Cannot add a control");
 				return err;
 			}
 		} else if (svol->max_val > 1) {
 			/* check TLV availability */
 			unsigned int tlv[4];
-			err = snd_ctl_elem_tlv_read(svol->ctl, &cinfo->id, tlv,
+			err = snd_ctl_elem_tlv_read(svol->ctl, &cinfo.id, tlv,
 						    sizeof(tlv));
 			if (err < 0)
-				add_tlv_info(svol, cinfo);
+				add_tlv_info(svol, &cinfo);
 		}
 	}
 
-- 
2.7.4
