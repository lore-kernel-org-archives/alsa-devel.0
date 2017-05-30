From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: usb: Avoid VLA in mixer_us16x08.c
Date: Tue, 30 May 2017 23:29:59 +0200
Message-ID: <20170530212959.5975-2-tiwai@suse.de>
References: <20170530212959.5975-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 29156266A89
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 23:30:02 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B12A8ABF7
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 21:30:02 +0000 (UTC)
In-Reply-To: <20170530212959.5975-1-tiwai@suse.de>
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

This is another attempt to work around the VLA used in
mixer_us16x08.c.  Basically the temporary array is used individually
for two cases, and we can declare locally in each block, instead of
hackish max() usage.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_us16x08.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 442d8f7998e3..26ed23b18b77 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -698,16 +698,18 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
 	u8 meter_urb[64];
-	char tmp[max(sizeof(mix_init_msg1), sizeof(mix_init_msg2))];
 
 	switch (kcontrol->private_value) {
-	case 0:
+	case 0: {
+		char tmp[sizeof(mix_init_msg1)];
+
 		memcpy(tmp, mix_init_msg1, sizeof(mix_init_msg1));
 		snd_us16x08_send_urb(chip, tmp, 4);
 		snd_us16x08_recv_urb(chip, meter_urb,
 			sizeof(meter_urb));
 		kcontrol->private_value++;
 		break;
+	}
 	case 1:
 		snd_us16x08_recv_urb(chip, meter_urb,
 			sizeof(meter_urb));
@@ -718,7 +720,9 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 			sizeof(meter_urb));
 		kcontrol->private_value++;
 		break;
-	case 3:
+	case 3: {
+		char tmp[sizeof(mix_init_msg2)];
+
 		memcpy(tmp, mix_init_msg2, sizeof(mix_init_msg2));
 		tmp[2] = snd_get_meter_comp_index(store);
 		snd_us16x08_send_urb(chip, tmp, 10);
@@ -727,6 +731,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 		kcontrol->private_value = 0;
 		break;
 	}
+	}
 
 	for (set = 0; set < 6; set++)
 		get_meter_levels_from_urb(set, store, meter_urb);
-- 
2.13.0
