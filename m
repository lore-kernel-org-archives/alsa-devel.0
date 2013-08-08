From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: usb-audio: do not trust too-big
	wMaxPacketSize values
Date: Thu, 08 Aug 2013 11:24:55 +0200
Message-ID: <520363E7.8080503@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 160932617BB
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2013 11:25:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: James Stone <jamesmstone@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The driver used to assume that the streaming endpoint's wMaxPacketSize
value would be an indication of how much data the endpoint expects or
sends, and compute the number of packets per URB using this value.

However, the Focusrite Scarlett 2i4 declares a value of 1024 bytes,
while only about 88 or 44 bytes are be actually used.  This discrepancy
would result in URBs with far too few packets, which would not work
correctly on the EHCI driver.

To get correct URBs, use wMaxPacketSize only as an upper limit on the
packet size.

Reported-by: James Stone <jamesmstone@gmail.com>
Tested-by: James Stone <jamesmstone@gmail.com>
Cc: <stable@vger.kernel.org> # 2.6.35+
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/endpoint.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -591,17 +591,16 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	ep->stride = frame_bits >> 3;
 	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;

-	/* calculate max. frequency */
-	if (ep->maxpacksize) {
+	/* assume max. frequency is 25% higher than nominal */
+	ep->freqmax = ep->freqn + (ep->freqn >> 2);
+	maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
+				>> (16 - ep->datainterval);
+	/* but wMaxPacketSize might reduce this */
+	if (ep->maxpacksize && ep->maxpacksize < maxsize) {
 		/* whatever fits into a max. size packet */
 		maxsize = ep->maxpacksize;
 		ep->freqmax = (maxsize / (frame_bits >> 3))
 				<< (16 - ep->datainterval);
-	} else {
-		/* no max. packet size: just take 25% higher than nominal */
-		ep->freqmax = ep->freqn + (ep->freqn >> 2);
-		maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
-				>> (16 - ep->datainterval);
 	}

 	if (ep->fill_max)
