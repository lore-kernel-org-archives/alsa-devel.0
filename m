From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v4 2/4] ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
Date: Fri, 11 May 2018 16:25:35 +0100
Message-ID: <20180511152537.32267-3-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, ruslan.bilovol@gmail.com, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
Hence, checking for pitch control as if it was UAC2 doesn't make
any sense. Use the defined UAC3 offsets instead.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/stream.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 764be07474a8..6b2924533d8d 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -576,7 +576,7 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 
 	if (protocol == UAC_VERSION_1) {
 		attributes = csep->bmAttributes;
-	} else {
+	} else if (protocol == UAC_VERSION_2) {
 		struct uac2_iso_endpoint_descriptor *csep2 =
 			(struct uac2_iso_endpoint_descriptor *) csep;
 
@@ -585,6 +585,13 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		/* emulate the endpoint attributes of a v1 device */
 		if (csep2->bmControls & UAC2_CONTROL_PITCH)
 			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
+	} else { /* UAC_VERSION_3 */
+		struct uac3_iso_endpoint_descriptor *csep3 =
+			(struct uac3_iso_endpoint_descriptor *) csep;
+
+		/* emulate the endpoint attributes of a v1 device */
+		if (le32_to_cpu(csep3->bmControls) & UAC2_CONTROL_PITCH)
+			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
 	}
 
 	return attributes;
-- 
2.11.0
