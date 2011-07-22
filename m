From: linux@audioscience.com
Subject: [PATCH 14/15] ALSA: asihpi - Add volume mute controls
Date: Fri, 22 Jul 2011 15:53:03 +1200
Message-ID: <1311306785-23116-29-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Mute functionality was recently added to the DSP firmware

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 8033d85..47366fb 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1486,11 +1486,48 @@ static int snd_asihpi_volume_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_100, -10000, VOL_STEP_mB, 0);
 
+static int snd_asihpi_volume_mute_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_asihpi_volume_mute_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	u32 h_control = kcontrol->private_value;
+	u32 mute;
+
+	hpi_handle_error(hpi_volume_get_mute(h_control, &mute));
+	ucontrol->value.integer.value[0] = mute ? 0 : 1;
+
+	return 0;
+}
+
+static int snd_asihpi_volume_mute_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	u32 h_control = kcontrol->private_value;
+	int change = 1;
+	/* HPI currently only supports all or none muting of multichannel volume
+	ALSA Switch element has opposite sense to HPI mute: on==unmuted, off=muted
+	*/
+	int mute =  ucontrol->value.integer.value[0] ? 0 : HPI_BITMASK_ALL_CHANNELS;
+	hpi_handle_error(hpi_volume_set_mute(h_control, mute));
+	return change;
+}
+
 static int __devinit snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
+	int err;
+	u32 mute;
 
 	asihpi_ctl_init(&snd_control, hpi_ctl, "Volume");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1500,7 +1537,19 @@ static int __devinit snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
 	snd_control.put = snd_asihpi_volume_put;
 	snd_control.tlv.p = db_scale_100;
 
-	return ctl_add(card, &snd_control, asihpi);
+	err = ctl_add(card, &snd_control, asihpi);
+	if (err)
+		return err;
+
+	if (hpi_volume_get_mute(hpi_ctl->h_control, &mute) == 0) {
+		asihpi_ctl_init(&snd_control, hpi_ctl, "Switch");
+		snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		snd_control.info = snd_asihpi_volume_mute_info;
+		snd_control.get = snd_asihpi_volume_mute_get;
+		snd_control.put = snd_asihpi_volume_mute_put;
+		err = ctl_add(card, &snd_control, asihpi);
+	}
+	return err;
 }
 
 /*------------------------------------------------------------
-- 
1.7.0.4
