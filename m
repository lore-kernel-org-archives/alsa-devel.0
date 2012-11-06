From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, v2,
	RFC 2/8] usb-audio: parameterize FTU effect unit control
Date: Tue,  6 Nov 2012 01:30:33 +0100
Message-ID: <1352161839-1455-3-git-send-email-eldad@fogrefinery.com>
References: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E738261672
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 01:33:21 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so2096111bku.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 16:33:21 -0800 (PST)
In-Reply-To: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
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
index ae2b714..6807b97 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -621,11 +621,13 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
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
@@ -660,9 +662,8 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
 	struct snd_ftu_eff_switch_priv_val *pval;
 	int err;
 	unsigned char value[2];
+	int id, validx;
 
-	const int id = 6;
-	const int validx = 1;
 	const int val_len = 2;
 
 	value[0] = 0x00;
@@ -684,6 +685,8 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 
+	id = pval->bUnitID;
+	validx = pval->validx;
 
 	down_read(&mixer->chip->shutdown_rwsem);
 	if (mixer->chip->shutdown)
@@ -714,10 +717,8 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	struct usb_mixer_interface *mixer;
 	int changed, cur_val, err, new_val;
 	unsigned char value[2];
+	int id, validx;
 
-
-	const int id = 6;
-	const int validx = 1;
 	const int val_len = 2;
 
 	changed = 0;
@@ -735,6 +736,9 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	if (snd_BUG_ON(!chip))
 		return -EINVAL;
 
+	id = pval->bUnitID;
+	validx = pval->validx;
+
 	if (!pval->is_cached) {
 		/* Read current value */
 		down_read(&mixer->chip->shutdown_rwsem);
@@ -779,7 +783,8 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 	return changed;
 }
 
-static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer)
+static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
+	int validx, int bUnitID)
 {
 	static struct snd_kcontrol_new template = {
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -802,6 +807,8 @@ static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer)
 	pval->cached_value = 0;
 	pval->is_cached = 0;
 	pval->mixer = mixer;
+	pval->bUnitID = bUnitID;
+	pval->validx = validx;
 
 	template.private_value = (unsigned long) pval;
 	kctl = snd_ctl_new1(&template, mixer->chip);
@@ -960,9 +967,10 @@ static int snd_ftu_create_mixer(struct usb_mixer_interface *mixer)
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
