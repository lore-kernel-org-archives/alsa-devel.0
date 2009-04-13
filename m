From: renidragsemaj@yahoo.com
Subject: [PATCH - patch_sigmatel.c for HP dv4-1222nr laptop
	9/9Patch to patch_sigmatel.c for HP dv4-1222nr laptop
Date: Mon, 13 Apr 2009 17:43:19 -0400
Message-ID: <1239658999-8196-1-git-send-email-renidragsemaj@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: James Gardiner <renidragsemaj@yahoo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: James Gardiner <renidragsemaj@yahoo.com>

This patch to patch_sigmatel.c is for the HP dv4-1222nr laptop. It
activates the included microphone(s) and the mute status change light
for this computer. I don't know if this will work for any other dv4
laptop. The commit isn't perfect, for it doesn't seem to work too well
with pulseaudio - the mic boost doesn't work with that audioserver.
Otherwise, it works well with esound, even across reboots and
suspend/hibernate/resume. The built-in microphone sits on node 0x18 and
feeds through node 0x1c. The gpio for the mute light is GPIO #0. I
borrowed the code from the HP HDX. Occasionally if you press the mute
button too fast in succession it lowers the actual volume to 0 and
you'll have to adjust it again...But if you are doing that you probably
are getting a kick out of making me feel bad about the behavior. :) No
autodetect of the laptop seems to work for me, but "model=hp-dv4-1222nr"
as an option to modprobe will make the changes.

Signed-off-by: James Gardiner <renidragsemaj@yahoo.com>

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 61996a2..4286155 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -100,6 +100,7 @@ enum {
 	STAC_HP_M4,
 	STAC_HP_DV5,
 	STAC_HP_HDX,
+	STAC_HP_DV4_1222NR,
 	STAC_92HD71BXX_MODELS
 };
 
@@ -1847,6 +1848,7 @@ static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
 	[STAC_HP_M4] = "hp-m4",
 	[STAC_HP_DV5] = "hp-dv5",
 	[STAC_HP_HDX] = "hp-hdx",
+	[STAC_HP_DV4_1222NR] = "hp-dv4-1222nr",
 };
 
 static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
@@ -4534,6 +4536,28 @@ static int stac92xx_hp_hdx_check_power_status(struct hda_codec *codec,
 }
 #endif
 
+static int stac92xx_hp_dv4_1222nr_check_power_status(struct hda_codec *codec,
+						     hda_nid_t nid)
+{
+  /* Shamelessly stolen from the function stac92xx_hp_hdx_check_power_status */
+  /* by James Gardiner */
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (nid == 0x10) {
+		if (snd_hda_codec_amp_read(codec, nid, 0, HDA_OUTPUT, 0) &
+		    HDA_AMP_MUTE)
+			spec->gpio_data &= ~0x01;  /* orange */
+		else
+			spec->gpio_data |= 0x01;   /* white */
+
+		stac_gpio_set(codec, spec->gpio_mask,
+			    spec->gpio_dir,
+			    spec->gpio_data);
+	}
+
+	return 0;
+}
+
 static int stac92xx_suspend(struct hda_codec *codec, pm_message_t state)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -5202,6 +5226,19 @@ again:
 		spec->num_smuxes = 0;
 		spec->num_dmuxes = 1;
 		break;
+	case STAC_HP_DV4_1222NR: /* James Gardiner */
+		spec->num_dmics = 1;
+		spec->num_dmuxes = 2;
+		stac92xx_auto_set_pinctl(codec, 0x1c, 2);
+		stac92xx_auto_set_pinctl(codec, 0x18, AC_PINCTL_IN_EN);
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+		spec->gpio_mask |= 0x01;
+		spec->gpio_dir  |= 0x01;
+		spec->gpio_data |= 0x01;
+		codec->patch_ops.check_power_status =
+		    stac92xx_hp_dv4_1222nr_check_power_status;
+#endif
+		/* fallthrough */
 	case STAC_HP_DV5:
 		snd_hda_codec_set_pincfg(codec, 0x0d, 0x90170010);
 		stac92xx_auto_set_pinctl(codec, 0x0d, AC_PINCTL_OUT_EN);
-- 
1.5.6.3
