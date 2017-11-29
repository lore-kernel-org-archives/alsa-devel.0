From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 5/6] ALSA: usb: Use Class Specific EP for UAC3
	devices.
Date: Wed, 29 Nov 2017 10:55:31 +0000
Message-ID: <20171129105532.15420-6-jorge.sanjuan@codethink.co.uk>
References: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id B2DAB266E30
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:55:37 +0100 (CET)
In-Reply-To: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
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
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
Hence, checking for pitch control as if it was UAC2 doesn't make
any sense. Use the defined UAC3 offsets instead.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/stream.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8b3565d4ca24..fbc7e056ee88 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -512,9 +512,11 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		return 0;
 	}
 
-	if (protocol == UAC_VERSION_1) {
+	switch (protocol) {
+	case UAC_VERSION_1:
 		attributes = csep->bmAttributes;
-	} else {
+		break;
+	case UAC_VERSION_2: {
 		struct uac2_iso_endpoint_descriptor *csep2 =
 			(struct uac2_iso_endpoint_descriptor *) csep;
 
@@ -523,6 +525,17 @@ static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
 		/* emulate the endpoint attributes of a v1 device */
 		if (csep2->bmControls & UAC2_CONTROL_PITCH)
 			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
+	}
+	case UAC_VERSION_3: {
+		struct uac3_iso_endpoint_descriptor *csep3 =
+			(struct uac3_iso_endpoint_descriptor *) csep;
+
+		/* emulate the endpoint attributes of a v1 device */
+		if (csep3->bmControls & UAC3_CONTROL_PITCH)
+			attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
+	}
 	}
 
 	return attributes;
-- 
2.11.0
