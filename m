From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Revert "ALSA: usb-audio: purge needless
	variable length array"
Date: Tue, 30 May 2017 23:19:39 +0200
Message-ID: <20170530211939.3403-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BAA72668BF
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 23:19:43 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7A691ABF2
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 21:19:43 +0000 (UTC)
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

This reverts commit 89b593c30e83 ("ALSA: usb-audio: purge needless
variable length array").  The patch turned out to cause a severe
regression, triggering an Oops at snd_usb_ctl_msg().  It was overseen
that snd_usb_ctl_msg() writes back the response to the given buffer,
while the patch changed it to a read-only const buffer.  (One should
always double-check when an extra pointer cast is present...)

As a simple fix, just revert the affected commit.  It was merely a
cleanup.  Although it brings VLA again, it's clearer as a fix.  We'll
address the VLA later in another patch.

Fixes: 89b593c30e83 ("ALSA: usb-audio: purge needless variable length array")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195875
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_us16x08.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index dc48eedea92e..29d2c9282987 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -698,12 +698,12 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
 	u8 meter_urb[64];
-	char tmp[sizeof(mix_init_msg2)] = {0};
+	char tmp[max(sizeof(mix_init_msg1), sizeof(mix_init_msg2))];
 
 	switch (kcontrol->private_value) {
 	case 0:
-		snd_us16x08_send_urb(chip, (char *)mix_init_msg1,
-				     sizeof(mix_init_msg1));
+		memcpy(tmp, mix_init_msg1, sizeof(mix_init_msg1));
+		snd_us16x08_send_urb(chip, tmp, 4);
 		snd_us16x08_recv_urb(chip, meter_urb,
 			sizeof(meter_urb));
 		kcontrol->private_value++;
@@ -721,7 +721,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	case 3:
 		memcpy(tmp, mix_init_msg2, sizeof(mix_init_msg2));
 		tmp[2] = snd_get_meter_comp_index(store);
-		snd_us16x08_send_urb(chip, tmp, sizeof(mix_init_msg2));
+		snd_us16x08_send_urb(chip, tmp, 10);
 		snd_us16x08_recv_urb(chip, meter_urb,
 			sizeof(meter_urb));
 		kcontrol->private_value = 0;
-- 
2.13.0
