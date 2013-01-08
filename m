From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 061/112] ALSA: hda - Add / fix comments about
	capture vol/sw controls in hda_generic.c
Date: Tue,  8 Jan 2013 12:38:54 +0100
Message-ID: <1357645185-7645-62-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 28FF72651F4
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 43886A52DB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

A bit of details won't hurt.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 3e818b6..f5eb57c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1877,10 +1877,6 @@ static int mux_enum_put(struct snd_kcontrol *kcontrol,
 			  ucontrol->value.enumerated.item[0]);
 }
 
-/*
- * capture volume and capture switch ctls
- */
-
 static const struct snd_kcontrol_new cap_src_temp = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Input Source",
@@ -1889,9 +1885,14 @@ static const struct snd_kcontrol_new cap_src_temp = {
 	.put = mux_enum_put,
 };
 
+/*
+ * capture volume and capture switch ctls
+ */
+
 typedef int (*put_call_t)(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol);
 
+/* call the given amp update function for all amps in the imux list at once */
 static int cap_put_caller(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol,
 			  put_call_t func, int type)
@@ -1905,6 +1906,10 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
 	imux = &spec->input_mux;
 	adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	mutex_lock(&codec->control_mutex);
+	/* we use the cache-only update at first since multiple input paths
+	 * may shared the same amp; by updating only caches, the redundant
+	 * writes to hardware can be reduced.
+	 */
 	codec->cached_write = 1;
 	for (i = 0; i < imux->num_items; i++) {
 		path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
@@ -1919,7 +1924,7 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
  error:
 	codec->cached_write = 0;
 	mutex_unlock(&codec->control_mutex);
-	snd_hda_codec_flush_amp_cache(codec);
+	snd_hda_codec_flush_amp_cache(codec); /* flush the updates */
 	if (err >= 0 && spec->cap_sync_hook)
 		spec->cap_sync_hook(codec);
 	return err;
-- 
1.8.0.1
