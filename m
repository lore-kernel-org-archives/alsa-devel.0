From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 6/6] ALSA: usb: Only get control header for
	UAC1 class.
Date: Wed, 29 Nov 2017 10:55:32 +0000
Message-ID: <20171129105532.15420-7-jorge.sanjuan@codethink.co.uk>
References: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE95267895
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:55:38 +0100 (CET)
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

The control header needs to be read from buffer only in the case
of UAC1 protocol.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/card.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index fa3cabd1cadc..646a0408f809 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -226,16 +226,9 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 
 	/* find audiocontrol interface */
 	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
-	control_header = snd_usb_find_csint_desc(host_iface->extra,
-						 host_iface->extralen,
-						 NULL, UAC_HEADER);
 	altsd = get_iface_desc(host_iface);
 	protocol = altsd->bInterfaceProtocol;
 
-	if (!control_header) {
-		dev_err(&dev->dev, "cannot find UAC_HEADER\n");
-		return -EINVAL;
-	}
 
 	switch (protocol) {
 	default:
@@ -245,7 +238,17 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		/* fall through */
 
 	case UAC_VERSION_1: {
-		struct uac1_ac_header_descriptor *h1 = control_header;
+		struct uac1_ac_header_descriptor *h1;
+
+		control_header = snd_usb_find_csint_desc(host_iface->extra,
+							 host_iface->extralen,
+							 NULL, UAC_HEADER);
+		if (!control_header) {
+			dev_err(&dev->dev, "cannot find UAC_HEADER\n");
+			return -EINVAL;
+		}
+
+		h1 = control_header;
 
 		if (!h1->bInCollection) {
 			dev_info(&dev->dev, "skipping empty audio interface (v1)\n");
-- 
2.11.0
