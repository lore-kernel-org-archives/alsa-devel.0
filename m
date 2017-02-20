From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: usb-audio: purge needless variable
	length array
Date: Tue, 21 Feb 2017 05:09:18 +0900
Message-ID: <20170220200921.824-3-o-takashi@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 21141266B38
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 21:09:27 +0100 (CET)
In-Reply-To: <20170220200921.824-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: onkel@paraair.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Variable length array is used in 'snd_us16x08_meter_get()', while there
is logically no need. It's better to purge it because variable length array
has overhead for stack handling.

This commit replaces the array with static length. Sparse generated below
warning.

sound/usb/mixer_us16x08.c:714:18: warning: Variable length array is used.

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/mixer_us16x08.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 019336f..d135e2e 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -711,7 +711,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
 	u8 meter_urb[64];
-	char tmp[max(sizeof(mix_init_msg1), sizeof(mix_init_msg2))];
+	char tmp[sizeof(mix_init_msg2)] = {0};
 
 	if (elem) {
 		store = (struct snd_us16x08_meter_store *) elem->private_data;
@@ -721,8 +721,8 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 
 	switch (kcontrol->private_value) {
 	case 0:
-		memcpy(tmp, mix_init_msg1, sizeof(mix_init_msg1));
-		snd_us16x08_send_urb(chip, tmp, 4);
+		snd_us16x08_send_urb(chip, (char *)mix_init_msg1,
+				     sizeof(mix_init_msg1));
 		snd_us16x08_recv_urb(chip, meter_urb,
 			sizeof(meter_urb));
 		kcontrol->private_value++;
@@ -740,7 +740,8 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	case 3:
 		memcpy(tmp, mix_init_msg2, sizeof(mix_init_msg2));
 		tmp[2] = snd_get_meter_comp_index(store);
-		snd_us16x08_send_urb(chip, tmp, 10);
+		snd_us16x08_send_urb(chip, (char *)mix_init_msg2,
+				     sizeof(mix_init_msg2));
 		snd_us16x08_recv_urb(chip, meter_urb,
 			sizeof(meter_urb));
 		kcontrol->private_value = 0;
-- 
2.9.3
