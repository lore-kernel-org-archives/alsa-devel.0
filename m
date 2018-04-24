From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 3/4] ALSA: usb-audio: Use Class Specific EP
	for UAC3 devices.
Date: Tue, 24 Apr 2018 18:24:44 +0100
Message-ID: <20180424172445.31928-4-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 23FE12676AB
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 19:24:57 +0200 (CEST)
In-Reply-To: <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

bmAtributes offset doesn't exist in the UAC3 CS_EP descriptor.
Hence, checking for pitch control as if it was UAC2 doesn't make
any sense. Use the defined UAC3 offsets instead.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/stream.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 956be9f7c72a..5ed334575fc7 100644
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
