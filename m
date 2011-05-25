From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/5] ALSA: usb-audio: add new quirk type
	QUIRK_AUDIO_STANDARD_MIXER
Date: Wed, 25 May 2011 09:09:02 +0200
Message-ID: <1306307343-3247-5-git-send-email-zonque@gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id B0B0A10381B
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:09:33 +0200 (CEST)
In-Reply-To: <1306307343-3247-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, gdiffey@gmail.com, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This quirk type will let the driver assume that there is a standard
mixer on a given interface, or that a specific mixer quirks will handle
the device.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/quirks.c   |   17 ++++++++++++++++-
 sound/usb/usbaudio.h |    1 +
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2546dc8..2e969cb 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -264,6 +264,20 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 }
 
 /*
+ * Create a standard mixer for the specified interface.
+ */
+static int create_standard_mixer_quirk(struct snd_usb_audio *chip,
+				       struct usb_interface *iface,
+				       struct usb_driver *driver,
+				       const struct snd_usb_audio_quirk *quirk)
+{
+	if (quirk->ifnum < 0)
+		return 0;
+
+	return snd_usb_create_mixer(chip, quirk->ifnum, 0);
+}
+
+/*
  * audio-interface quirks
  *
  * returns zero if no standard audio/MIDI parsing is needed.
@@ -295,7 +309,8 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
-		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk
+		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
+		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
 	};
 
 	if (quirk->type < QUIRK_TYPE_COUNT) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 32f2a97..1e79986 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -84,6 +84,7 @@ enum quirk_type {
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
+	QUIRK_AUDIO_STANDARD_MIXER,
 
 	QUIRK_TYPE_COUNT
 };
-- 
1.7.5.1
