From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 8/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:51:36 -0500
Message-ID: <1108515096.3772.40.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lsNjwcVk38kcm3HnSXFW"
In-Reply-To: <1108514291.3772.19.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-lsNjwcVk38kcm3HnSXFW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Add mixer controls for the multichannel device.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-lsNjwcVk38kcm3HnSXFW
Content-Disposition: attachment; filename=emumixer.c.patch
Content-Type: text/x-patch; name=emumixer.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.29
diff -u -r1.29 emumixer.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/emumixer.c	10 Feb 2005 11:52:51 -0000	1.29
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/emumixer.c	15 Feb 2005 23:51:22 -0000
@@ -224,6 +224,8 @@
 	}
 }
 
+/* PCM stream controls */
+
 static int snd_emu10k1_send_routing_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
@@ -430,6 +432,190 @@
 	.put =          snd_emu10k1_attn_put
 };
 
+/* Mutichannel PCM stream controls */
+
+static int snd_emu10k1_efx_send_routing_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = emu->audigy ? 8 : 4;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = emu->audigy ? 0x3f : 0x0f;
+	return 0;
+}
+
+static int snd_emu10k1_efx_send_routing_get(snd_kcontrol_t * kcontrol,
+                                        snd_ctl_elem_value_t * ucontrol)
+{
+	unsigned long flags;
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
+	int idx;
+	int num_efx = emu->audigy ? 8 : 4;
+	int mask = emu->audigy ? 0x3f : 0x0f;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	for (idx = 0; idx < num_efx; idx++)
+		ucontrol->value.integer.value[idx] = 
+			mix->send_routing[0][idx] & mask;
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return 0;
+}
+
+static int snd_emu10k1_efx_send_routing_put(snd_kcontrol_t * kcontrol,
+                                        snd_ctl_elem_value_t * ucontrol)
+{
+	unsigned long flags;
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	int ch = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[ch];
+	int change = 0, idx, val;
+	int num_efx = emu->audigy ? 8 : 4;
+	int mask = emu->audigy ? 0x3f : 0x0f;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	for (idx = 0; idx < num_efx; idx++) {
+		val = ucontrol->value.integer.value[idx] & mask;
+		if (mix->send_routing[0][idx] != val) {
+			mix->send_routing[0][idx] = val;
+			change = 1;
+		}
+	}	
+	if (change && mix->epcm->voices[ch])
+		update_emu10k1_fxrt(emu, mix->epcm->voices[ch]->number,
+				    &mix->send_routing[0][0]);
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return change;
+}
+
+static snd_kcontrol_new_t snd_emu10k1_efx_send_routing_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         "Multichannel PCM Send Routing",
+	.count =	16,
+	.info =         snd_emu10k1_efx_send_routing_info,
+	.get =          snd_emu10k1_efx_send_routing_get,
+	.put =          snd_emu10k1_efx_send_routing_put
+};
+
+static int snd_emu10k1_efx_send_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = emu->audigy ? 8 : 4;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 255;
+	return 0;
+}
+
+static int snd_emu10k1_efx_send_volume_get(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	unsigned long flags;
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
+	int idx;
+	int num_efx = emu->audigy ? 8 : 4;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	for (idx = 0; idx < num_efx; idx++)
+		ucontrol->value.integer.value[idx] = mix->send_volume[0][idx];
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return 0;
+}
+
+static int snd_emu10k1_efx_send_volume_put(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	unsigned long flags;
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	int ch = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[ch];
+	int change = 0, idx, val;
+	int num_efx = emu->audigy ? 8 : 4;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	for (idx = 0; idx < num_efx; idx++) {
+		val = ucontrol->value.integer.value[idx] & 255;
+		if (mix->send_volume[0][idx] != val) {
+			mix->send_volume[0][idx] = val;
+			change = 1;
+		}
+	}
+	if (change && mix->epcm->voices[ch])
+		update_emu10k1_send_volume(emu, mix->epcm->voices[ch]->number,
+					   &mix->send_volume[0][0]);
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return change;
+}
+
+
+static snd_kcontrol_new_t snd_emu10k1_efx_send_volume_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         "Multichannel PCM Send Volume",
+	.count =	16,
+	.info =         snd_emu10k1_efx_send_volume_info,
+	.get =          snd_emu10k1_efx_send_volume_get,
+	.put =          snd_emu10k1_efx_send_volume_put
+};
+
+static int snd_emu10k1_efx_attn_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xffff;
+	return 0;
+}
+
+static int snd_emu10k1_efx_attn_get(snd_kcontrol_t * kcontrol,
+                                snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
+	unsigned long flags;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	ucontrol->value.integer.value[0] = mix->attn[0];
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return 0;
+}
+
+static int snd_emu10k1_efx_attn_put(snd_kcontrol_t * kcontrol,
+				snd_ctl_elem_value_t * ucontrol)
+{
+	unsigned long flags;
+	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
+	int ch = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[ch];
+	int change = 0, val;
+
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	val = ucontrol->value.integer.value[0] & 0xffff;
+	if (mix->attn[0] != val) {
+		mix->attn[0] = val;
+		change = 1;
+	}
+	if (change && mix->epcm->voices[ch])
+		snd_emu10k1_ptr_write(emu, VTFT_VOLUMETARGET, mix->epcm->voices[ch]->number, mix->attn[0]);
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return change;
+}
+
+static snd_kcontrol_new_t snd_emu10k1_efx_attn_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =         "Multichannel PCM Volume",
+	.count =	16,
+	.info =         snd_emu10k1_efx_attn_info,
+	.get =          snd_emu10k1_efx_attn_get,
+	.put =          snd_emu10k1_efx_attn_put
+};
+
 static int snd_emu10k1_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -663,7 +849,22 @@
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
 
-	/* intiailize the routing and volume table for each pcm playback stream */
+	if ((kctl = emu->ctl_efx_send_routing = snd_ctl_new1(&snd_emu10k1_efx_send_routing_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	
+	if ((kctl = emu->ctl_efx_send_volume = snd_ctl_new1(&snd_emu10k1_efx_send_volume_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	
+	if ((kctl = emu->ctl_efx_attn = snd_ctl_new1(&snd_emu10k1_efx_attn_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+
+	/* initialize the routing and volume table for each pcm playback stream */
 	for (pcm = 0; pcm < 32; pcm++) {
 		emu10k1_pcm_mixer_t *mix;
 		int v;
@@ -683,6 +884,28 @@
 		mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
 	}
 	
+	/* initialize the routing and volume table for the multichannel playback stream */
+	for (pcm = 0; pcm < NUM_EFX_PLAYBACK; pcm++) {
+		emu10k1_pcm_mixer_t *mix;
+		int v;
+		
+		mix = &emu->efx_pcm_mixer[pcm];
+		mix->epcm = NULL;
+
+		mix->send_routing[0][0] = pcm;
+		mix->send_routing[0][1] = (pcm == 0) ? 1 : 0;
+		for (v = 0; v < 2; v++)
+			mix->send_routing[0][2+v] = 13+v;
+		if (emu->audigy)
+			for (v = 0; v < 4; v++)
+				mix->send_routing[0][4+v] = 60+v;
+		
+		memset(&mix->send_volume, 0, sizeof(mix->send_volume));
+		mix->send_volume[0][0]  = 255;
+		
+		mix->attn[0] = 0xffff;
+	}
+	
 	if (! emu->APS) { /* FIXME: APS has these controls? */
 		/* sb live! and audigy */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu)) == NULL)

--=-lsNjwcVk38kcm3HnSXFW--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
