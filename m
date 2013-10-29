From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/10] ALSA: Use strlcpy() instead of strncpy()
Date: Tue, 29 Oct 2013 17:00:27 +0100
Message-ID: <1383062433-9388-5-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 065982616C2
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:49 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AAE82A611E
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
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

We tend to make stupid mistakes with strncpy().  Let's take a safer
one, strlcpy().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/arm/pxa2xx-ac97.c                  | 2 +-
 sound/i2c/other/ak4xxx-adda.c            | 2 +-
 sound/pci/cs5535audio/cs5535audio_olpc.c | 4 ++--
 sound/pci/ice1712/psc724.c               | 4 ++--
 sound/pci/ice1712/wm8776.c               | 2 +-
 sound/pci/rme9652/hdspm.c                | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 5066a3768b28..9a2ac1e0f77a 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -185,7 +185,7 @@ static int pxa2xx_ac97_probe(struct platform_device *dev)
 		goto err;
 
 	card->dev = &dev->dev;
-	strncpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
+	strlcpy(card->driver, dev->dev.driver->name, sizeof(card->driver));
 
 	ret = pxa2xx_pcm_new(card, &pxa2xx_ac97_pcm_client, &pxa2xx_ac97_pcm);
 	if (ret)
diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index ed726d1569e8..f3735e64791c 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -583,7 +583,7 @@ static int ak4xxx_capture_source_info(struct snd_kcontrol *kcontrol,
 	if (idx >= num_names)
 		return -EINVAL;
 	input_names = ak->adc_info[mixer_ch].input_names;
-	strncpy(uinfo->value.enumerated.name, input_names[idx],
+	strlcpy(uinfo->value.enumerated.name, input_names[idx],
 		sizeof(uinfo->value.enumerated.name));
 	return 0;
 }
diff --git a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
index da1cb9c4c76c..e6a44507d557 100644
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c
@@ -161,13 +161,13 @@ int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
 	/* drop the original AD1888 HPF control */
 	memset(&elem, 0, sizeof(elem));
 	elem.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	strncpy(elem.name, "High Pass Filter Enable", sizeof(elem.name));
+	strlcpy(elem.name, "High Pass Filter Enable", sizeof(elem.name));
 	snd_ctl_remove_id(card, &elem);
 
 	/* drop the original V_REFOUT control */
 	memset(&elem, 0, sizeof(elem));
 	elem.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	strncpy(elem.name, "V_REFOUT Enable", sizeof(elem.name));
+	strlcpy(elem.name, "V_REFOUT Enable", sizeof(elem.name));
 	snd_ctl_remove_id(card, &elem);
 
 	/* add the OLPC-specific controls */
diff --git a/sound/pci/ice1712/psc724.c b/sound/pci/ice1712/psc724.c
index 302ac6ddd545..4019cf27d117 100644
--- a/sound/pci/ice1712/psc724.c
+++ b/sound/pci/ice1712/psc724.c
@@ -203,12 +203,12 @@ static void psc724_set_jack_state(struct snd_ice1712 *ice, bool hp_connected)
 	/* notify about master speaker mute change */
 	memset(&elem_id, 0, sizeof(elem_id));
 	elem_id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	strncpy(elem_id.name, "Master Speakers Playback Switch",
+	strlcpy(elem_id.name, "Master Speakers Playback Switch",
 						sizeof(elem_id.name));
 	kctl = snd_ctl_find_id(ice->card, &elem_id);
 	snd_ctl_notify(ice->card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
 	/* and headphone mute change */
-	strncpy(elem_id.name, spec->wm8776.ctl[WM8776_CTL_HP_SW].name,
+	strlcpy(elem_id.name, spec->wm8776.ctl[WM8776_CTL_HP_SW].name,
 						sizeof(elem_id.name));
 	kctl = snd_ctl_find_id(ice->card, &elem_id);
 	snd_ctl_notify(ice->card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
diff --git a/sound/pci/ice1712/wm8776.c b/sound/pci/ice1712/wm8776.c
index a3c05fe5daf9..5227cb08247f 100644
--- a/sound/pci/ice1712/wm8776.c
+++ b/sound/pci/ice1712/wm8776.c
@@ -52,7 +52,7 @@ static void snd_wm8776_activate_ctl(struct snd_wm8776 *wm,
 	unsigned int index_offset;
 
 	memset(&elem_id, 0, sizeof(elem_id));
-	strncpy(elem_id.name, ctl_name, sizeof(elem_id.name));
+	strlcpy(elem_id.name, ctl_name, sizeof(elem_id.name));
 	elem_id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	kctl = snd_ctl_find_id(card, &elem_id);
 	if (!kctl)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 2907e68150cb..e98dc008de0b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6400,7 +6400,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 		memset(&hdspm_version, 0, sizeof(hdspm_version));
 
 		hdspm_version.card_type = hdspm->io_type;
-		strncpy(hdspm_version.cardname, hdspm->card_name,
+		strlcpy(hdspm_version.cardname, hdspm->card_name,
 				sizeof(hdspm_version.cardname));
 		hdspm_version.serial = hdspm->serial;
 		hdspm_version.firmware_rev = hdspm->firmware_rev;
-- 
1.8.4.1
