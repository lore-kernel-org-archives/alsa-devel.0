From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v1 4/6] ALSA: usb: Only get AudioControl header
	for UAC1 class.
Date: Tue, 19 Dec 2017 09:14:09 +0000
Message-ID: <20171219091411.16267-5-jorge.sanjuan@codethink.co.uk>
References: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 179DA26698E
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:14:17 +0100 (CET)
In-Reply-To: <20171219091411.16267-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, ci005-internal@lists.codethink.co.uk
List-Id: alsa-devel@alsa-project.org

The control header needs to be read from buffer at this point only
in the case of UAC1 protocol. Move it inside the switch case as other
protocols such as the Basic Audio Device spec will have an empty buffer
that is latter filled as inferred.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/card.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 24cfb4bc5ed6..f5f385b0a32e 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -221,21 +221,13 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	struct usb_device *dev = chip->dev;
 	struct usb_host_interface *host_iface;
 	struct usb_interface_descriptor *altsd;
-	void *control_header;
 	int i, protocol;
 
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
@@ -245,7 +237,15 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 		/* fall through */
 
 	case UAC_VERSION_1: {
-		struct uac1_ac_header_descriptor *h1 = control_header;
+		struct uac1_ac_header_descriptor *h1;
+
+		h1 = snd_usb_find_csint_desc(host_iface->extra,
+							 host_iface->extralen,
+							 NULL, UAC_HEADER);
+		if (!h1) {
+			dev_err(&dev->dev, "cannot find UAC_HEADER\n");
+			return -EINVAL;
+		}
 
 		if (!h1->bInCollection) {
 			dev_info(&dev->dev, "skipping empty audio interface (v1)\n");
-- 
2.11.0
