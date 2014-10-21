From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/43] ALSA: ak4xxx-adda: Use
	snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:45 +0200
Message-ID: <1413886279-18704-10-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CE869266639
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0CAF4AD6F
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:23 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
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

... and reduce the open codes.  Also add missing const to the text array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/other/ak4xxx-adda.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index f3735e64791c..67dbfde837ab 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -465,17 +465,10 @@ static int snd_akm4xxx_stereo_volume_put(struct snd_kcontrol *kcontrol,
 static int snd_akm4xxx_deemphasis_info(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {
+	static const char * const texts[4] = {
 		"44.1kHz", "Off", "48kHz", "32kHz",
 	};
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item >= 4)
-		uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 
 static int snd_akm4xxx_deemphasis_get(struct snd_kcontrol *kcontrol,
@@ -570,22 +563,13 @@ static int ak4xxx_capture_source_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_akm4xxx *ak = snd_kcontrol_chip(kcontrol);
 	int mixer_ch = AK_GET_SHIFT(kcontrol->private_value);
-	const char **input_names;
-	unsigned int num_names, idx;
+	unsigned int num_names;
 
 	num_names = ak4xxx_capture_num_inputs(ak, mixer_ch);
 	if (!num_names)
 		return -EINVAL;
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = num_names;
-	idx = uinfo->value.enumerated.item;
-	if (idx >= num_names)
-		return -EINVAL;
-	input_names = ak->adc_info[mixer_ch].input_names;
-	strlcpy(uinfo->value.enumerated.name, input_names[idx],
-		sizeof(uinfo->value.enumerated.name));
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, num_names,
+				 ak->adc_info[mixer_ch].input_names);
 }
 
 static int ak4xxx_capture_source_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
