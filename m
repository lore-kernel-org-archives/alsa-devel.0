From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 13/31] HDA patch_via.c: Refresh front
	playback mute if hp plug-in mutes speaker.
Date: Thu, 8 Oct 2009 13:32:58 +0800
Message-ID: <16685ee0910072232i7e929170k9e70643c56fafd94@mail.gmail.com>
References: <16685ee0910050727k72411ca7kd80cbb8eb6771f6e@mail.gmail.com>
	<s5h8wfp6fq9.wl%tiwai@suse.de>
	<16685ee0910052210w41bd590fy6cfd75d38580f0bf@mail.gmail.com>
	<s5hiqetrrv9.wl%tiwai@suse.de>
	<16685ee0910061037x3a118a9ay6bdb385e89b1b260@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id D5897103952
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:32:58 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5184189fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:32:58 -0700 (PDT)
In-Reply-To: <16685ee0910061037x3a118a9ay6bdb385e89b1b260@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Refresh front playback mute if hp plug-in mutes speaker.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1351,14 +1351,25 @@
 /* mute internal speaker if HP is plugged */
 static void via_hp_automute(struct hda_codec *codec)
 {
-	unsigned int present;
+	unsigned int present = 0;
 	struct via_spec *spec = codec->spec;

 	present = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	snd_hda_codec_amp_stereo(codec, spec->autocfg.line_out_pins[0],
-				 HDA_OUTPUT, 0, HDA_AMP_MUTE,
-				 present ? HDA_AMP_MUTE : 0);
+
+	if (!spec->hp_independent_mode) {
+		struct snd_ctl_elem_id id;
+		/* auto mute */
+		snd_hda_codec_amp_stereo(
+			codec, spec->autocfg.line_out_pins[0], HDA_OUTPUT, 0,
+			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+		/* notify change */
+		memset(&id, 0, sizeof(id));
+		id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		strcpy(id.name, "Front Playback Switch");
+		snd_ctl_notify(codec->bus->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &id);
+	}
 }

 static void via_gpio_control(struct hda_codec *codec)
