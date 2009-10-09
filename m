From: <LoganLi@viatech.com.cn>
Subject: [PATCH 13/30] ALSA: HDA VIA: Refresh front playback
	mute in via_hp_automute.
Date: Fri, 9 Oct 2009 18:40:34 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C3A@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F25B103B03
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:28 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Refresh front playback mute in via_hp_automute.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -1351,14 +1351,25 @@
 /* mute internal speaker if HP is plugged */
 static void via_hp_automute(struct hda_codec *codec)
 {
-	unsigned int present;
+	unsigned int present = 0;
 	struct via_spec *spec = codec->spec;
 
 	present = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
 				     AC_VERB_GET_PIN_SENSE, 0) &
0x80000000;
-	snd_hda_codec_amp_stereo(codec, spec->autocfg.line_out_pins[0],
-				 HDA_OUTPUT, 0, HDA_AMP_MUTE,
-				 present ? HDA_AMP_MUTE : 0);
+
+	if (!spec->hp_independent_mode) {
+		struct snd_ctl_elem_id id;
+		/* auto mute */
+		snd_hda_codec_amp_stereo(
+			codec, spec->autocfg.line_out_pins[0],
HDA_OUTPUT, 0,
+			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+		/* notify change */
+		memset(&id, 0, sizeof(id));
+		id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		strcpy(id.name, "Front Playback Switch");
+		snd_ctl_notify(codec->bus->card,
SNDRV_CTL_EVENT_MASK_VALUE,
+			       &id);
+	}
 }
 
 static void via_gpio_control(struct hda_codec *codec)
