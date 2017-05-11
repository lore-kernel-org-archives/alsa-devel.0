From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 01/26] ALSA: hda - Simplify bound-beep mute
	control for ALC268
Date: Thu, 11 May 2017 23:09:00 +0200
Message-ID: <20170511210925.18208-2-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E588266FCD
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:30 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4D6BCAEB0
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

The beep mute switch for ALC268 needs to touch two NIDs, and we used
to apply the bind-mixer stuff.  But the use case for ALC268 is fairly
easy to convert to an open-code in a shorter form.  Since this is the
only user of the bind-ctls, we can clean up the common helper codes
later.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 58df440013c5..87e1368de4d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2573,18 +2573,37 @@ static int patch_alc262(struct hda_codec *codec)
  *  ALC268
  */
 /* bind Beep switches of both NID 0x0f and 0x10 */
-static const struct hda_bind_ctls alc268_bind_beep_sw = {
-	.ops = &snd_hda_bind_sw,
-	.values = {
-		HDA_COMPOSE_AMP_VAL(0x0f, 3, 1, HDA_INPUT),
-		HDA_COMPOSE_AMP_VAL(0x10, 3, 1, HDA_INPUT),
-		0
-	},
-};
+static int alc268_beep_switch_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned long pval;
+	int err;
+
+	mutex_lock(&codec->control_mutex);
+	pval = kcontrol->private_value;
+	kcontrol->private_value = (pval & ~0xff) | 0x0f;
+	err = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+	if (err >= 0) {
+		kcontrol->private_value = (pval & ~0xff) | 0x10;
+		err = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+	}
+	kcontrol->private_value = pval;
+	mutex_unlock(&codec->control_mutex);
+	return err;
+}
 
 static const struct snd_kcontrol_new alc268_beep_mixer[] = {
 	HDA_CODEC_VOLUME("Beep Playback Volume", 0x1d, 0x0, HDA_INPUT),
-	HDA_BIND_SW("Beep Playback Switch", &alc268_bind_beep_sw),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Beep Playback Switch",
+		.subdevice = HDA_SUBDEV_AMP_FLAG,
+		.info = snd_hda_mixer_amp_switch_info,
+		.get = snd_hda_mixer_amp_switch_get,
+		.put = alc268_beep_switch_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x0f, 3, 1, HDA_INPUT)
+	},
 	{ }
 };
 
-- 
2.12.2
