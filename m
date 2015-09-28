From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: usb-audio: harmless underflow in
 snd_audigy2nx_led_put()
Date: Mon, 28 Sep 2015 13:06:20 +0300
Message-ID: <20150928100620.GA12060@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Damien Zammit <damien@zamaudio.com>, "Dmitry M. Fedin" <dmitry.fedin@gmail.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We want to verify that "value" is either zero or one, so we test if it
is greater than one.  Unfortunately, this is a signed int so it could
also be negative.  I think this is harmless but it introduces a static
checker warning.  Let's make "value" unsigned.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 337c317..4602a78 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -340,7 +340,7 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	struct usb_mixer_interface *mixer = list->mixer;
 	int index = kcontrol->private_value & 0xff;
-	int value = ucontrol->value.integer.value[0];
+	unsigned int value = ucontrol->value.integer.value[0];
 	int old_value = kcontrol->private_value >> 8;
 	int err;
 
