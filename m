From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: pci: asihpi: Remove unneeded variable change
Date: Fri, 5 Jul 2019 08:27:33 +0530
Message-ID: <20190705025733.GA26285@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Richard Fontana <rfontana@redhat.com>, Colin Ian King <colin.king@canonical.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

this patch fixes below issue reported by coccicheck
sound/pci/asihpi/asihpi.c:1558:5-11: Unneeded variable: "change". Return
"1" on line 1564

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/asihpi/asihpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index e7234f3..2a21a3d 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1519,7 +1519,6 @@ static int snd_asihpi_volume_get(struct snd_kcontrol *kcontrol,
 static int snd_asihpi_volume_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	int change;
 	u32 h_control = kcontrol->private_value;
 	short an_gain_mB[HPI_MAX_CHANNELS];
 
@@ -1530,9 +1529,8 @@ static int snd_asihpi_volume_put(struct snd_kcontrol *kcontrol,
 	/*  change = asihpi->mixer_volume[addr][0] != left ||
 	   asihpi->mixer_volume[addr][1] != right;
 	 */
-	change = 1;
 	hpi_handle_error(hpi_volume_set_gain(h_control, an_gain_mB));
-	return change;
+	return 1;
 }
 
 static const DECLARE_TLV_DB_SCALE(db_scale_100, -10000, VOL_STEP_mB, 0);
@@ -1555,13 +1553,12 @@ static int snd_asihpi_volume_mute_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	u32 h_control = kcontrol->private_value;
-	int change = 1;
 	/* HPI currently only supports all or none muting of multichannel volume
 	ALSA Switch element has opposite sense to HPI mute: on==unmuted, off=muted
 	*/
 	int mute =  ucontrol->value.integer.value[0] ? 0 : HPI_BITMASK_ALL_CHANNELS;
 	hpi_handle_error(hpi_volume_set_mute(h_control, mute));
-	return change;
+	return 1;
 }
 
 static int snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
-- 
2.7.4
