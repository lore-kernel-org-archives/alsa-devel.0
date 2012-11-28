From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 06/10] usb-audio: parameterize FTU effect unit control
Date: Wed, 28 Nov 2012 23:55:37 +0100
Message-ID: <1354143341-1623-7-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2236F264F3F
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:56:03 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:56:03 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Adds the unit ID and the control as parameters to the creation of the
effect unit control for the M-Audio Fast Track Ultra. This allows the
code to be shared with other devices that use different unit ID and
control, such as the M-Audio Fast Track C400.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer_quirks.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 4199b97..a614dab 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -635,11 +635,13 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 }
 
 /* M-Audio FastTrack Ultra quirks */
-/* FTU Effect switch */
+/* FTU Effect switch (also used by C400) */
 struct snd_ftu_eff_switch_priv_val {
 	struct usb_mixer_interface *mixer;
 	int cached_value;
 	int is_cached;
+	int bUnitID;
+	int validx;
 };
 
 static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
@@ -674,9 +676,8 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
 	struct snd_ftu_eff_switch_priv_val *pval;
 	int err;
 	unsigned char value[2];
+	int id, validx;
 
-	const int id = 6;
-	const int validx = 1;
 	const int val_len = 2;
 
 	value[0] = 0x00;
@@ -698,6 +699,8 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 
+	id = pval->bUnitID;
+	validx = pval->validx;
 
 	down_read(&mixer->chip->shutdown_rwsem);
 	if (mixer->chip->shutdown)
@@ -728,10 +731,8 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	struct usb_mixer_interface *mixer;
 	int changed, cur_val, err, new_val;
 	unsigned char value[2];
+	int id, validx;
 
-
-	const int id = 6;
-	const int validx = 1;
 	const int val_len = 2;
 
 	changed = 0;
@@ -749,6 +750,9 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 
+	id = pval->bUnitID;
+	validx = pval->validx;
+
 	if (!pval->is_cached) {
 		/* Read current value */
 		down_read(&mixer->chip->shutdown_rwsem);
@@ -793,7 +797,8 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	return changed;
 }
 
-static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer)
+static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
+	int validx, int bUnitID)
 {
 	static struct snd_kcontrol_new template = {
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -816,6 +821,8 @@ static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer)
 	pval->cached_value = 0;
 	pval->is_cached = 0;
 	pval->mixer = mixer;
+	pval->bUnitID = bUnitID;
+	pval->validx = validx;
 
 	template.private_value = (unsigned long) pval;
 	kctl = snd_ctl_new1(&template, mixer->chip);
@@ -974,9 +981,10 @@ static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
 	if (err < 0)
 		return err;
 
-	err = snd_ftu_create_effect_switch(mixer);
+	err = snd_ftu_create_effect_switch(mixer, 1, 6);
 	if (err < 0)
 		return err;
+
 	err = snd_ftu_create_effect_volume_ctl(mixer);
 	if (err < 0)
 		return err;
-- 
1.7.8.6
