From: Ian Douglas Scott <ian@iandouglasscott.com>
Subject: [PATCH v2] ALSA: usb-audio: Support changing input on
	Sound Blaster E1
Date: Tue, 16 Jan 2018 15:34:50 -0800
Message-ID: <20180116233450.11479-1-ian@iandouglasscott.com>
References: <20180116043827.22584-1-ian@iandouglasscott.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iandouglasscott.com (iandouglasscott.com [104.156.231.7])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BA0C266F5F
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 00:36:30 +0100 (CET)
In-Reply-To: <20180116043827.22584-1-ian@iandouglasscott.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Detlef Urban <onkel@paraair.de>, Bhumika Goyal <bhumirks@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Ian Douglas Scott <ian@iandouglasscott.com>
List-Id: alsa-devel@alsa-project.org

The E1 has two headphone jacks, one of which can be set as a microphone
input. In the default mode, it uses the built-in microphone as an input.
By sending a special command, the second headphone jack is instead used
as an input.

This might work with the E3 as well, but I don't have one of those to
test it.

Signed-off-by: Ian Douglas Scott <ian@iandouglasscott.com>
---
 sound/usb/mixer_quirks.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index e1e7ce9ab217..e6359d341878 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -27,6 +27,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/hid.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -1721,6 +1722,83 @@ static int snd_microii_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* Creative Sound Blaster E1 */
+
+static int snd_soundblaster_e1_switch_get(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value;
+	return 0;
+}
+
+static int snd_soundblaster_e1_switch_update(struct usb_mixer_interface *mixer,
+					     unsigned char state)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	int err;
+	unsigned char buff[2];
+
+	buff[0] = 0x02;
+	buff[1] = state ? 0x02 : 0x00;
+
+	err = snd_usb_lock_shutdown(chip);
+	if (err < 0)
+		return err;
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_sndctrlpipe(chip->dev, 0), HID_REQ_SET_REPORT,
+			USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+			0x0202, 3, buff, 2);
+	snd_usb_unlock_shutdown(chip);
+	return err;
+}
+
+static int snd_soundblaster_e1_switch_put(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	unsigned char value = !!ucontrol->value.integer.value[0];
+	int err;
+
+	if (kcontrol->private_value == value)
+		return 0;
+	kcontrol->private_value = value;
+	err = snd_soundblaster_e1_switch_update(list->mixer, value);
+	return err < 0 ? err : 1;
+}
+
+static int snd_soundblaster_e1_switch_resume(struct usb_mixer_elem_list *list)
+{
+	return snd_soundblaster_e1_switch_update(list->mixer,
+						 list->kctl->private_value);
+}
+
+static int snd_soundblaster_e1_switch_info(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const texts[2] = {
+		"Mic", "Aux"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
+}
+
+static struct snd_kcontrol_new snd_soundblaster_e1_input_switch = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Input Source",
+	.info = snd_soundblaster_e1_switch_info,
+	.get = snd_soundblaster_e1_switch_get,
+	.put = snd_soundblaster_e1_switch_put,
+	.private_value = 0,
+};
+
+static int snd_soundblaster_e1_switch_create(struct usb_mixer_interface *mixer)
+{
+	return add_single_ctl_with_resume(mixer, 0,
+					  snd_soundblaster_e1_switch_resume,
+					  &snd_soundblaster_e1_input_switch,
+					  NULL);
+}
+
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 {
 	int err = 0;
@@ -1802,6 +1880,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x1235, 0x800c): /* Focusrite Scarlett 18i20 */
 		err = snd_scarlett_controls_create(mixer);
 		break;
+
+	case USB_ID(0x041e, 0x323b): /* Creative Sound Blaster E1 */
+		err = snd_soundblaster_e1_switch_create(mixer);
+		break;
 	}
 
 	return err;
-- 
2.15.1
