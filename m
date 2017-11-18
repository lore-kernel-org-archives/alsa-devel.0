From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: trident: Use common error handling
 code in snd_trident_mixer()
Date: Sat, 18 Nov 2017 20:13:31 +0100
Message-ID: <e00a1980-2558-baa4-d8fb-7e39f833a7d8@users.sourceforge.net>
References: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C9149266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 20:13:34 +0100 (CET)
In-Reply-To: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 19:49:50 +0100

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/trident/trident_main.c | 71 +++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 9843a61a8ead..2cb5da02ad9b 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2980,7 +2980,7 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 
 	err = snd_ac97_bus(trident->card, 0, &ops, NULL, &trident->ac97_bus);
 	if (err < 0)
-		goto __out;
+		goto free_control;
 
 	memset(&_ac97, 0, sizeof(_ac97));
 	_ac97.private_data = trident;
@@ -2992,12 +2992,12 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
 			err = snd_trident_sis_reset(trident);
 			if (err < 0)
-				goto __out;
+				goto free_control;
 			if (retries-- > 0)
 				goto __again;
 			err = -EIO;
 		}
-		goto __out;
+		goto free_control;
 	}
 	
 	/* secondary codec? */
@@ -3025,12 +3025,12 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		kctl = snd_ctl_new1(&snd_trident_vol_wave_control, trident);
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 		kctl->put(kctl, uctl);
 		kctl = snd_ctl_new1(&snd_trident_vol_music_control, trident);
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 		kctl->put(kctl, uctl);
 		outl(trident->musicvol_wavevol = 0x00000000, TRID_REG(trident, T4D_MUSICVOL_WAVEVOL));
 	} else {
@@ -3046,52 +3046,51 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 
 	trident->ctl_vol = snd_ctl_new1(&snd_trident_pcm_vol_control, trident);
 	if (!trident->ctl_vol)
-		goto __nomem;
+		goto e_nomem;
 
 	err = snd_ctl_add(card, trident->ctl_vol);
 	if (err)
-		goto __out;
+		goto free_control;
 		
 	trident->ctl_pan = snd_ctl_new1(&snd_trident_pcm_pan_control, trident);
 	if (!trident->ctl_pan)
-		goto __nomem;
+		goto e_nomem;
 
 	err = snd_ctl_add(card, trident->ctl_pan);
 	if (err)
-		goto __out;
+		goto free_control;
 
 	trident->ctl_rvol = snd_ctl_new1(&snd_trident_pcm_rvol_control,
 					 trident);
 	if (!trident->ctl_rvol)
-		goto __nomem;
+		goto e_nomem;
 
 	err = snd_ctl_add(card, trident->ctl_rvol);
 	if (err)
-		goto __out;
+		goto free_control;
 
 	trident->ctl_cvol = snd_ctl_new1(&snd_trident_pcm_cvol_control,
 					 trident);
 	if (!trident->ctl_cvol)
-		goto __nomem;
+		goto e_nomem;
 
 	err = snd_ctl_add(card, trident->ctl_cvol);
 	if (err)
-		goto __out;
+		goto free_control;
 
 	if (trident->device == TRIDENT_DEVICE_ID_NX) {
 		kctl = snd_ctl_new1(&snd_trident_ac97_rear_control, trident);
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 		kctl->put(kctl, uctl);
 	}
 	if (trident->device == TRIDENT_DEVICE_ID_NX || trident->device == TRIDENT_DEVICE_ID_SI7018) {
 
 		kctl = snd_ctl_new1(&snd_trident_spdif_control, trident);
-		if (kctl == NULL) {
-			err = -ENOMEM;
-			goto __out;
-		}
+		if (!kctl)
+			goto e_nomem;
+
 		if (trident->ac97->ext_id & AC97_EI_SPDIF)
 			kctl->id.index++;
 		if (trident->ac97_sec && (trident->ac97_sec->ext_id & AC97_EI_SPDIF))
@@ -3099,51 +3098,47 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		idx = kctl->id.index;
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 		kctl->put(kctl, uctl);
 
 		kctl = snd_ctl_new1(&snd_trident_spdif_default, trident);
-		if (kctl == NULL) {
-			err = -ENOMEM;
-			goto __out;
-		}
+		if (!kctl)
+			goto e_nomem;
+
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 
 		kctl = snd_ctl_new1(&snd_trident_spdif_mask, trident);
-		if (kctl == NULL) {
-			err = -ENOMEM;
-			goto __out;
-		}
+		if (!kctl)
+			goto e_nomem;
+
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 
 		kctl = snd_ctl_new1(&snd_trident_spdif_stream, trident);
-		if (kctl == NULL) {
-			err = -ENOMEM;
-			goto __out;
-		}
+		if (!kctl)
+			goto e_nomem;
+
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
-			goto __out;
+			goto free_control;
 		trident->spdif_pcm_ctl = kctl;
 	}
 
 	err = 0;
-	goto __out;
+	goto free_control;
 
- __nomem:
+e_nomem:
 	err = -ENOMEM;
-
- __out:
+free_control:
 	kfree(uctl);
 
 	return err;
-- 
2.15.0
